"""PDF -> Markdown（純 PyMuPDF，不用 AI）。圖片另存成檔案並以連結插入，不做辨識。
usage: python scripts/pdf2md.py in.pdf out.md [first last]   （PDF 頁碼，1 起算）
- 標題：字體明顯大於內文者，依大小給 ## / ###
- 頁碼：頁首／頁尾的數字，標成 <!-- 課本第 N 頁 -->；沒抓到的頁面，用同一份 PDF 最常見的「課本頁碼 − PDF 頁碼」位移補上
- 圖片：存到 out.md 同層的 images/<檔名前綴>/，太小的（裝飾圖示）略過
"""
import collections, os, re, sys
import pymupdf

src, out = sys.argv[1], sys.argv[2]
doc = pymupdf.open(src)
first = int(sys.argv[3]) if len(sys.argv) > 3 else 1
last = int(sys.argv[4]) if len(sys.argv) > 4 else len(doc)
stem = os.path.splitext(os.path.basename(out))[0]
img_rel = f"images/{stem}"
img_dir = os.path.join(os.path.dirname(os.path.abspath(out)), img_rel)
os.makedirs(img_dir, exist_ok=True)
MIN_IMG = 60  # 頁面上的寬、高（pt）都小於此值的圖片視為裝飾

# 內文字級：全文件最常見的字級
sizes = collections.Counter()
for p in range(first - 1, last):
    for b in doc[p].get_text("dict")["blocks"]:
        for l in b.get("lines", []):
            for s in l["spans"]:
                if s["text"].strip():
                    sizes[round(s["size"], 1)] += len(s["text"])
body = sizes.most_common(1)[0][0]


def join_lines(lines):
    out = ""
    for t in lines:
        t = t.strip()
        if not t:
            continue
        if out and re.search(r"[A-Za-z0-9,.;:)]$", out) and re.match(r"[A-Za-z0-9(]", t):
            out += " "
        out += t
    return re.sub(r"[ 　]{2,}", " ", out)


def ordered(blocks, W):
    """左右兩欄：跨欄的區塊當作分隔，分隔之間先排左欄、再排右欄。"""
    mid = W / 2
    def col(b):
        x0, _, x1, _ = b["bbox"]
        if x0 < mid - 20 and x1 > mid + 20:
            return -1  # 跨欄
        return 0 if (x0 + x1) / 2 < mid else 1
    res, seg = [], []
    def flush():
        seg.sort(key=lambda b: (col(b), b["bbox"][1], b["bbox"][0]))
        res.extend(seg); seg.clear()
    for b in sorted(blocks, key=lambda b: (b["bbox"][1], b["bbox"][0])):
        if col(b) == -1:
            flush(); res.append(b)
        else:
            seg.append(b)
    flush()
    return res, col


parts, n_img = [], 0
for p in range(first - 1, last):
    page = doc[p]
    H, W = page.rect.height, page.rect.width
    blocks, col = ordered(page.get_text("dict")["blocks"], W)
    printed, items = None, []   # items: [kind, text, col, y1, size]
    for b in blocks:
        x0, y0, x1, y1 = b["bbox"]
        if b["type"] == 1:  # 圖片
            if (x1 - x0) < MIN_IMG or (y1 - y0) < MIN_IMG:
                continue
            n_img += 1
            name = f"p{p + 1:03d}_{n_img:03d}.{b.get('ext', 'png')}"
            with open(os.path.join(img_dir, name), "wb") as f:
                f.write(b["image"])
            items.append(["img", f"![]({img_rel}/{name})", col(b), y1, 0])
            continue
        lines = ["".join(s["text"] for s in l["spans"]) for l in b["lines"]]
        text = join_lines(lines)
        if not text:
            continue
        if y0 < H * 0.06 or y1 > H * 0.95:   # 頁首／頁尾
            m = re.fullmatch(r"(\d{1,3})(?:\s.*)?|.*\s(\d{1,3})", text)
            if m:
                printed = m.group(1) or m.group(2)
            continue
        size = round(max((s["size"] for l in b["lines"] for s in l["spans"] if s["text"].strip()), default=body), 1)
        if size >= body * 1.8 and len(text) <= 30:
            items.append(["h", f"## {text}", col(b), y1, size]); continue
        if size >= body * 1.25 and len(text) <= 40:
            items.append(["h", f"### {text}", col(b), y1, size]); continue
        prev = items[-1] if items else None
        # 同一欄、同字級、上下緊鄰 -> 合併成同一段
        if prev and prev[0] == "t" and prev[2] == col(b) and prev[4] == size and 0 <= y0 - prev[3] < size * 0.9:
            prev[1] = join_lines([prev[1], text]); prev[3] = y1
        else:
            items.append(["t", text, col(b), y1, size])
    parts.append((p + 1, printed, "\n\n".join(i[1] for i in items)))

# 頁碼位移：課本頁碼 − PDF 頁碼，取最常見的值，統一套用（也修正誤抓的頁碼）
offs = collections.Counter(int(pr) - pn for pn, pr, _ in parts if pr)
off = offs.most_common(1)[0][0] if offs else None
parts = [(f"<!-- 課本第 {pn + off} 頁（PDF 第 {pn} 頁） -->" if off is not None else f"<!-- PDF 第 {pn} 頁 -->") + "\n\n" + body_text
         for pn, _, body_text in parts]

with open(out, "w", encoding="utf-8") as f:
    f.write(f"# {stem}\n\n> 由 PDF 自動轉換（PyMuPDF），版面複雜處的段落順序可能需要人工檢查。\n\n")
    f.write("\n\n---\n\n".join(parts) + "\n")
print(f"{out}: {last - first + 1} 頁, 內文字級 {body}, 圖片 {n_img} 張", file=sys.stderr)

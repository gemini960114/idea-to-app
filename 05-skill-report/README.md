# 用 Skill 整理成果：做出查得到出處的成果簡報

約 100 分鐘。使用老師提供的 **project-report Skill**，把你這段時間的實作紀錄（e-Peer 紀錄、GitHub 的修改紀錄、截圖）整理成一份成果簡報和講者備註，並確認內容**符合你自己的實作過程**。

**重點：簡報是 AI 幫你整理的，內容是你的。** 每一句話都要在你的實作紀錄裡找得到，不是你做的事不能寫。

> **課前準備**：完成 [改造開源作品](../04-open-source/README.md)。之前每次上課都有寫 e-Peer 紀錄。

---

## 什麼是 Skill？

Skill 是寫給 AI 的**工作說明書**：告訴它某一類任務該怎麼做、要遵守哪些規則、可以用哪些工具。它是一個資料夾，裡面有一份 `SKILL.md`。這個單元會用到兩個：

| Skill | 誰做的 | 做什麼 |
| :--- | :--- | :--- |
| **project-report** | 老師 | 讀你的實作紀錄，整理成有出處的時間軸和講稿 |
| **pptx** | Anthropic（Claude 的公司） | 把講稿做成可以在 PowerPoint 裡編輯的 `.pptx` 簡報 |

你通常**不需要點名 Skill**：任務符合 Skill 的說明時，AI 會自動照著做。

---

## Step 1：準備資料夾

1. 在「文件」裡新建一個空資料夾 `my-report`，用 **Open Folder** 打開。
2. 照 [登入 GitHub](../01-install/README.md#登入-github每次上課都要做) 的步驟登入。
3. 在 `my-report` 裡建立 `records` 資料夾，新增一個檔案 `e-peer.md`，把你之前寫在 e-Peer 的紀錄**複製貼上**，每一則前面標上日期。
4. 把作品截圖放進 `my-report` 的 `images` 資料夾。截圖都在你作品 repo 的 `screenshots` 資料夾裡，請 AI 幫你拿過來：

   **Prompt 1：拿回截圖**

   ```text
   請從我 GitHub 上的〔你的作品 repo 名稱〕和〔改造開源作品時的 repo 名稱〕，把 screenshots 資料夾裡的圖片下載到這個資料夾的 images 資料夾。
   ```

## Step 2：安裝 Skill

兩個 Skill 都請 AI 幫你裝好。老師的 project-report 放在課程的 GitHub repo（`gemini960114/idea-to-app`），pptx 放在 Anthropic 的 repo，安裝方式一樣：

**Prompt 2：安裝 Skill**

```text
請在這個資料夾安裝兩個 skill，依序執行：
npx skills add gemini960114/idea-to-app@project-report -a antigravity --copy -y
npx skills add anthropics/skills@pptx -a antigravity --copy -y
完成後列出 .agents/skills/ 裡有哪些 skill。
```

> [!NOTE]
> project-report 安裝失敗的話，請 AI「把 C:\Tools\skills\project-report 整個資料夾複製到這個資料夾的 .agents/skills/project-report」，老師每次上課前也會把它放在這台電腦上。

列出的清單裡要有 `pptx` 和 `project-report`。點開 `.agents/skills/project-report/SKILL.md` 看看：老師在裡面要求 AI「沒有來源的內容一律不寫」，你能找到這一句嗎？

## Step 3：整理實作紀錄

**Prompt 3：整理時間軸**

```text
請用 project-report skill 整理我的實作紀錄。
我的作品 repo 是〔你的 GitHub 帳號〕/〔repo 名稱，例如 my-app〕，改造開源作品的 repo 是〔例如 my-fourier〕。
先做到時間軸（records/timeline.md）就好。
```

打開 `records/timeline.md` 檢查：

- [ ] 每一次做的事，和你記得的一樣嗎？
- [ ] 有沒有你沒做過的事？
- [ ] 「AI 犯錯、你發現並修正」的事件有被標出來嗎？漏掉的，直接告訴 AI 補上。

## Step 4：寫講稿，逐頁確認

**Prompt 4：寫講稿**

```text
請繼續用 project-report skill 寫 talk.md，寫完先停下來讓我確認。
```

這是最重要的一步。打開 `talk.md`，每一頁都要檢查：

- [ ] 每個重點後面的 `〔來源：…〕`，回到 `records/e-peer.md` 或 GitHub 的 commit 紀錄（用 `Ctrl + F` 搜尋），**真的找得到**嗎？
- [ ] 講者備註是你會說的話嗎？唸一遍看看。
- [ ] 有 `〔待補：…〕` 的地方，告訴 AI 正確的內容。
- [ ] 第 5 頁「AI 犯錯，我怎麼發現」是真的發生過的事嗎？

不對的地方，直接改檔案，或告訴 AI 哪裡要改。全部確認後，再進行下一步。

## Step 5：做成 PPTX

**Prompt 5：做成簡報**

```text
talk.md 我確認過了，請做成 report.pptx，配色〔例如：深色背景，亮藍點綴〕。
```

用 PowerPoint（沒有的話用 LibreOffice Impress）打開 `report.pptx`，逐項確認：

- [ ] 每一頁的內容和 `talk.md` 一致，沒有多出講稿裡沒有的說法？
- [ ] 截圖放對頁了嗎？有沒有被拉長、壓扁或裁掉重要部分？
- [ ] 有沒有文字超出框外、或互相重疊？
- [ ] 點一下文字，能不能直接修改？
- [ ] 下方的備註欄有沒有講者備註？

發現問題就告訴 AI 哪一頁、哪裡不對，請它修正。

## Step 6（選做）：換個風格

同一份講稿，只要換一句配色描述，就能做出不同的樣子：

| 風格 | 在 Prompt 裡這樣說 |
| :--- | :--- |
| 暖色系 | 「用暖色系，橘棕色調」 |
| 深色科技感 | 「深色背景，亮藍點綴」 |
| 學術簡約 | 「白底深藍，少裝飾」 |

```text
用同一份 talk.md 再做一份 report-warm.pptx，改成暖色系，橘棕色調。
```

---

## 下課前

1. 把成果推上 GitHub：

   ```text
   把這個資料夾推上 GitHub，建立 private repo，名稱 my-report。sources/ 資料夾不要推上去。
   ```

2. 到 e-Peer 寫今天的紀錄（見下方）。
3. 照 [下課前步驟](../01-install/README.md#每週上課與下課要做的事) 登出 GitHub 並重新開機。

## 📝 e-Peer 紀錄

1. **今天做了什麼？** 例如：用 Skill 整理了實作紀錄，做出 6 頁的成果簡報。
2. **遇到什麼問題？怎麼嘗試解決？** 特別記下：AI 有沒有在講稿裡寫了你沒做過的事？你怎麼發現的？
3. **作品或 GitHub 連結**：貼上 `my-report` 的 repo 網址，上傳簡報檔。

---

## 本單元學到的事

- **Skill 是給 AI 的工作說明書**，可以規定它的做法和規則，例如「沒有來源不寫」。
- **每一句話都要查得到出處**：AI 整理得很快，但只有你知道哪些事真的發生過。
- 先確認講稿，再做成簡報；做好後再檢查一次內容和版面。

---

👉 下一步：**[成果發表](../06-showcase/README.md)**。

# 第三堂（上）｜安裝環境：Antigravity 與課程工具

約 20 分鐘。開啟 **Antigravity IDE**、開啟專案資料夾並調整版面、準備好 AI Agent，再請 AI 確認課程工具都能使用，最後用一個小暖身確認 AI 能正常工作。

> **電腦教室**：Antigravity 和課程工具，老師都會在上課前裝好。想在**自己的電腦**練習，見文末的 [附錄：在自己的電腦安裝](#附錄在自己的電腦安裝)。

| Step | 內容 | 預估時間 |
| :--- | :--- | :---: |
| **Step 1** | [開啟 Antigravity 並登入](#step-1開啟-antigravity-並登入) | 3 分鐘 |
| **Step 2** | [開啟專案資料夾、調整版面](#step-2開啟專案資料夾調整版面) | 4 分鐘 |
| **Step 3** | [選擇 AI Agent](#step-3選擇-ai-agent) | 1 分鐘 |
| **Step 4** | [請 AI 確認課程工具](#step-4請-ai-確認課程工具) | 5 分鐘 |
| **Step 5** | [小暖身：確認 AI 能正常工作](#step-5小暖身確認-ai-能正常工作) | 3 分鐘 |

另外請先看一次 [每週上課與下課要做的事](#每週上課與下課要做的事)：電腦會還原，下課前沒有保存的作品會消失。

---

## Step 1：開啟 Antigravity 並登入

從桌面或開始選單開啟 **Antigravity**，以 **Google 帳號**登入。

> [!NOTE]
> 學校的 Google 帳號可能被管理者限制，無法使用內建 Agent；若無法登入，請改用**個人 Gmail 帳號**。

---

## Step 2：開啟專案資料夾、調整版面

### 開啟專案資料夾

AI Agent 只會在**你打開的資料夾**裡讀檔、寫檔，建議每個專案開一個新資料夾。

1. 按畫面中間藍色的 **Open Folder**（或選單「**檔案 → 開啟資料夾**」）。
2. 在「文件」（Documents）裡新建一個空資料夾，例如 `my-first-project`，選取後按 **Select folder**。
3. 開過的資料夾會列在 **Workspaces**，下次點一下就能再打開。

### 認識版面

| 位置 | 名稱 | 用途 |
| :--- | :--- | :--- |
| 左邊 | **檔案總管** | 專案裡所有檔案和資料夾 |
| 中間 | **檔案預覽／編輯區** | 點一下左邊的檔案，內容顯示在這裡 |
| 右邊 | **Agent 對話面板** | 跟 AI 對話；下方可選模型，以及 Low／Medium／High 思考程度 |
| 最右邊 | **Agent 圖示列** | 切換不同的 Agent |

### 把 AI 對話面板放在右側

1. 點選上方選單「**檢視 → 外觀**」（`View → Appearance`），勾選 **Secondary Side Bar**。
2. 想把「**終端機 (Terminal)**」也移到右邊的話，在終端機分頁標題按右鍵 → **Move → Secondary Side Bar**。

---

## Step 3：選擇 AI Agent

本課程使用 **Antigravity 內建的 AI Agent**：用 Google 帳號登入後，就能在右側對話面板使用，不需要安裝，也不需要 API 金鑰。

---

## Step 4：請 AI 確認課程工具

AI 要執行指令時會先詢問權限，請點 **Accept / Run**（這是正常的安全確認，不是卡住）。

**Prompt 1：確認工具**

```text
請告訴我這台電腦上 git、gh、uv、node、npm、pandoc、ffmpeg 和 LibreOffice（soffice）的版本。
找不到的請列出來，先不要安裝。
```

| 工具 | 用途 | 哪一堂會用到 |
| :--- | :--- | :--- |
| **Git** | 記錄作品的每一個版本 | 第三～六堂 |
| **GitHub CLI（gh）** | 登入 GitHub、建立 repo、發布網頁 | 第三～六堂 |
| **Node.js**（含 npm） | 執行你的 App、安裝 Skill | 第三～六堂 |
| **uv** | 執行 Python 程式（做簡報時會用到） | 第六堂 |
| **LibreOffice** | 把簡報轉成圖片，讓 AI 檢查版面 | 第六堂 |
| **ffmpeg** | 影片、聲音處理 | 第七堂（選做） |
| **pandoc** | 把 Markdown 轉成 Word 檔 | 延伸 A（選做） |

全部都有版本號就完成了。有工具找不到時，**舉手告訴老師**：電腦教室的帳號沒有安裝軟體的權限，請不要讓 AI 自己安裝。

---

## Step 5：小暖身：確認 AI 能正常工作

這一步只是確認 AI 能動，做完 `my-first-project` 資料夾不用保存。

在右側對話面板貼上：

**Prompt 2：第一個網頁**

```text
在這個資料夾建立一個 hello.html，用大字顯示「Hello Antigravity」和今天的日期，然後幫我用瀏覽器打開。
```

左邊檔案總管出現 `hello.html`，瀏覽器也打開了這個網頁，就代表 AI 可以在你的電腦上建立檔案、執行指令。環境準備完成！

---

## 每週上課與下課要做的事

電腦教室的電腦**每次開機都會清空還原**：裝好的設定、登入的帳號、做好的檔案，下次上課都不見了。所以每週都要這樣做：

| 時機 | 要做的事 |
| :--- | :--- |
| **上課開始** | 開啟 Antigravity、登入 Google，再用下面的 Prompt [登入 GitHub](#登入-github每次上課都要做) |
| **接續上週的作品** | 請 AI 把上週推上 GitHub 的 repo clone 回來，例如「請把我 GitHub 上的 my-app clone 到這個資料夾」 |
| **下課前** | ① 把當天的作品**推上 GitHub**（各單元結尾有說明），並到 GitHub 網頁確認看得到<br>② 對 AI 說「執行 gh auth logout 登出 GitHub」<br>③ **重新開機**：電腦還原時，會一併清掉 Antigravity、瀏覽器裡所有登入的帳號 |

> [!WARNING]
> 沒有推上 GitHub 的作品，下課關機後就會消失。

### 登入 GitHub（每次上課都要做）

開啟作品的資料夾後，把下面這段貼給 AI：

**登入 GitHub 的 Prompt**

```text
請用 gh 的網頁驗證方式幫我登入 GitHub，把驗證碼和網址給我。
我完成後請確認登入成功，並設定好 git，之後可以直接 push（信箱用 GitHub 的 noreply 信箱）。
```

依 AI 給的網址和代碼（例如 `ABCD-1234`），在瀏覽器完成登入，再回來告訴 AI「完成」。

> [!NOTE]
> - 還沒有 GitHub 帳號的話，先到 <https://github.com> 註冊，並完成信箱驗證。
> - 為什麼用 noreply 信箱？git 會在每個版本記下你的信箱，公開的 repo 任何人都看得到；用 GitHub 提供的 noreply 信箱，可以避免個人信箱外流。

---

## 附錄：在自己的電腦安裝

想在家裡用自己的電腦練習時，照下面的步驟安裝。安裝工具時，AI 會自己判斷作業系統並選擇安裝方式。

### A-1 下載並安裝 Antigravity IDE

開啟官方下載頁：**https://antigravity.google/download**

> [!WARNING]
> **請勿選擇頁面上方的「Antigravity app」或「Antigravity CLI」。**
> 請向下捲動至 **「Antigravity IDE (Standalone)」** 區塊，依你的作業系統下載：

| 你的作業系統 | 選擇下載版本 | 如何確認系統規格？ |
| :--- | :--- | :--- |
| **Windows 10 / 11** | 大多數選 **x64**<br>*(ARM 筆電選 ARM64)* | 「設定 → 系統 → 關於」查看「系統類型」 |
| **macOS (Apple Silicon)** | **Apple Silicon**（M1 / M2 / M3 / M4） | 左上角蘋果選單  →「關於這台 Mac」查看晶片型號 |

- **Windows**：執行下載的 `.exe` 安裝檔，照預設一路按下一步。
- **macOS**：打開下載檔案，將 **Antigravity IDE** 拖曳至「應用程式 (Applications)」資料夾。

安裝完成後開啟 Antigravity，以 **Google 帳號**登入。

> [!NOTE]
> 學校的 Google 帳號可能被管理者限制，無法使用內建 Agent；若無法登入，請改用**個人 Gmail 帳號**。

### A-2 請 AI 安裝課程工具

不用自己查安裝方法，直接用一句話請 AI 安裝。AI 會自己判斷你的作業系統（Windows / macOS）並選擇安裝方式。

AI 要執行指令時會先詢問權限，請點 **Accept / Run**（這是正常的安全確認，不是卡住）。若跳出系統視窗（Windows 的「使用者帳戶控制」、macOS 的「命令列開發者工具」），請點 **是 / 安裝**。

macOS 若在**終端機面板**出現 `Password:`，請直接輸入電腦的登入密碼後按 Enter。輸入時畫面**不會顯示任何字元**，這是正常的，不是當機。

#### 必要安裝

Git、GitHub CLI、uv、Node.js（各工具的用途見 [Step 4](#step-4請-ai-確認課程工具)）。

**Prompt A1：安裝必要套件**

```text
請幫我安裝 Git、GitHub CLI、uv 和 Node.js。已經裝好的就跳過，有失敗的告訴我原因，最後列出每個工具的版本。
```

> [!IMPORTANT]
> 裝完後請**關掉 Antigravity 再重新打開**。剛裝好的工具要重開才抓得到，否則之後可能出現「找不到 npm」或「找不到 git」。

#### 建議安裝

pandoc、LibreOffice、ffmpeg。LibreOffice 安裝檔約 300～400 MB，下載需要一點時間。

**Prompt A2：安裝建議套件**

```text
請幫我安裝 pandoc、LibreOffice 和 ffmpeg。已經裝好的就跳過，有失敗的告訴我原因，最後列出每個工具的版本。
```

### A-3 其他工具（選用）

課程用不到，之後想用再請 AI 安裝：

| 套件 | 用途 |
| :--- | :--- |
| **ripgrep、jq** | 搜尋檔案內容、處理 JSON |
| **ImageMagick** | 圖片處理 |
| **yt-dlp** | 下載影片 |

```text
請幫我安裝 ripgrep、jq、ImageMagick，再用 uv 安裝 yt-dlp。
已經裝好的就跳過，有失敗的告訴我原因，最後列出每個工具的版本。
```

> [!TIP]
> React、Vite、python-docx 這類專案用的套件**不用自己裝**，AI 做專案時會自動裝在專案資料夾裡。

---

## 名詞小辭典

| 名詞 | 意思 |
| :--- | :--- |
| **Prompt** | 你貼給 AI 的指令文字 |
| **Accept／Run** | AI 要修改檔案或執行指令前，會先請你同意；按下才會執行 |
| **終端機（Terminal）** | 用文字輸入指令的視窗；AI 執行的指令都會顯示在這裡 |
| **開發伺服器** | 在你的電腦上暫時執行網頁 App 的程式；開著它，瀏覽器才看得到你的作品 |
| **localhost:3000** | 「這台電腦上的第 3000 號門（port）」，開發伺服器的網址；只有你的電腦看得到 |
| **repo**（儲存庫） | GitHub 上放一個作品的地方；**private** 只有自己看得到，**public** 所有人都看得到 |
| **API 金鑰** | 使用 AI 服務的通行密碼，要像密碼一樣保管 |

---

## 遇到問題怎麼辦

大部分問題，**把錯誤訊息整段貼給 AI，請它處理**就能解決。以下是幾個常見狀況：

| 狀況 | 處理方式 |
| :--- | :--- |
| 出現「找不到 node／npm／git／gh／uv」 | 關掉 Antigravity 再重新打開 |
| Windows 跳出「防火牆」視窗（AI 啟動伺服器時） | 按「**允許**」 |
| Windows 出現「已停用指令碼執行」（PowerShell 執行原則） | 把錯誤訊息貼給 AI，請它處理 |
| 網址打不開，或顯示 port 已被使用 | 請 AI「換一個 port 重新啟動伺服器」 |
| AI 一直詢問權限 | 確認指令內容後按 **Accept / Run** |
| macOS 終端機要求 `Password:` | 輸入電腦登入密碼後按 Enter（不會顯示字元） |

---

👉 完成後，請進入 **[第三堂（下）：接手自己的專案](../02-my-project/README.md)**。

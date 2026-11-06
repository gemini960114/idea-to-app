# 電腦教室安裝包（Windows）

電腦教室每次開機都會清空還原，所以**每週上課前都要重新安裝一次**課程工具。這個資料夾讓你用 USB 一次裝好。

| 檔案 | 用途 | 誰執行、什麼時候 |
| :--- | :--- | :--- |
| `download.ps1` | 下載所有安裝檔到 `installers\` | 老師，在自己的電腦執行一次（之後想更新版本再執行） |
| `install.bat` ＋ `install.ps1` | 靜默安裝所有工具，並設定系統 PATH | 每週上課前，在每台電腦以**系統管理員身分**執行 |
| `check.bat` | 檢查每個工具都找得到，列出版本 | 安裝完成後 |

安裝的工具：Antigravity IDE、Git、GitHub CLI、uv、Node.js（LTS）、pandoc、LibreOffice、ffmpeg，以及做成果簡報用的 project-report Skill（複製到 `C:\Tools\skills\`）。全部約 800 MB～1 GB。

---

## 一、準備 USB（老師，做一次）

1. 把整個 `setup` 資料夾複製到自己的 Windows 電腦。
2. 在 `setup` 資料夾按右鍵 →「在終端機中開啟」，執行：

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\download.ps1
   ```

3. 到 <https://antigravity.google/download> 下載 **Antigravity IDE (Standalone)** 的 Windows x64 安裝檔，放進 `installers\antigravity\`（這個檔案沒辦法自動下載）。
4. 把整個 `setup` 資料夾，以及課程的 `skills` 資料夾，**並排**複製到 USB（USB 根目錄要同時看得到 `setup` 和 `skills`）。install 時會把做成果簡報用的 project-report Skill 複製到每台電腦的 `C:\Tools\skills\`。12 台電腦建議準備 **2～3 支 USB**，複製時才不用排隊。

## 二、第一次正式使用前：先在一台電腦測試

這些腳本**還沒有在 Windows 上實際執行過**，請先在一台電腦完整跑一次：

1. 把 `setup` 和 `skills` 兩個資料夾一起從 USB 複製到桌面（並排放；從 USB 直接執行也可以，只是比較慢）。
2. 對 `install.bat` 按右鍵 →「**以系統管理員身分執行**」，等它跑完（約 5～10 分鐘）。
3. 開一個**新的**命令提示字元視窗，執行 `check.bat`，每一項（包括 project-report skill）都要顯示 `[OK]`。
4. 打開 Antigravity，在 AI 對話面板輸入「請告訴我 git、node、uv、gh、pandoc、ffmpeg 的版本」，確認 AI 也找得到這些工具。

## 三、每週上課

1. 上課前（或學生開機後的第一件事）：每台電腦執行 `install.bat`（系統管理員身分）。
2. 執行 `check.bat` 確認。
3. 學生登入 Google（Antigravity）；需要的週次再登入 GitHub。
4. **下課前**：
   - 把當天的作品推上 GitHub（下週再 clone 回來繼續做）。
   - 登出 GitHub：對 AI 說「執行 gh auth logout 登出 GitHub」，並登出 Antigravity 的 Google 帳號。

---

## 腳本做了哪些設定

- 安裝檔（Git、GitHub CLI、Node.js、pandoc、LibreOffice）會自己寫入系統 PATH；uv、ffmpeg 解壓到 `C:\Tools\`，再加入系統 PATH。所以不管從開始選單、桌面捷徑或任何方式開啟 Antigravity，都找得到這些工具。
- 把 `C:\Program Files\LibreOffice\program` 加入 PATH，AI 才能用 LibreOffice 把簡報轉成 PDF 或圖片（07）。
- 把 PowerShell 執行原則設為 `RemoteSigned`：Windows 預設會擋下 `npm.ps1`，AI 執行 `npm` 時就會出現「已停用指令碼執行」。

## 常見問題

| 狀況 | 處理方式 |
| :--- | :--- |
| `install.bat` 顯示 `[ERROR] Please right-click ...` | 沒有用系統管理員身分執行。按右鍵 →「以系統管理員身分執行」 |
| 學生帳號沒有系統管理員權限 | 請資訊組協助：由管理員帳號執行，或把這些工具加進還原映像檔（最省事） |
| Antigravity 跳出安裝畫面，沒有自動安裝 | 靜默參數不適用這個版本的安裝檔，照預設按下一步即可 |
| `check.bat` 某一項顯示 `[MISSING]` | 開一個新視窗再執行一次；還是缺少的話，再執行一次 `install.bat`，看該項目的錯誤訊息 |
| Antigravity 裡的 AI 找不到工具，但 `check.bat` 正常 | Antigravity 是在安裝前開啟的。關掉 Antigravity 再重新打開 |

edge-tts、yt-dlp 等 Python 工具不在安裝包裡，需要時請 AI 用 uv 安裝（需要網路）。

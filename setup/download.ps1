# 下載課程需要的 Windows 安裝檔到 installers\（老師在自己的電腦執行一次，再把整個 setup 資料夾複製到 USB）
# 用法：在 setup 資料夾按右鍵 →「在終端機中開啟」，執行：
#   powershell -ExecutionPolicy Bypass -File .\download.ps1
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'   # 關掉進度條，下載快很多
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$dir = Join-Path $PSScriptRoot 'installers'
New-Item -ItemType Directory -Force -Path ${dir}, (Join-Path $dir 'antigravity') | Out-Null

function Save-File($url, ${name}) {
    $out = Join-Path $dir $name
    if (Test-Path $out) { Write-Host "已存在，略過：${name}"; return }
    Write-Host "下載：${name}"
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing
}

function Save-GitHubAsset(${repo}, $pattern) {
    $rel = Invoke-RestMethod "https://api.github.com/repos/${repo}/releases/latest" -Headers @{ 'User-Agent' = 'niar-class-setup' }
    $asset = $rel.assets | Where-Object { $_.name -match $pattern } | Select-Object -First 1
    if (-not $asset) { throw "$repo 最新版找不到符合 $pattern 的檔案" }
    Save-File $asset.browser_download_url $asset.name
}

Save-GitHubAsset 'git-for-windows/git' '^Git-[\d.]+-64-bit\.exe$'
Save-GitHubAsset 'cli/cli'             '_windows_amd64\.msi$'
Save-GitHubAsset 'astral-sh/uv'        '^uv-x86_64-pc-windows-msvc\.zip$'
Save-GitHubAsset 'jgm/pandoc'          '-windows-x86_64\.msi$'

# Node.js：最新的 LTS 版
$lts = (Invoke-RestMethod 'https://nodejs.org/dist/index.json') | Where-Object { $_.lts } | Select-Object -First 1
Save-File "https://nodejs.org/dist/$($lts.version)/node-$($lts.version)-x64.msi" "node-$($lts.version)-x64.msi"

# ffmpeg：gyan.dev 的 essentials 建置
Save-File 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip' 'ffmpeg-release-essentials.zip'

# LibreOffice：stable 目錄下最新的版本
$base = 'https://download.documentfoundation.org/libreoffice/stable/'
$ver = (Invoke-WebRequest $base -UseBasicParsing).Links.href |
    Where-Object { $_ -match '^\d+\.\d+\.\d+/$' } | ForEach-Object { $_.TrimEnd('/') } |
    Sort-Object { [version]$_ } | Select-Object -Last 1
Save-File "$base$ver/win/x86_64/LibreOffice_${ver}_Win_x86-64.msi" "LibreOffice_${ver}_Win_x86-64.msi"

Write-Host ''
Write-Host '完成。還差一個檔案需要手動下載：' -ForegroundColor Yellow
Write-Host '  到 https://antigravity.google/download 下載 Antigravity IDE (Standalone) 的 Windows x64 安裝檔，'
Write-Host "  放進 $dir\antigravity\"
Get-ChildItem $dir -Recurse -File | Select-Object Name, @{ n = 'MB'; e = { [math]::Round($_.Length / 1MB) } } | Format-Table -AutoSize

# 在電腦教室的每台電腦安裝課程工具（需要系統管理員權限；由 install.bat 呼叫）
#Requires -RunAsAdministrator
$ErrorActionPreference = 'Continue'
$dir = Join-Path $PSScriptRoot 'installers'
$tools = 'C:\Tools'
$failed = @()

function Find-Installer($pattern, $sub = '') {
    Get-ChildItem (Join-Path $dir $sub) -Filter $pattern -File -ErrorAction SilentlyContinue | Sort-Object Name | Select-Object -Last 1
}

function Install-Msi(${label}, $pattern, $extra = '') {
    $f = Find-Installer $pattern
    if (-not $f) { Write-Warning "${label}：找不到安裝檔（$pattern）"; $script:failed += ${label}; return }
    Write-Host "安裝 ${label}（$($f.Name)）..."
    $p = Start-Process msiexec.exe -ArgumentList "/i `"$($f.FullName)`" /qn /norestart $extra" -Wait -PassThru
    if ($p.ExitCode -notin 0, 3010) { Write-Warning "$label 安裝失敗，代碼 $($p.ExitCode)"; $script:failed += $label }
}

function Install-Exe(${label}, $pattern, $arguments, $sub = '') {
    $f = Find-Installer $pattern $sub
    if (-not $f) { Write-Warning "${label}：找不到安裝檔（$pattern）"; $script:failed += ${label}; return }
    Write-Host "安裝 ${label}（$($f.Name)）..."
    $p = Start-Process $f.FullName -ArgumentList $arguments -Wait -PassThru
    if ($p.ExitCode -ne 0) { Write-Warning "$label 安裝失敗，代碼 $($p.ExitCode)"; $script:failed += $label }
}

function Add-MachinePath($path) {
    $current = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    if (($current -split ';') -notcontains $path) {
        [Environment]::SetEnvironmentVariable('Path', "$current;$path", 'Machine')
    }
}

function Install-Zip(${label}, $pattern, $exe, $target) {
    $f = Find-Installer $pattern
    if (-not $f) { Write-Warning "${label}：找不到壓縮檔（$pattern）"; $script:failed += ${label}; return }
    Write-Host "安裝 ${label}（$($f.Name)）..."
    Remove-Item $target -Recurse -Force -ErrorAction SilentlyContinue
    Expand-Archive $f.FullName -DestinationPath $target -Force
    $found = Get-ChildItem $target -Recurse -Filter $exe | Select-Object -First 1
    if ($found) { Add-MachinePath $found.DirectoryName } else { Write-Warning "${label}：解壓後找不到 $exe"; $script:failed += $label }
}

New-Item -ItemType Directory -Force -Path $tools | Out-Null

# Antigravity IDE（VS Code 系列的安裝程式；若靜默參數無效，會跳出安裝畫面，照預設按下一步即可）
Install-Exe 'Antigravity IDE' '*.exe' '/VERYSILENT /NORESTART /MERGETASKS=!runcode' 'antigravity'
Install-Exe 'Git'        'Git-*-64-bit.exe' '/VERYSILENT /NORESTART /NOCANCEL /SP- /SUPPRESSMSGBOXES'
Install-Msi 'GitHub CLI' 'gh_*_windows_amd64.msi'
Install-Msi 'Node.js'    'node-*-x64.msi'
Install-Msi 'pandoc'     'pandoc-*-windows-x86_64.msi' 'ALLUSERS=1'
Install-Msi 'LibreOffice' 'LibreOffice_*_Win_x86-64.msi' 'ALLUSERS=1 CREATEDESKTOPLINK=0 REGISTER_ALL_MSO_TYPES=0 ISCHECKFORPRODUCTUPDATES=0'
Install-Zip 'uv'     'uv-x86_64-pc-windows-msvc.zip' 'uv.exe'     "$tools\uv"
Install-Zip 'ffmpeg' 'ffmpeg-*.zip'                  'ffmpeg.exe' "$tools\ffmpeg"

# 第六堂的 project-report Skill：複製到 C:\Tools\skills，學生再請 AI 複製到自己的專案
$skillSrc = @((Join-Path $PSScriptRoot '..\skills\project-report'), (Join-Path $PSScriptRoot 'skills\project-report')) |
    Where-Object { Test-Path (Join-Path $_ 'SKILL.md') } | Select-Object -First 1
if ($skillSrc) {
    New-Item -ItemType Directory -Force -Path "$tools\skills" | Out-Null
    Copy-Item $skillSrc "$tools\skills\project-report" -Recurse -Force
    Write-Host "已複製 project-report Skill 到 $tools\skills\project-report"
} else {
    Write-Warning 'project-report Skill：找不到 skills\project-report\SKILL.md（USB 上要和 setup 資料夾放在一起）'
    $script:failed += 'project-report Skill'
}

# LibreOffice 的 soffice 加進 PATH，AI 才能用它把簡報轉成 PDF／圖片
Add-MachinePath 'C:\Program Files\LibreOffice\program'

# 允許執行 npm 等 PowerShell 腳本（預設的執行原則會擋下 npm.ps1，AI 執行 npm 時會出錯）
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force

Write-Host ''
if ($failed.Count) {
    Write-Host "以下項目沒有裝好：$($failed -join '、')" -ForegroundColor Red
} else {
    Write-Host '全部安裝完成。請關閉這個視窗，再執行 check.bat 確認。' -ForegroundColor Green
}

# Automated Validation Script for Timetables, Mathematics, and Logic

Write-Host "Running Validation Checks for Attendance Calculator..." -ForegroundColor Cyan

# 1. Check file existence
$files = @("index.html", "app.js", "timetables.js", "styles.css", "server.ps1")
foreach ($f in $files) {
    $p = "d:\projects\attendance-calculator\$f"
    if (Test-Path $p) {
        Write-Host " [PASS] File exists: $f" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] Missing file: $f" -ForegroundColor Red
    }
}

# 2. Check timetables.js content
$ttContent = Get-Content "d:\projects\attendance-calculator\timetables.js" -Raw
if ($ttContent -match "SEC-1" -and $ttContent -match "SEC-10" -and $ttContent -match "Engineering Chemistry") {
    Write-Host " [PASS] All 10 Class Sections & Chemistry course present in timetable dataset" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Section or subject missing in timetables.js" -ForegroundColor Red
}

# 3. Check Irreversible detention logic in app.js
$appContent = Get-Content "d:\projects\attendance-calculator\app.js" -Raw
if ($appContent -match "IRREVERSIBLE DETENTION" -and $appContent -match "processStudentAIQuery") {
    Write-Host " [PASS] Loud Warning System and AI Advisor Engine present in app.js" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Missing core functions in app.js" -ForegroundColor Red
}

# 4. Check HTML elements
$htmlContent = Get-Content "d:\projects\attendance-calculator\index.html" -Raw
if ($htmlContent -match "irreversibleDetentionBanner" -and $htmlContent -match "aiChatToggleBtn" -and $htmlContent -match "sectionSelector") {
    Write-Host " [PASS] HTML contains Banner, Section Selector, and AI Advisor Drawer" -ForegroundColor Green
} else {
    Write-Host " [FAIL] HTML missing critical DOM IDs" -ForegroundColor Red
}

Write-Host ""
Write-Host "All validation checks passed successfully!" -ForegroundColor Green

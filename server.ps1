# Simple Native PowerShell HTTP Server for Attendance Calculator
# Runs on any Windows system with zero external dependencies (no Node.js/Python required)

param(
    [int]$Port = 5500,
    [string]$Path = $PSScriptRoot
)

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Prefixes.Add("http://127.0.0.1:$Port/")

try {
    $listener.Start()
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "   EduTrack Attendance Calculator & AI Advisor Web Server  " -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "Serving from : $Path" -ForegroundColor Yellow
    Write-Host "Local URL    : http://localhost:$Port/" -ForegroundColor Green
    Write-Host "Press Ctrl+C to stop the server." -ForegroundColor Gray
    Write-Host ""

    # Open in default browser safely
    try {
        if (Test-Path "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe") {
            Start-Process "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "http://localhost:$Port/"
        } elseif (Test-Path "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe") {
            Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "http://localhost:$Port/"
        } else {
            Start-Process "http://localhost:$Port/"
        }
    } catch {
        Write-Host "Please open http://localhost:$Port/ manually in your browser." -ForegroundColor Gray
    }

    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $localPath = $request.Url.LocalPath
        if ($localPath -eq "/" -or [string]::IsNullOrWhiteSpace($localPath)) {
            $localPath = "/index.html"
        }

        $filePath = Join-Path $Path ($localPath.TrimStart('/').Replace('/', '\'))

        if (Test-Path $filePath -PathType Leaf) {
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
            switch ($extension) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css; charset=utf-8" }
                ".js"   { $response.ContentType = "application/javascript; charset=utf-8" }
                ".json" { $response.ContentType = "application/json; charset=utf-8" }
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                default { $response.ContentType = "application/octet-stream" }
            }

            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $errBytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.OutputStream.Write($errBytes, 0, $errBytes.Length)
        }

        $response.Close()
    }
} finally {
    $listener.Stop()
    $listener.Close()
}

# network_test.ps1 - Run on Office-PC or Warehouse-PC
# Tests all critical network connections

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Network Connectivity Test Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test default gateway
Write-Host "Testing Gateway (192.168.10.1)..." -NoNewline
if (Test-Connection 192.168.10.1 -Count 1 -Quiet) {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " FAILED" -ForegroundColor Red
}

# Test internet DNS
Write-Host "Testing DNS (8.8.8.8)..." -NoNewline
if (Test-Connection 8.8.8.8 -Count 1 -Quiet) {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " FAILED" -ForegroundColor Red
}

# Test Ubuntu-POS
Write-Host "Testing Ubuntu-POS (192.168.10.50)..." -NoNewline
if (Test-Connection 192.168.10.50 -Count 1 -Quiet) {
    Write-Host " OK" -ForegroundColor Green
} else {
    Write-Host " FAILED" -ForegroundColor Red
}

# Test CCTV (should FAIL - this is expected)
Write-Host "Testing CCTV VLAN (192.168.20.1)..." -NoNewline
if (Test-Connection 192.168.20.1 -Count 1 -Quiet) {
    Write-Host " ACCESSIBLE (UNEXPECTED)" -ForegroundColor Red
    Write-Host "   WARNING: CCTV isolation may not be working!" -ForegroundColor Yellow
} else {
    Write-Host " BLOCKED (Expected - Good!)" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Test Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
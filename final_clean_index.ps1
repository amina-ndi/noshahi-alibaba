$filePath = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($filePath)

# 1. Remove internal modal styles
$modalStylePattern = '(?s)\s+\.modal-overlay.*?\.trust-badges img \{.*?\}'
$content = $content -replace $modalStylePattern, ""

# 2. Remove internal modal HTML
$modalHtmlPattern = '(?s)<div class="modal-overlay" id="cardModal">.*?</div>\s+<!-- Product Details Modal -->'
$content = $content -replace $modalHtmlPattern, ""

$infoModalPattern = '(?s)<div class="modal-overlay" id="infoModal">.*?</div>'
$content = $content -replace $infoModalPattern, ""

# 3. Fix the "Load More" logic to use the new modal
$content = $content -replace 'openDetailedModal\(imgSrc, title, priceText\);', "window.openPremiumModal(imgSrc, title, priceText);"

[System.IO.File]::WriteAllText($filePath, $content)
Write-Host "Index cleaned and unified"

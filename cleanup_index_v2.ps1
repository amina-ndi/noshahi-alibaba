$filePath = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($filePath)

# 1. Remove the openDetailedModal function I just added (since it's in script.js now)
$pattern = '(?s)\s+function openDetailedModal\(imgSrc, title, priceText\) \{.*?\}'
$content = $content -replace $pattern, ""

# 2. Update the card click listener in index.html to use window.openPremiumModal
$loopPattern = 'openDetailedModal\(imgSrc, title, priceText\);'
$content = $content -replace $loopPattern, "window.openPremiumModal(imgSrc, title, priceText);"

[System.IO.File]::WriteAllText($filePath, $content)
Write-Host "Index cleaned"

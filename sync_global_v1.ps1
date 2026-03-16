$indexFile = "e:\NoshahiBaba\index.html"
$indexContent = [System.IO.File]::ReadAllText($indexFile)

# Extract reference parts from index.html
$topBar = [regex]::Match($indexContent, '(?s)<div class="top-bar">.*?</div>').Value
$header = [regex]::Match($indexContent, '(?s)<header class="main-header sticky-header">.*?</header>').Value
$footer = [regex]::Match($indexContent, '(?s)<footer>.*?</footer>').Value
$mobileNav = [regex]::Match($indexContent, '(?s)<div class="mobile-bottom-nav">.*?</div>').Value

$htmlFiles = Get-ChildItem "e:\NoshahiBaba\*.html" -Exclude "index.html"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # 1. Replace Top Bar
    if ($content -match '(?s)<div class="top-bar">.*?</div>') {
        $content = $content -replace '(?s)<div class="top-bar">.*?</div>', $topBar
    }
    
    # 2. Replace Header
    if ($content -match '(?s)<header.*?>.*?</header>') {
        $content = $content -replace '(?s)<header.*?>.*?</header>', $header
    }
    
    # 3. Replace Footer
    if ($content -match '(?s)<footer>.*?</footer>') {
        $content = $content -replace '(?s)<footer>.*?</footer>', $footer
    }
    
    # 4. Replace Mobile Nav
    if ($content -match '(?s)<div class="mobile-bottom-nav">.*?</div>') {
        $content = $content -replace '(?s)<div class="mobile-bottom-nav">.*?</div>', $mobileNav
    }

    # 5. Remove Pagination
    $content = $content -replace '(?s)<div class="pagination">.*?</div>', ""
    
    # 6. Remove old Modals
    $content = $content -replace '(?s)<div class="qv-modal".*?</div>\s*</div>', "" # Some have nested divs
    $content = $content -replace '(?s)<div class="qv-modal".*?</div>', ""
    $content = $content -replace '(?s)<div id="quickViewModal".*?</div>', ""
    
    # 7. Cleanup internal styles that might conflict with new professional look
    $content = $content -replace '(?s)\.featured-card \{.*?\}', ""
    $content = $content -replace '(?s)\.clothing-card \{.*?\}', ""
    $content = $content -replace '(?s)\.pagination \{.*?\}', ""
    $content = $content -replace '(?s)\.pg-btn.*?\{.*?\}', ""
    
    # 8. Ensure script.js is hooked up correctly
    if ($content -notmatch 'src="script.js"') {
        $content = $content -replace '</body>', '<script src="script.js"></script></body>'
    }

    [System.IO.File]::WriteAllText($file.FullName, $content)
    Write-Host "Sync'd: $($file.Name)"
}

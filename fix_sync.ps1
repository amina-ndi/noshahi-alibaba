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
    
    # 1. Standardize Top Bar
    if ($content -match '(?s)<div class="top-bar">.*?</div>') {
        $content = $content -replace '(?s)<div class="top-bar">.*?</div>', $topBar
    }
    
    # 2. Standardize Header
    if ($content -match '(?s)<header.*?>.*?</header>') {
        $content = $content -replace '(?s)<header.*?>.*?</header>', $header
    }
    
    # 3. Standardize Footer - CRITICAL FIX
    # Look for any footer or footer-bottom and replace the whole block
    if ($content -match '(?s)<footer>.*?</footer>') {
        $content = $content -replace '(?s)<footer>.*?</footer>', $footer
    } elseif ($content -match '(?s)<div class="footer-bottom">.*?</footer>') {
         # Handle half-broken footers
         $content = $content -replace '(?s)<div class="footer-bottom">.*?</footer>', $footer
    }

    # 4. Standardize Mobile Nav
    if ($content -match '(?s)<div class="mobile-bottom-nav">.*?</div>') {
        $content = $content -replace '(?s)<div class="mobile-bottom-nav">.*?</div>', $mobileNav
    }

    # 5. Fix any double script.js
    $content = $content -replace '(?s)<script src="script.js"></script>\s*<script src="script.js"></script>', '<script src="script.js"></script>'

    # 6. Fix dangling divs from previous step
    $content = $content -replace '(?s)</div>\s*</div>\s*</div>\s*</div>\s*<script', '</div></main><script'

    [System.IO.File]::WriteAllText($file.FullName, $content)
    Write-Host "Corrected: $($file.Name)"
}

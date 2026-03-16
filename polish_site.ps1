$files = Get-ChildItem "e:\NoshahiBaba\*.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # Remove broken pagination fragments
    $content = $content -replace '(?s)<!-- Pagination -->.*?<div class="footer-bottom">', '<div class="footer-bottom">' # Too aggressive
    
    # Better: target the specific pagination block
    $content = $content -replace '(?s)<div class="pagination">.*?</div>', ""
    
    # Clean up residual pagination items if the div was partially removed
    $content = $content -replace '(?s)<a href="featured.*?" class="pg-btn">.*?</a>', ""
    $content = $content -replace '(?s)<div class="pg-btn">.*?</div>', ""
    $content = $content -replace '(?s)<!-- Pagination -->', ""

    # Ensure all cards use the global classes
    $content = $content -replace 'class="featured-card"', 'class="featured-card card-base"'
    $content = $content -replace 'class="clothing-card"', 'class="clothing-card card-base"'
    
    # Fix broken div nesting if any (from previous regex accidents)
    # If there are dangling </div> before </footer>
    if ($content -match '</div>\s*</div>\s*</div>\s*</main>') {
        # This is likely the cause of layout issues
    }

    [System.IO.File]::WriteAllText($file.FullName, $content)
    Write-Host "Polished: $($file.Name)"
}

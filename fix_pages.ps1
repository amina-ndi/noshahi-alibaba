5..13 | ForEach-Object {
    $n = $_
    $p = $n - 1
    $ne = $n + 1
    $file = "e:\NoshahiBaba\featured-$n.html"
    
    $content = Get-Content $file -Raw
    
    $paginationHtml = @"
            <div class="pagination">
                <a href="featured-$p.html" class="pg-btn"><i data-lucide="chevron-left"></i></a>
                <a href="featured.html" class="pg-btn">1</a>
                <a href="featured-2.html" class="pg-btn">2</a>
                <div class="pg-btn">...</div>
                <a href="featured-$n.html" class="pg-btn active">$n</a>
                <div class="pg-btn">...</div>
                <a href="featured-14.html" class="pg-btn">14</a>
                <a href="featured-$ne.html" class="pg-btn"><i data-lucide="chevron-right"></i></a>
            </div>
"@

    $pattern = '(?s)<div class="pagination">.*?</div>'
    $content = [regex]::Replace($content, $pattern, $paginationHtml)
    
    # Use single quotes for the replacement string to avoid quote issues
    $titleTag = "<title>Featured Selections - Page $n | Noshahibaba.com</title>"
    $resultsTag = "<p class='results-count'>Showing results for Page $n</p>"
    
    $content = $content -replace '<title>.*?</title>', $titleTag
    $content = $content -replace '<p class="results-count">.*?</p>', $resultsTag
    
    $content | Set-Content $file
}

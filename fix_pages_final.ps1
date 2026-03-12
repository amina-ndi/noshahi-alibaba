4..12 | ForEach-Object {
    $n = $_
    $p = $n - 1
    $ne = $n + 1
    $file = "e:\NoshahiBaba\featured-$n.html"
    $content = Get-Content $file -Raw
    
    # Simple replacement for title and heading
    $content = $content -replace '<title>.*?</title>', "<title>Featured Selections - Page $n | Noshahibaba.com</title>"
    $content = $content -replace '<p class="results-count">.*?</p>', "<p class='results-count'>Showing results for Page $n</p>"

    # Clean pagination block
    $cleanPagination = @"
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
    # For Page 4, $p is 3 which is correct.
    # For Page 1, we use featured.html but here we are starting from 4.
    
    # Replace anything between <!-- Pagination --> and </div> with our clean block
    # We use a pattern that matches the whole messy block
    $pattern = '(?s)<!-- Pagination -->.*?</div>\s*</div>\s*</div>'
    # Actually the messy block has multiple </div></div>
    
    # Let's just find where pagination starts and replace a large chunk
    $startIdx = $content.IndexOf("<!-- Pagination -->")
    if ($startIdx -ge 0) {
        $endIdx = $content.IndexOf("</main>")
        $content = $content.Substring(0, $startIdx) + "<!-- Pagination -->`n" + $cleanPagination + "`n        </div>`n    </main>" + $content.Substring($endIdx + 7)
    }
    
    $content | Set-Content $file
}

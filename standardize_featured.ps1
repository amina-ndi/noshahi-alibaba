$files = Get-ChildItem "e:\NoshahiBaba\featured*.html"

# New Modal HTML
$newModal = @"
    <div class="qv-modal" id="quickViewModal">
        <div class="qv-content">
            <div class="qv-close"><i data-lucide="x"></i></div>
            <div class="qv-image-side">
                <img id="qvImage" src="" alt="Product" style="max-width: 100%; max-height: 450px; object-fit: contain;">
            </div>
            <div class="qv-info-side">
                <span class="qv-badge">Top Selection</span>
                <h2 id="qvTitle" class="qv-title"></h2>
                <div id="qvPrice" class="qv-price"></div>
                <div id="qvMoq" class="qv-moq"></div>
                
                <hr style="border: none; border-top: 1px solid #f1f5f9; margin: 10px 0;">
                
                <div class="qv-actions">
                    <a href="shop-now.html" class="cta-btn">Source This Product</a>
                    <button class="action-btn wishlist-btn" style="width: 54px; height: 54px; font-size: 20px; border: 1px solid #e2e8f0; border-radius: 14px;">
                        <i data-lucide="heart"></i>
                    </button>
                </div>

                <div style="margin-top: auto; display: flex; align-items: center; gap: 12px; color: #475569; font-size: 14px; font-weight: 500;">
                    <i data-lucide="shield-check" style="color: #4CAF50; width: 18px;"></i>
                    Orders covered by Noshahi Trade Assurance
                </div>
            </div>
        </div>
    </div>
"@

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # 1. Remove internal styles that are now in style.css
    # We target the block from .featured-card to the end of that style section or just remove the specific ones.
    # To be safe, we'll use regex to remove known blocks.
    $content = $content -replace '(?s)\s+\.featured-card.*?\}\s+\.featured-card:hover.*?\}\s+\.img-container.*?\}\s+\.img-container img.*?\}\s+@keyframes float3D.*?\}\s+\.featured-card:hover \.img-container img.*?\}', ''
    $content = $content -replace '(?s)\s+\.qv-modal.*?\}\s+\.qv-modal\.active.*?\}\s+\.qv-content.*?\}\s+\.qv-close.*?\}\s+\.qv-close:hover.*?\}', ''
    $content = $content -replace '(?s)\s+@keyframes fadeIn.*?\}\s+@keyframes slideUp.*?\}', ''
    $content = $content -replace '(?s)\.card-body.*?\}\s+\.featured-card:hover \.card-body h3.*?\}\s+\.price-row.*?\}\s+\.price-val.*?\}\s+\.moq-val.*?\}', ''
    $content = $content -replace '(?s)\.source-now-btn.*?\}\s+\.source-now-btn:hover.*?\}\s+\.supplier-row.*?\}\s+\.supplier-meta.*?\}\s+\.supplier-country.*?\}\s+\.verified-pro.*?\}', ''

    # 2. Replace old modal HTML with new one
    $content = $content -replace '(?s)<div class="qv-modal".*?</div>\s+</div>\s+</div>', $newModal
    # If the above fails due to nesting, try a simpler approach if we know the end.
    # In most files it ends with </div> </div> </div> (closing modal, content, info-side/etc)
    # Actually, let's just look for <div class="qv-modal" id="quickViewModal"> ... </div> (the matching one)
    # Note: Regex and nested divs are hard, but our structure is predictable.
    
    # 3. Remove internal JS logic
    $content = $content -replace '(?s)<script>.*?const modal = document\.getElementById\(''quickViewModal''\);.*?function closeQuickView\(\).*?</script>', '<script src="script.js"></script>'

    Set-Content $file.FullName $content
    Write-Host "Processed $($file.Name)"
}

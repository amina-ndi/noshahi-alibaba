$indexFile = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($indexFile)

# Function to generate card HTML based on style
function Get-CardHTML($style, $prefix, $index) {
    $imgUrl = "https://images.unsplash.com/photo-15" + [manual_seed]::Next(100000, 999999) + "?q=80&w=600&auto=format&fit=crop"
    # Actually use some variety
    $imgs = @(
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e",
        "https://images.unsplash.com/photo-1590658268037-6bf12165a8df",
        "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=600&auto=format&fit=crop"
    
    return @"
                <div class="$style card-base" onclick="openModal(this)">
                    <div class="img-box">
                        <img src="$imgUrl" alt="Product $index">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium $prefix Item $($index+1) - Best Seller Quality</div>
                        <div class="price">PKR $(Get-Random -Minimum 10000 -Maximum 500000),000</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                        <button class="source-btn">Source Now</button>
                    </div>
                </div>
"@
}

# Clear existing sections after hero/categories but before load more
$topPart = $content.Substring(0, $content.IndexOf('<section'))
$bottomPart = $content.Substring($content.IndexOf('<!-- Load More Container -->'))

$newSections = @"
        <!-- Section 1: Hot Deals -->
        <section>
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Hot Global Deals</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-bold-dark" "Hot Deal" $i
}

$newSections += @"
            </div>
        </section>

        <hr class="section-divider">

        <!-- Section 2: Luxury Selections -->
        <section>
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">💎 Luxury Elite Selections</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-glass" "Luxury" $i
}

$newSections += @"
            </div>
        </section>
        
        <hr class="section-divider">
"@

$finalContent = $topPart + $newSections + $bottomPart

[System.IO.File]::WriteAllText($indexFile, $finalContent)
Write-Host "Rebuilt index.html with 2 streamlined sections of 8 cards each."

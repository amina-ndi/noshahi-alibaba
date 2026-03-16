$indexFile = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($indexFile)

# Function to generate card HTML
function Get-CardHTML($style, $prefix, $index) {
    $imgs = @(
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e",
        "https://images.unsplash.com/photo-1590658268037-6bf12165a8df",
        "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f",
        "https://images.unsplash.com/photo-1583394838336-acd977736f90"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=600&auto=format&fit=crop"
    $price = (15000, 25000, 89000, 120000, 35000, 56000, 99000, 45000)[$index % 8]
    
    return @"
                <div class="$style card-base" onclick="openModal(this)">
                    <div class="img-box">
                        <img src="$imgUrl" alt="Product $index">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium $prefix Selection Item $($index+1) - Best Seller Quality</div>
                        <div class="price">PKR $price</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                        <button class="source-btn">Source Now</button>
                    </div>
                </div>
"@
}

# Find marker for sections start
$heroMarker = "</header>"
if ($content -match '<div class="hero-section">') { $heroMarker = '</div>\s*</section>' }

$startIdx = [regex]::Match($content, '(?s)<div class="hero-section">.*?</div>\s*</section>').Index + [regex]::Match($content, '(?s)<div class="hero-section">.*?</div>\s*</section>').Length
if ($startIdx -eq 0) { $startIdx = $content.IndexOf('</header>') + 9 }

$endIdx = $content.IndexOf('<!-- Load More Container -->')

$topPart = $content.Substring(0, $startIdx)
$bottomPart = $content.Substring($endIdx)

$newSections = @"

        <!-- Section 1: Global Best Sellers -->
        <section style="padding: 60px 0;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🌍 Global Best Sellers</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-bold-dark" "Global Best Seller" $i
}

$newSections += @"
            </div>
        </section>

        <hr class="section-divider">

        <!-- Section 2: Premium Tech & Electronics -->
        <section style="padding: 60px 0;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">⚡ Premium Tech & Future Electronics</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-glass" "Premium Tech" $i
}

$newSections += @"
            </div>
        </section>
        
        <hr class="section-divider">
"@

$finalContent = $topPart + $newSections + $bottomPart

[System.IO.File]::WriteAllText($indexFile, $finalContent)
Write-Host "Rebuilt index.html successfully."

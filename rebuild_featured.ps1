$filePath = "e:\NoshahiBaba\featured.html"
$content = [System.IO.File]::ReadAllText($filePath)

# Helper function for card HTML
function Get-CardHTML($style, $prefix, $index) {
    $imgs = @(
        "https://images.unsplash.com/photo-1585298723682-7115561c51b7",
        "https://images.unsplash.com/photo-1631553127988-3475760824bc",
        "https://images.unsplash.com/photo-1559302504-64aae6ca6b6d",
        "https://images.unsplash.com/photo-1567016376408-0226e4d0c1ea",
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=800&auto=format&fit=crop"
    $price = (2500, 450000, 18500, 125000, 32000, 15000, 89000, 56000)[$index % 8]
    
    return @"
                <div class="$style card-base">
                    <div class="img-box">
                        <img src="$imgUrl" alt="Featured $index">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium $prefix Selection - Diamond Verified Manufacturer</div>
                        <div class="price">PKR $($price).000</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                        <button class="source-btn">Source Now</button>
                    </div>
                </div>
"@
}

# Extract Top Part (up to filter bar end)
$mainStart = $content.IndexOf('<main')
$topPart = $content.Substring(0, $mainStart)

# Define New Main Content
$newMain = @"
    <main class="container-fluid" style="padding: 40px 0;">
        <!-- Section 1: Platinum Featured Innovations -->
        <section style="margin-bottom: 60px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">💎 Platinum Featured Innovations</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newMain += Get-CardHTML "card-bold-dark" "Platinum" $i
}

$newMain += @"
            </div>
        </section>

        <hr class="section-divider">

        <!-- Section 2: Trending Global Best Sellers -->
        <section style="margin-top: 60px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Trending Global Best Sellers</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newMain += Get-CardHTML "card-glass" "Trending" $i
}

$newMain += @"
            </div>
        </section>
    </main>
"@

# Extract Footer Part (it was inside main in previous version, so let's just find footer start)
$footerStartPos = $content.IndexOf('<footer')
$bottomNavStartPos = $content.IndexOf('<div class="mobile-bottom-nav">')
$footerPart = $content.Substring($footerStartPos, $bottomNavStartPos - $footerStartPos)
$endPart = $content.Substring($bottomNavStartPos)

$finalHtml = $topPart + $newMain + $footerPart + $endPart

[System.IO.File]::WriteAllText($filePath, $finalHtml)
Write-Host "Rebuilt featured.html with 2 sections of 2 lines each."

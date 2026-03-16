$indexFile = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($indexFile)

# Function to generate card HTML
function Get-CardHTML($style, $prefix, $index, $cat) {
    if ($cat -eq "Electronics") {
        $imgs = @(
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
            "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
            "https://images.unsplash.com/photo-1546435770-a3e426bf472b",
            "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f",
            "https://images.unsplash.com/photo-1583394838336-acd977736f90",
            "https://images.unsplash.com/photo-1590658268037-6bf12165a8df",
            "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f",
            "https://images.unsplash.com/photo-1550009158-9ebf69173e03"
        )
    } else {
        $imgs = @(
            "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
            "https://images.unsplash.com/photo-1560393464-5c69a73c5770",
            "https://images.unsplash.com/photo-1572569438068-4099edbf738e",
            "https://images.unsplash.com/photo-1491553895911-0055eca6402d",
            "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
            "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f",
            "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f"
        )
    }
    
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=600&auto=format&fit=crop"
    $basePrices = @(125, 45, 89, 210, 35, 78, 99, 150)
    $price = $basePrices[$index % 8]
    
    return @"
                <div class="$style card-base" onclick="openModal(this)">
                    <div class="img-box">
                        <img src="$imgUrl" alt="Product $index">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium $prefix - Certified $cat Quality Selection</div>
                        <div class="price">PKR $($price),000</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                        <button class="source-btn">Source Now</button>
                    </div>
                </div>
"@
}

# 1. Clear out the sections between hero and load more
$heroMarker = '<div class="hero-section">'
$loadMoreMarker = '<!-- Load More Container -->'

$heroPos = $content.IndexOf($heroMarker)
# Find the end of the hero section div
$heroEndIdx = $content.IndexOf('</header>') + 9 # Just a safe bet for the start of main content

$loadMorePos = $content.IndexOf($loadMoreMarker)

$topPart = $content.Substring(0, $heroEndIdx)
$bottomPart = $content.Substring($loadMorePos)

$newSections = @"

        <!-- Section 1: Future Tech & High-ROI Electronics -->
        <section style="padding: 60px 0;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">⚡ Future Tech & Consumer Electronics</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

# generate 8 cards (2 lines of 4)
for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-bold-dark" "Smart Device" $i "Electronics"
}

$newSections += @"
            </div>
        </section>

        <hr class="section-divider">

        <!-- Section 2: Global Premium Marketplace (Luxury Selection) -->
        <section style="padding: 60px 0;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">💎 Elite Global Diamond Selections</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newSections += Get-CardHTML "card-glass" "Luxury" $i "Premium"
}

$newSections += @"
            </div>
        </section>
        
        <hr class="section-divider">
"@

$finalContent = $topPart + $newSections + $bottomPart

[System.IO.File]::WriteAllText($indexFile, $finalContent)
Write-Host "Rebuilt index.html with Electronics focus and 2 premium sections."

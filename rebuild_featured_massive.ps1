$filePath = "e:\NoshahiBaba\featured.html"
$content = [System.IO.File]::ReadAllText($filePath)

# Function for card HTML
function Get-CardHTML($style, $prefix, $index, $cat) {
    $imgs = @(
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        "https://images.unsplash.com/photo-1560393464-5c69a73c5770",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e",
        "https://images.unsplash.com/photo-1491553895911-0055eca6402d",
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        "https://images.unsplash.com/photo-1546435770-a3e426bf472b",
        "https://images.unsplash.com/photo-1550009158-9ebf69173e03",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f",
        "https://images.unsplash.com/photo-1583394838336-acd977736f90",
        "https://images.unsplash.com/photo-1496171367470-9ed9a91ea931",
        "https://images.unsplash.com/photo-1498049794561-7780e7231661"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=800&auto=format&fit=crop"
    $basePrices = @(12, 45, 89, 210, 35, 78, 99, 150, 65, 42, 19, 134)
    $price = $basePrices[$index % $basePrices.Length]
    
    return @"
                                <div class="$style card-base" onclick="openModal(this)">
                                    <div class="img-box">
                                        <img src="$imgUrl" alt="Product $index">
                                    </div>
                                    <div class="prod-info">
                                        <div class="title">Premium $prefix - Certified $cat #$($index+1)</div>
                                        <div class="price">PKR $($price),000</div>
                                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                                        <button class="source-btn">Source Now</button>
                                    </div>
                                </div>
"@
}

# Identify Parts
$mainStartIdx = $content.IndexOf('<main')
$footerStartIdx = $content.IndexOf('<footer')
$topPart = $content.Substring(0, $mainStartIdx)
$bottomPart = $content.Substring($footerStartIdx)

# Rebuild Main with 30 CARDS in each Carousel for "Maximum Variety"
$newMain = @"
    <main class="container-fluid" style="padding: 60px 0;">
        <!-- Section 1: Platinum Featured Innovations -->
        <section style="margin-bottom: 80px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">💎 Platinum Featured Innovations</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $newMain += Get-CardHTML "card-bold-dark" "Platinum" $i "Innovations"
}

$newMain += @"
            </div>
        </section>

        <hr class="section-divider">

        <!-- Section 2: Trending & Best Sellers with MASSIVE Dual Carousels (30 Cards Each) -->
        <section style="margin-top: 60px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Trending Global Best Sellers</h2>
            </div>
            
            <div class="dual-carousel-row container-fluid">
                <!-- Carousel 1: Brand Selections (30 Global Brands) -->
                <div class="mini-carousel-wrapper">
                    <div class="mini-carousel-header">
                        <div class="mini-carousel-title"><i data-lucide="award"></i> Elite Brand Selections</div>
                        <div class="mini-carousel-nav">
                            <button class="mini-nav-btn prev" onclick="moveSlide(this, -1)"><i data-lucide="chevron-left"></i></button>
                            <button class="mini-nav-btn next" onclick="moveSlide(this, 1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                    </div>
                    <div class="mini-carousel-viewport">
                        <div class="mini-carousel-track">
"@

# generate 30 items for carousel 1
for ($i=0; $i -lt 30; $i++) {
    $newMain += Get-CardHTML "card-glass" "Brand Pick" $i "Excellence"
}

$newMain += @"
                        </div>
                    </div>
                </div>

                <!-- Carousel 2: Weekly Top Picks (30 Trending Items) -->
                <div class="mini-carousel-wrapper">
                    <div class="mini-carousel-header">
                        <div class="mini-carousel-title"><i data-lucide="trending-up"></i> Hot Weekly Picks</div>
                        <div class="mini-carousel-nav">
                            <button class="mini-nav-btn prev" onclick="moveSlide(this, -1)"><i data-lucide="chevron-left"></i></button>
                            <button class="mini-nav-btn next" onclick="moveSlide(this, 1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                    </div>
                    <div class="mini-carousel-viewport">
                        <div class="mini-carousel-track">
"@

# generate 30 items for carousel 2
for ($i=30; $i -lt 60; $i++) {
    $newMain += Get-CardHTML "card-glass" "Hot Pick" $i "Premium"
}

$newMain += @"
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Dynamic Carousel Script -->
        <script>
            function moveSlide(btn, direction) {
                const wrapper = btn.closest('.mini-carousel-wrapper');
                const track = wrapper.querySelector('.mini-carousel-track');
                const cards = track.querySelectorAll('.card-base');
                
                const cardWidth = cards[0].getBoundingClientRect().width;
                const gap = 20; // Internal gap
                const step = cardWidth + gap;
                
                if (!track.dataset.pos) track.dataset.pos = 0;
                let currentPos = parseInt(track.dataset.pos);
                
                // For 30 cards, visible 2. Max pos is 28.
                const maxPos = cards.length - 2;
                
                currentPos += direction;
                
                // Loop back for endless feel
                if (currentPos < 0) currentPos = maxPos;
                if (currentPos > maxPos) currentPos = 0;
                
                track.style.transform = `translateX(-` + (currentPos * step) + `px)`;
                track.dataset.pos = currentPos;
            }
        </script>
    </main>
"@

$finalContent = $topPart + $newMain + $bottomPart
[System.IO.File]::WriteAllText($filePath, $finalContent)
Write-Host "Rebuilt featured.html with 30-card carousels and infinite loop logic."

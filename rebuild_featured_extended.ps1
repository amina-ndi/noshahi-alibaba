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
        "https://images.unsplash.com/photo-1583394838336-acd977736f90"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=800&auto=format&fit=crop"
    $basePrices = @(12, 45, 89, 210, 35, 78, 99, 150, 65, 42)
    $price = $basePrices[$index % 10]
    
    return @"
                                <div class="$style card-base" onclick="openModal(this)">
                                    <div class="img-box">
                                        <img src="$imgUrl" alt="Product $index">
                                    </div>
                                    <div class="prod-info">
                                        <div class="title">Premium $prefix Selection - Diamond $cat $($index+1)</div>
                                        <div class="price">PKR $($price),000</div>
                                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                                        <button class="source-btn">Source Now</button>
                                    </div>
                                </div>
"@
}

# Identify Parts
$mainStart = $content.IndexOf('<main')
$footerStart = $content.IndexOf('<footer')
$topPart = $content.Substring(0, $mainStart)
$bottomPart = $content.Substring($footerStart)

# Rebuild Main with MORE CARDS in Carousels
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

        <!-- Section 2: Trending & Best Sellers with EXTENDED Dual Carousels -->
        <section style="margin-top: 60px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Trending Global Best Sellers</h2>
            </div>
            
            <div class="dual-carousel-row container-fluid">
                <!-- Carousel 1: Brand Selections (12 items) -->
                <div class="mini-carousel-wrapper">
                    <div class="mini-carousel-header">
                        <div class="mini-carousel-title"><i data-lucide="award"></i> Brand Selections</div>
                        <div class="mini-carousel-nav">
                            <button class="mini-nav-btn prev" onclick="moveSlide(this, -1)"><i data-lucide="chevron-left"></i></button>
                            <button class="mini-nav-btn next" onclick="moveSlide(this, 1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                    </div>
                    <div class="mini-carousel-viewport">
                        <div class="mini-carousel-track">
"@

# generate 12 items for carousel 1
for ($i=0; $i -lt 12; $i++) {
    $newMain += Get-CardHTML "card-glass" "Brand Pick" $i "Enterprise"
}

$newMain += @"
                        </div>
                    </div>
                </div>

                <!-- Carousel 2: Weekly Top Picks (12 items) -->
                <div class="mini-carousel-wrapper">
                    <div class="mini-carousel-header">
                        <div class="mini-carousel-title"><i data-lucide="trending-up"></i> Weekly Top Picks</div>
                        <div class="mini-carousel-nav">
                            <button class="mini-nav-btn prev" onclick="moveSlide(this, -1)"><i data-lucide="chevron-left"></i></button>
                            <button class="mini-nav-btn next" onclick="moveSlide(this, 1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                    </div>
                    <div class="mini-carousel-viewport">
                        <div class="mini-carousel-track">
"@

# generate 12 items for carousel 2
for ($i=12; $i -lt 24; $i++) {
    $newMain += Get-CardHTML "card-glass" "Top Pick" $i "Premium"
}

$newMain += @"
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Carousel Script -->
        <script>
            function moveSlide(btn, direction) {
                const wrapper = btn.closest('.mini-carousel-wrapper');
                const track = wrapper.querySelector('.mini-carousel-track');
                const cards = track.querySelectorAll('.card-base');
                
                // Calculate precise offset including gap
                const firstCard = cards[0];
                const cardWidth = firstCard.getBoundingClientRect().width;
                const gap = 20; // from CSS gap: 20px
                const stepWidth = cardWidth + gap;
                
                if (!track.dataset.pos) track.dataset.pos = 0;
                let currentPos = parseInt(track.dataset.pos);
                
                // Total cards 12, visible 2. Max pos is 10 (so 2 last cards are visible)
                const maxPos = cards.length - 2;
                
                currentPos += direction;
                if (currentPos < 0) currentPos = 0;
                if (currentPos > maxPos) currentPos = maxPos;
                
                track.style.transform = `translateX(-` + (currentPos * stepWidth) + `px)`;
                track.dataset.pos = currentPos;
            }
        </script>
    </main>
"@

$finalContent = $topPart + $newMain + $bottomPart
[System.IO.File]::WriteAllText($filePath, $finalContent)
Write-Host "Rebuilt featured.html with EXTENDED dual carousels (12 cards each)."

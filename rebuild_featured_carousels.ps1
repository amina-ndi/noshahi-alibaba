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
        "https://images.unsplash.com/photo-1550009158-9ebf69173e03"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=800&auto=format&fit=crop"
    $price = (12, 45, 89, 210, 35, 78, 99, 150)[$index % 8]
    
    return @"
                                <div class="$style card-base" onclick="openModal(this)">
                                    <div class="img-box">
                                        <img src="$imgUrl" alt="Product $index">
                                    </div>
                                    <div class="prod-info">
                                        <div class="title">Premium $prefix - Certified $cat</div>
                                        <div class="price">PKR $($price),000</div>
                                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                                        <button class="source-btn">Source Now</button>
                                    </div>
                                </div>
"@
}

# 1. Identify Sections
$mainStart = $content.IndexOf('<main')
$footerStart = $content.IndexOf('<footer')
$topPart = $content.Substring(0, $mainStart)
$bottomPart = $content.Substring($footerStart)

# 2. Rebuild Section 1 (Regular Grid)
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

        <!-- Section 2: Trending & Best Sellers with Dual Carousels -->
        <section style="margin-top: 60px;">
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Trending Global Best Sellers</h2>
            </div>
            
            <div class="dual-carousel-row container-fluid">
                <!-- Carousel 1: Brand Selections -->
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

# generate 4 items for carousel 1 (2 visible at a time)
for ($i=0; $i -lt 4; $i++) {
    $newMain += Get-CardHTML "card-glass" "Brand Pick" $i "Enterprise"
}

$newMain += @"
                        </div>
                    </div>
                </div>

                <!-- Carousel 2: Weekly Top Picks -->
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

# generate 4 items for carousel 2
for ($i=4; $i -lt 8; $i++) {
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
                const cardWidth = cards[0].offsetWidth + 20; // 20 is the gap
                
                if (!track.dataset.pos) track.dataset.pos = 0;
                let currentPos = parseInt(track.dataset.pos);
                
                // For 4 cards total, 2 visible, we can only slide once (max 2 cards hidden)
                // Limit pos between 0 and 2
                currentPos += direction;
                if (currentPos < 0) currentPos = 0;
                if (currentPos > 2) currentPos = 2;
                
                track.style.transform = `translateX(-` + (currentPos * cardWidth) + `px)`;
                track.dataset.pos = currentPos;
            }
        </script>
    </main>
"@

$finalContent = $topPart + $newMain + $bottomPart
[System.IO.File]::WriteAllText($filePath, $finalContent)
Write-Host "Rebuilt featured.html with dual carousels in Section 2."

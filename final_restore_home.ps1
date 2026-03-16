$filePath = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($filePath)

# 1. Capture the Head (css, meta, etc.)
$headEnd = $content.IndexOf('</head>')
$headContent = $content.Substring(0, $headEnd)

# 2. Section Styles (Keep the custom styles)
$customStyles = @"
    <style>
        .hero-section { position: relative; width: 100%; overflow: hidden; background: #000; }
        .hero-carousel { position: relative; height: 500px; display: flex; transition: transform 0.8s ease; }
        .hero-slide { min-width: 100%; height: 100%; background-size: cover; background-position: center; display: flex; align-items: center; color: white; }
        .hero-slide::after { content: ''; position: absolute; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.4); }
        .slide-content { position: relative; z-index: 10; max-width: 800px; padding: 0 50px; }
        .slide-content h1 { font-size: 56px; font-weight: 900; margin-bottom: 20px; line-height: 1.1; }
        .slide-content p { font-size: 20px; margin-bottom: 30px; opacity: 0.9; }
        .carousel-btn { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.2); border: none; color: white; width: 50px; height: 50px; border-radius: 50%; cursor: pointer; z-index: 20; display: flex; align-items: center; justify-content: center; backdrop-filter: blur(10px); transition: all 0.3s; }
        .carousel-btn:hover { background: #FFCC00; color: #000; }
        .prev-hero { left: 20px; }
        .next-hero { right: 20px; }
        
        /* Ensure Navbar and Top Bar match Featured.html */
        .top-bar { background: #000; color: #fff; padding: 10px 0; font-size: 13px; font-weight: 500; }
        .main-header { background: #fff; padding: 25px 0; border-bottom: 1px solid #eee; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header-top-row { display: flex; align-items: center; justify-content: space-between; gap: 40px; margin-bottom: 20px; }
        .logo-text { font-size: 28px; font-weight: 800; color: #000; }
        .logo-text span { color: #FFCC00; }
        .search-container { flex: 1; }
        .search-box { display: flex; border: 2px solid #FFCC00; border-radius: 8px; overflow: hidden; height: 48px; }
        .search-type { background: #f8f9fa; padding: 0 20px; display: flex; align-items: center; border-right: 1px solid #eee; font-weight: 600; font-size: 14px; }
        .search-box input { flex: 1; border: none; padding: 0 20px; outline: none; font-size: 15px; }
        .search-btn { background: #FFCC00; border: none; padding: 0 30px; font-weight: 800; cursor: pointer; display: flex; align-items: center; gap: 8px; }
        .header-actions { display: flex; gap: 30px; }
        .action-item { display: flex; flex-direction: column; align-items: center; text-decoration: none; color: #333; gap: 4px; font-size: 12px; font-weight: 600; }
        .action-item i { width: 22px; height: 22px; }
        .header-nav-row { display: flex; align-items: center; gap: 40px; }
        .all-categories { display: flex; align-items: center; gap: 10px; font-weight: 800; cursor: pointer; font-size: 15px; }
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { text-decoration: none; color: #333; font-weight: 700; font-size: 15px; display: flex; align-items: center; gap: 8px; transition: color 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: #FFCC00; }
    </style>
"@

# Helper to generate cards
function Get-Card($style, $title, $prefix, $index) {
    return @"
                <div class="$style card-base">
                    <div class="img-box">
                        <img src="https://images.unsplash.com/photo-1$(300000 + $index)?q=80&w=600&auto=format&fit=crop" alt="Product">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title" style="font-weight: 700; font-size: 15px; height: 40px; overflow: hidden; line-height: 1.4;">$prefix - $title Model #$($index+1)</div>
                        <div class="price" style="color: #000; font-size: 20px; font-weight: 800; margin: 10px 0;">PKR $(50 + $index),000</div>
                        <div class="supplier-badge" style="font-size: 12px; color: #666; display: flex; align-items: center; gap: 5px;"><i data-lucide="shield-check" style="width: 14px; color: #FFCC00;"></i> Verified Supplier</div>
                        <button class="source-btn" style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 10px; border-radius: 6px; font-weight: 800; cursor: pointer;">Source Now</button>
                    </div>
                </div>
"@
}

# 12 Sections Setup
$secMeta = @(
    @{t="⚡ Future Tech & Electronics"; s="card-bold-dark"; p="Smart Tech"},
    @{t="💎 Luxury Diamond Selections"; s="card-glass"; p="Elite Item"},
    @{t="🏠 Home & Garden Innovations"; s="card-style-1"; p="Home Pro"},
    @{t="👜 Fashion & Apparel Trends"; s="card-style-2"; p="Style Plus"},
    @{t="🛠️ Industrial Heavy Machinery"; s="card-style-3"; p="Iron Works"},
    @{t="Beauty & Personal Care"; s="card-style-4"; p="Luxe Glow"},
    @{t="Automotive & Spare Parts"; s="card-style-5"; p="Auto Master"},
    @{t="Sports & Outdoor Gear"; s="card-bold-dark"; p="Peak Sport"},
    @{t="Mother & Baby Essentials"; s="card-glass"; p="Gentle Care"},
    @{t="Office & Furniture Solutions"; s="card-style-1"; p="Expert Desk"},
    @{t="Agriculture & Fresh Produce"; s="card-style-2"; p="Eco Harvest"},
    @{t="Security & Surveillance Tech"; s="card-style-3"; p="Safe Watch"}
)

$mainContent = "<main>`n"

foreach($s in $secMeta) {
    $idx = $secMeta.IndexOf($s)
    $disp = if($idx -lt 2) { "" } else { "style='display:none;'" }
    $hrDisp = if($idx -eq 0) { "style='display:none;'" } else { if($idx -lt 2) { "" } else { "style='display:none;'" } }
    
    $mainContent += "    <hr class='section-divider' $hrDisp>`n"
    $mainContent += "    <section $disp style='padding: 60px 0;'>`n"
    $mainContent += "        <div class='section-title-wrapper container-fluid'>`n"
    $mainContent += "            <h2 class='section-title'>$($s.t)</h2>`n"
    $mainContent += "        </div>`n"
    $mainContent += "        <div class='prod-grid container-fluid'>`n"
    for($i=0;$i -lt 8;$i++) { $mainContent += Get-Card $s.s $s.t $s.p $i }
    $mainContent += "        </div>`n"
    $mainContent += "    </section>`n"
}

$mainContent += @"
    <div id="loadMoreSection" style="text-align: center; margin: 60px auto;">
        <button onclick="loadMore()" class="load-more-btn" style="padding: 16px 50px; background: #FFCC00; border: none; border-radius: 12px; font-weight: 800; cursor: pointer; font-size: 18px; box-shadow: 0 10px 25px rgba(255,204,0,0.3);">Load More Categories</button>
    </div>
</main>
"@

# Combine everything
$finalHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Noshahibaba | Global B2B Marketplace</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;800;900&display=swap" rel="stylesheet">
    $customStyles
</head>
<body>
    <div class="top-bar">
        <div class="container container-flex" style="display: flex; justify-content: space-between; max-width: 1400px; margin: 0 auto; padding: 0 20px;">
            <span>Free delivery for your first order</span>
            <div class="top-bar-right" style="display: flex; gap: 20px;">
                <a href="#" style="color: white; text-decoration: none;">Help Center</a>
                <span>Ship to: PKR</span>
            </div>
        </div>
    </div>
    
    <header class="main-header">
        <div class="container" style="max-width: 1400px; margin: 0 auto; padding: 0 20px;">
            <div class="header-top-row">
                <div class="logo">
                    <a href="index.html" style="text-decoration: none;">
                        <span class="logo-text">Noshahi<span>baba</span>.com</span>
                    </a>
                </div>
                <div class="search-container">
                    <div class="search-box">
                        <div class="search-type">Products <i data-lucide="chevron-down"></i></div>
                        <input type="text" placeholder="What are you looking for...">
                        <button class="search-btn"><i data-lucide="search"></i> Search</button>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="signin.html" class="action-item"><i data-lucide="user"></i><span>Sign In</span></a>
                    <a href="messages.html" class="action-item"><i data-lucide="message-square"></i><span>Messages</span></a>
                    <a href="cart.html" class="action-item"><i data-lucide="shopping-cart"></i><span>Cart</span></a>
                </div>
            </div>
            <div class="header-nav-row">
                <div class="all-categories"><i data-lucide="menu"></i> All categories</div>
                <div class="nav-links">
                    <a href="index.html" class="active"><i data-lucide="home"></i> Home</a>
                    <a href="featured.html">Featured selections</a>
                </div>
            </div>
        </div>
    </header>

    <section class="hero-section">
        <div class="hero-carousel" id="hero-carousel">
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1600');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Elite Global Sourcing Solutions</h1>
                        <p>Connect with 10M+ verified manufacturers and scale your business globally.</p>
                        <button class="source-btn" style="padding: 15px 40px; background: #FFCC00; border:none; font-weight:800; border-radius:8px;">Start Sourcing</button>
                    </div>
                </div>
            </div>
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=1600');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Direct Factory Marketplace</h1>
                        <p>High-ROI products sourced directly from vetted production lines with Trade Assurance.</p>
                        <button class="source-btn" style="padding: 15px 40px; background: #FFCC00; border:none; font-weight:800; border-radius:8px;">View Deals</button>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-btn prev-hero" onclick="moveSlide(-1)"><i data-lucide="chevron-left"></i></button>
        <button class="carousel-btn next-hero" onclick="moveSlide(1)"><i data-lucide="chevron-right"></i></button>
    </section>

    $mainContent

    <!-- Footer copied from featured.html -->
    <footer style="background: #f8f9fa; padding: 80px 0; border-top: 1px solid #eee;">
        <div class="container" style="max-width: 1400px; margin: 0 auto; padding: 0 20px;">
            <div style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 40px;">
                <div><h4>Get Support</h4><ul style="list-style:none; padding:0; line-height:2;"><li><a href="#">Help Center</a></li><li><a href="#">Live Chat</a></li></ul></div>
                <div><h4>Trade Services</h4><ul style="list-style:none; padding:0; line-height:2;"><li><a href="#">Trade Assurance</a></li><li><a href="#">Logistics</a></li></ul></div>
                <div><h4>Source</h4><ul style="list-style:none; padding:0; line-height:2;"><li><a href="#">Top Ranking</a></li><li><a href="#">RFQ</a></li></ul></div>
                <div><h4>Sell</h4><ul style="list-style:none; padding:0; line-height:2;"><li><a href="#">Become a Supplier</a></li></ul></div>
                <div><h4>About Us</h4><ul style="list-style:none; padding:0; line-height:2;"><li><a href="#">Our Story</a></li><li><a href="#">Careers</a></li></ul></div>
            </div>
        </div>
    </footer>

    <!-- Info Modal -->
    <div id="infoModal" style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); display:none; z-index:9999; align-items:center; justify-content:center;">
        <div id="infoModalInner" style="background:#fff; width:90%; max-width:1000px; padding:40px; border-radius:20px; position:relative;">
            <button onclick="closeModal()" style="position:absolute; top:20px; right:20px; border:none; background:none; font-size:30px; cursor:pointer;">&times;</button>
        </div>
    </div>

    <script>
        let heroIdx = 0;
        const heroSlides = document.querySelectorAll('.hero-slide');
        function moveSlide(dir) {
            heroIdx = (heroIdx + dir + heroSlides.length) % heroSlides.length;
            document.getElementById('hero-carousel').style.transform = `translateX(-\${heroIdx * 100}%)`;
        }
        setInterval(() => moveSlide(1), 5000);

        window.allSections = Array.from(document.querySelectorAll('main > section'));
        window.allHrs = Array.from(document.querySelectorAll('main > hr'));
        window.visibleCount = 2;

        function loadMore() {
            const next = window.visibleCount + 2;
            for(let i=window.visibleCount; i<next && i<window.allSections.length; i++) {
                window.allSections[i].style.display = 'block';
                if(window.allHrs[i]) window.allHrs[i].style.display = 'block';
            }
            window.visibleCount = next;
            if(window.visibleCount >= window.allSections.length) {
                document.getElementById('loadMoreSection').style.display = 'none';
            }
            if(window.lucide) lucide.createIcons();
        }

        function closeModal() {
            document.getElementById('infoModal').style.display = 'none';
        }

        document.querySelectorAll('.card-base').forEach(card => {
            card.addEventListener('click', () => {
                const title = card.querySelector('.title').innerText;
                const price = card.querySelector('.price').innerText;
                const img = card.querySelector('img').src;
                document.getElementById('infoModalInner').innerHTML = `
                    <button onclick="closeModal()" style="position:absolute; top:20px; right:20px; border:none; background:none; font-size:30px; cursor:pointer;">&times;</button>
                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:40px;">
                        <img src="\${img}" style="width:100%; border-radius:12px;">
                        <div>
                            <h2 style="font-size:32px; margin-bottom:10px;">\${title}</h2>
                            <p style="font-size:24px; font-weight:800; color:#FFCC00; margin-bottom:20px;">\${price}</p>
                            <p>Premium B2B quality product. Sourced from diamond-verified manufacturers.</p>
                            <button style="width:100%; padding:15px; background:#000; color:#fff; border:none; border-radius:8px; margin-top:20px; font-weight:800;">Contact Supplier</button>
                        </div>
                    </div>
                `;
                document.getElementById('infoModal').style.display = 'flex';
            });
        });

        lucide.createIcons();
    </script>
</body>
</html>
"@

[System.IO.File]::WriteAllText($filePath, $finalHtml)
Write-Host "Restored complete index.html with Navbar, Hero and 12 working sections."

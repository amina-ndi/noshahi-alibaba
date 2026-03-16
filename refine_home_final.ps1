$filePath = "e:\NoshahiBaba\index.html"

# Card Generator
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

# 12 Sections Definitions
$secMeta = @(
    @{t="⚡ Future Tech & Electronics"; s="card-bold-dark"; p="Smart Tech"},
    @{t="💎 Luxury Diamond Selections"; s="card-glass"; p="Elite Item"},
    @{t="🏠 Home & Garden Innovations"; s="card-style-1"; p="Home Pro"},
    @{t="👜 Fashion & Apparel Trends"; s="card-style-2"; p="Style Plus"},
    @{t="🛠️ Industrial Heavy Machinery"; s="card-style-3"; p="Iron Works"},
    @{t="✨ Beauty & Personal Care"; s="card-style-4"; p="Luxe Glow"},
    @{t="🚗 Automotive & Spare Parts"; s="card-style-5"; p="Auto Master"},
    @{t="⚽ Sports & Outdoor Gear"; s="card-bold-dark"; p="Peak Sport"},
    @{t="🍼 Mother & Baby Essentials"; s="card-glass"; p="Gentle Care"},
    @{t="🏢 Office & Furniture Solutions"; s="card-style-1"; p="Expert Desk"},
    @{t="🚜 Agriculture & Fresh Produce"; s="card-style-2"; p="Eco Harvest"},
    @{t="🛡️ Security & Surveillance Tech"; s="card-style-3"; p="Safe Watch"}
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
    <style>
        body { background: #fff !important; }
        .hero-section { position: relative; width: 100%; overflow: hidden; background: #000; }
        .hero-carousel { position: relative; height: 500px; display: flex; transition: transform 0.8s ease; }
        .hero-slide { min-width: 100%; height: 100%; background-size: cover; background-position: center; display: flex; align-items: center; color: white; position: relative; }
        .hero-slide::after { content: ''; position: absolute; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.5); }
        .slide-content { position: relative; z-index: 10; max-width: 800px; padding: 0 50px; }
        .slide-content h1 { font-size: 56px; font-weight: 900; margin-bottom: 20px; line-height: 1.1; }
        .slide-content p { font-size: 20px; margin-bottom: 30px; opacity: 0.9; }
        .carousel-btn { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.2); border: none; color: white; width: 50px; height: 50px; border-radius: 50%; cursor: pointer; z-index: 20; display: flex; align-items: center; justify-content: center; backdrop-filter: blur(10px); transition: all 0.3s; }
        .carousel-btn:hover { background: #FFCC00; color: #000; }
        .prev-hero { left: 20px; }
        .next-hero { right: 20px; }
        
        /* Navbar matching Featured.html */
        .top-bar { background: #000; color: #fff; padding: 10px 0; font-size: 13px; font-weight: 500; }
        .main-header { background: #fff; padding: 25px 0; border-bottom: 1px solid #eee; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header-top-row { display: flex; align-items: center; justify-content: space-between; gap: 40px; margin-bottom: 20px; max-width: 1400px; margin: 0 auto; padding: 0 20px; }
        .logo-text { font-size: 28px; font-weight: 800; color: #000; text-decoration: none; }
        .logo-text span { color: #FFCC00; }
        .search-container { flex: 1; }
        .search-box { display: flex; border: 2px solid #FFCC00; border-radius: 8px; overflow: hidden; height: 48px; }
        .search-type { background: #f8f9fa; padding: 0 20px; display: flex; align-items: center; border-right: 1px solid #eee; font-weight: 600; font-size: 14px; }
        .search-box input { flex: 1; border: none; padding: 0 20px; outline: none; font-size: 15px; }
        .search-btn { background: #FFCC00; border: none; padding: 0 30px; font-weight: 800; cursor: pointer; display: flex; align-items: center; gap: 8px; }
        .header-actions { display: flex; gap: 30px; }
        .action-item { display: flex; flex-direction: column; align-items: center; text-decoration: none; color: #333; gap: 4px; font-size: 12px; font-weight: 600; }
        .header-nav-row { display: flex; align-items: center; gap: 40px; max-width: 1400px; margin: 20px auto 0; padding: 0 20px; }
        .all-categories { display: flex; align-items: center; gap: 10px; font-weight: 800; cursor: pointer; font-size: 15px; }
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { text-decoration: none; color: #333; font-weight: 700; font-size: 15px; display: flex; align-items: center; gap: 8px; }
        .nav-links a.active { color: #FFCC00; }

        .section-divider { border: 0; height: 1px; background: #eee; margin: 40px auto; max-width: 1400px; }
        .section-title { font-size: 32px; font-weight: 800; margin-bottom: 30px; color: #111; }
        .prod-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; }
        .card-base { border: 1px solid #eee; border-radius: 12px; overflow: hidden; background: #fff; transition: 0.3s; cursor: pointer; }
        .card-base:hover { border-color: #FFCC00; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .img-box { height: 220px; background: #f8fafc; overflow: hidden; }
        .img-box img { width: 100%; height: 100%; object-fit: cover; transition: 0.5s; }
        .card-base:hover img { transform: scale(1.05); }

        @media (max-width: 1024px) { .prod-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 480px) { .prod-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <div class="top-bar">
        <div class="container" style="display: flex; justify-content: space-between; max-width: 1400px; margin: 0 auto; padding: 0 20px;">
            <span>Global Sourcing | Free Delivery for first order</span>
            <div style="display: flex; gap: 20px;">
                <a href="#" style="color: white; text-decoration: none;">Help Center</a>
                <span>Ship to: PKR</span>
            </div>
        </div>
    </div>
    
    <header class="main-header">
        <div class="header-top-row">
            <a href="index.html" class="logo-text">Noshahi<span>baba</span>.com</a>
            <div class="search-container">
                <div class="search-box">
                    <div class="search-type">Products <i data-lucide="chevron-down"></i></div>
                    <input type="text" placeholder="Search for manufacturers & products...">
                    <button class="search-btn"><i data-lucide="search"></i> Search</button>
                </div>
            </div>
            <div class="header-actions">
                <a href="signin.html" class="action-item"><i data-lucide="user"></i><span>Sign In</span></a>
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
    </header>

    <section class="hero-section">
        <div class="hero-carousel" id="hero-carousel">
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1600');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Expert Marketplace for Global Trade</h1>
                        <p>Discover 50,000+ new arrivals from verified suppliers daily.</p>
                        <button style="padding: 16px 40px; background: #FFCC00; border:none; font-weight:800; border-radius:8px;">Start Now</button>
                    </div>
                </div>
            </div>
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=1600');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Safe & Secure Sourcing</h1>
                        <p>Protect your orders from payment to delivery with Trade Assurance.</p>
                        <button style="padding: 16px 40px; background: #FFCC00; border:none; font-weight:800; border-radius:8px;">Learn More</button>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-btn prev-hero" onclick="moveSlide(-1)"><i data-lucide="chevron-left"></i></button>
        <button class="carousel-btn next-hero" onclick="moveSlide(1)"><i data-lucide="chevron-right"></i></button>
    </section>

    $mainContent

    <!-- Footer -->
    <footer style="background: #f8f9fa; padding: 80px 0; border-top: 1px solid #eee;">
        <div class="container" style="max-width: 1400px; margin: 0 auto; padding: 0 40px;">
            <div style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 40px;">
                <div><h4 style="margin-bottom:20px;">Get Support</h4><ul style="list-style:none; padding:0; line-height:2.5;"><li><a href="#" style="color:#666; text-decoration:none;">Help Center</a></li><li><a href="#" style="color:#666; text-decoration:none;">Live Chat</a></li></ul></div>
                <div><h4 style="margin-bottom:20px;">Trade Services</h4><ul style="list-style:none; padding:0; line-height:2.5;"><li><a href="#" style="color:#666; text-decoration:none;">Trade Assurance</a></li><li><a href="#" style="color:#666; text-decoration:none;">Ocean Freight</a></li></ul></div>
                <div><h4 style="margin-bottom:20px;">Source</h4><ul style="list-style:none; padding:0; line-height:2.5;"><li><a href="#" style="color:#666; text-decoration:none;">Request for Quotation</a></li><li><a href="#" style="color:#666; text-decoration:none;">Membership</a></li></ul></div>
                <div><h4 style="margin-bottom:20px;">Sell</h4><ul style="list-style:none; padding:0; line-height:2.5;"><li><a href="#" style="color:#666; text-decoration:none;">Supplier Central</a></li></ul></div>
                <div><h4 style="margin-bottom:20px;">About Us</h4><ul style="list-style:none; padding:0; line-height:2.5;"><li><a href="#" style="color:#666; text-decoration:none;">Our Story</a></li><li><a href="#" style="color:#666; text-decoration:none;">Careers</a></li></ul></div>
            </div>
        </div>
    </footer>

    <!-- Info Modal -->
    <div id="infoModal" style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); display:none; z-index:9999; align-items:center; justify-content:center;">
        <div id="infoModalInner" style="background:#fff; width:90%; max-width:1100px; padding:50px; border-radius:30px; position:relative; max-height:90vh; overflow-y:auto;">
            <!-- Content will be injected -->
        </div>
    </div>

    <script>
        // Hero
        let heroIdx = 0;
        const heroCarousel = document.getElementById('hero-carousel');
        const heroSlides = document.querySelectorAll('.hero-slide');
        function moveSlide(dir) {
            heroIdx = (heroIdx + dir + heroSlides.length) % heroSlides.length;
            heroCarousel.style.transform = `translateX(-\${heroIdx * 100}%)`;
        }
        if(heroSlides.length > 0) setInterval(() => moveSlide(1), 6000);

        // Sections
        window.allSections = Array.from(document.querySelectorAll('main > section'));
        window.allHrs = Array.from(document.querySelectorAll('main > hr'));
        window.visibleCount = 2;

        function loadMore() {
            const batchSize = 2;
            const nextLimit = window.visibleCount + batchSize;
            
            for (let i = window.visibleCount; i < nextLimit && i < window.allSections.length; i++) {
                window.allSections[i].style.display = 'block';
                if(window.allHrs[i]) window.allHrs[i].style.display = 'block';
            }
            
            window.visibleCount = nextLimit;
            if (window.visibleCount >= window.allSections.length) {
                document.getElementById('loadMoreSection').style.display = 'none';
            }
            if (window.lucide) lucide.createIcons();
        }

        // Modal
        function closeModal() {
            document.getElementById('infoModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        document.addEventListener('click', (e) => {
            const card = e.target.closest('.card-base');
            if (card && !e.target.closest('button')) {
                const title = card.querySelector('.title').innerText;
                const price = card.querySelector('.price').innerText;
                const img = card.querySelector('img').src;
                
                document.getElementById('infoModalInner').innerHTML = `
                    <button onclick="closeModal()" style="position:absolute; top:30px; right:30px; border:none; background:none; font-size:40px; cursor:pointer; color:#999;">&times;</button>
                    <div style="display:grid; grid-template-columns:1.2fr 1fr; gap:60px; align-items:center;">
                        <img src="\${img}" style="width:100%; border-radius:20px; box-shadow: 0 20px 50px rgba(0,0,0,0.1);">
                        <div>
                            <div style="background:#FFCC00; color:#000; padding:6px 15px; border-radius:6px; font-weight:800; font-size:14px; width:fit-content; margin-bottom:20px;">PREMIUM FACTORY DIRECT</div>
                            <h2 style="font-size:36px; font-weight:900; color:#111; margin-bottom:20px; line-height:1.2;">\${title}</h2>
                            <p style="font-size:32px; font-weight:900; color:#000; margin-bottom:30px;">\${price}</p>
                            <p style="color:#666; font-size:18px; line-height:1.8; margin-bottom:40px;">Authentic manufacturing quality. Each unit undergoes rigorous QC checks. Dedicated logistics support for ocean and air freight.</p>
                            <button style="width:100%; padding:20px; background:#000; color:#fff; border:none; border-radius:15px; font-weight:800; font-size:18px; cursor:pointer; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">Connect with Factory</button>
                        </div>
                    </div>
                `;
                document.getElementById('infoModal').style.display = 'flex';
                document.body.style.overflow = 'hidden';
            }
        });

        lucide.createIcons();
    </script>
</body>
</html>
"@

[System.IO.File]::WriteAllText($filePath, $finalHtml)
Write-Host "Re-generated CLEAN index.html with 12 Sections and WORKING sequential Load More."

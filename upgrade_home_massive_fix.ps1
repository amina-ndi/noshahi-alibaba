$filePath = "e:\NoshahiBaba\index.html"

# Enhanced Card Generator with "Fix" Image styling
function Get-Card($style, $title, $prefix, $index, $cat) {
    # Using a variety of high-quality unsplash IDs for fixed product looks
    $uids = @(1505740420928, 1523275335684, 1542291026, 1572569438068, 1590658268037, 1627989580309, 1526170375885, 1583394838336)
    $uid = $uids[$index % $uids.Count]
    $imgUrl = "https://images.unsplash.com/photo-$uid?q=80&w=600&auto=format&fit=crop"
    
    return @"
                <div class="$style card-base">
                    <div class="img-box" style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="$imgUrl" alt="Product" style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title" style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">$prefix - $title Special Selection #$($index+1)</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR $(65 + $index),000</div>
                        <div class="supplier-badge" style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory</div>
                        <button class="source-btn" style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source Now</button>
                    </div>
                </div>
"@
}

# 12 Sections with Unique themes and backgrounds
$secMeta = @(
    @{t="⚡ Future Tech & Electronics"; s="card-bold-dark"; p="Smart Tech"; bg="#ffffff"},
    @{t="💎 Luxury Diamond Selections"; s="card-glass"; p="Elite Item"; bg="#f8f9fc"},
    @{t="🏠 Home & Garden Innovations"; s="card-style-1"; p="Home Pro"; bg="#fffbf0"},
    @{t="👜 Fashion & Apparel Trends"; s="card-style-2"; p="Style Plus"; bg="#f4faf9"},
    @{t="🛠️ Industrial Heavy Machinery"; s="card-style-3"; p="Iron Works"; bg="#fdf8f8"},
    @{t="✨ Beauty & Personal Care"; s="card-style-4"; p="Luxe Glow"; bg="#f0f4f8"},
    @{t="🚗 Automotive & Spare Parts"; s="card-style-5"; p="Auto Master"; bg="#fcfcfc"},
    @{t="⚽ Sports & Outdoor Gear"; s="card-bold-dark"; p="Peak Sport"; bg="#fdfaf3"},
    @{t="🍼 Mother & Baby Essentials"; s="card-glass"; p="Gentle Care"; bg="#f5f5fa"},
    @{t="🏢 Office & Furniture Solutions"; s="card-style-1"; p="Expert Desk"; bg="#fff5f5"},
    @{t="🚜 Agriculture & Fresh Produce"; s="card-style-2"; p="Eco Harvest"; bg="#fdfdfd"},
    @{t="🛡️ Security & Surveillance Tech"; s="card-style-3"; p="Safe Watch"; bg="#f9f9ff"}
)

$mainContent = "<main>`n"

foreach($s in $secMeta) {
    $idx = $secMeta.IndexOf($s)
    $disp = if($idx -lt 2) { "" } else { "style='display:none;'" }
    $hrDisp = if($idx -eq 0) { "style='display:none;'" } else { if($idx -lt 2) { "" } else { "style='display:none;'" } }
    
    $mainContent += "    <hr class='section-divider' $hrDisp style='margin:0; border:0; height:1px; background:#eee;'>`n"
    $mainContent += "    <section $disp style='padding: 80px 0; background-color: $($s.bg);'>`n"
    $mainContent += "        <div class='section-title-wrapper container-fluid' style='max-width: 1400px; margin: 0 auto; padding: 0 20px;'>`n"
    $mainContent += "            <h2 class='section-title' style='font-size: 38px; font-weight: 900; margin-bottom: 40px; color: #111; position: relative;'>$($s.t)</h2>`n"
    $mainContent += "        </div>`n"
    $mainContent += "        <div class='prod-grid container-fluid' style='max-width: 1400px; margin: 0 auto; padding: 0 20px; display: grid; grid-template-columns: repeat(4, 1fr); gap: 30px;'>`n"
    
    # Generate 8 cards per section (8 * 12 = 96 cards total)
    for($i=0;$i -lt 8;$i++) { 
        $mainContent += Get-Card $s.s $s.t $s.p $i $s.t
    }
    
    $mainContent += "        </div>`n"
    $mainContent += "    </section>`n"
}

$mainContent += @"
    <div id="loadMoreSection" style="text-align: center; margin: 80px auto;">
        <button onclick="loadMore()" class="load-more-btn" style="padding: 20px 70px; background: #FFCC00; border: none; border-radius: 12px; font-weight: 900; cursor: pointer; font-size: 20px; box-shadow: 0 15px 35px rgba(255,204,0,0.4); transition: 0.3s; font-family: 'Outfit', sans-serif;">Explore Higher Efficiency Categories</button>
    </div>
</main>
"@

$finalHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Noshahibaba | Prime Global B2B Hub</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;800;900&display=swap" rel="stylesheet">
    <style>
        body { background: #fff !important; font-family: 'Outfit', sans-serif; overflow-x: hidden; }
        .hero-section { position: relative; width: 100%; overflow: hidden; background: #000; }
        .hero-carousel { position: relative; height: 550px; display: flex; transition: transform 0.8s cubic-bezier(0.7, 0, 0.3, 1); }
        .hero-slide { min-width: 100%; height: 100%; background-size: cover; background-position: center; display: flex; align-items: center; color: white; position: relative; }
        .hero-slide::after { content: ''; position: absolute; top:0; left:0; width:100%; height:100%; background: linear-gradient(90deg, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0.3) 100%); }
        .slide-content { position: relative; z-index: 10; max-width: 800px; padding: 0 50px; }
        .slide-content h1 { font-size: 64px; font-weight: 900; margin-bottom: 25px; line-height: 1.1; letter-spacing: -2px; }
        .slide-content p { font-size: 22px; margin-bottom: 40px; opacity: 0.95; font-weight: 500; }
        .carousel-btn { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.1); border: none; color: white; width: 60px; height: 60px; border-radius: 50%; cursor: pointer; z-index: 20; display: flex; align-items: center; justify-content: center; backdrop-filter: blur(15px); transition: all 0.3s; }
        .carousel-btn:hover { background: #FFCC00; color: #000; scale: 1.1; }
        .prev-hero { left: 30px; }
        .next-hero { right: 30px; }
        
        /* Premium Navbar */
        .top-bar { background: #111; color: #fff; padding: 12px 0; font-size: 14px; font-weight: 600; }
        .main-header { background: #fff; padding: 30px 0; border-bottom: 1px solid #eee; position: sticky; top: 0; z-index: 1000; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .header-top-row { display: flex; align-items: center; justify-content: space-between; gap: 50px; max-width: 1400px; margin: 0 auto; padding: 0 20px; }
        .logo-text { font-size: 32px; font-weight: 900; color: #000; text-decoration: none; }
        .logo-text span { color: #FFCC00; }
        .search-container { flex: 1; }
        .search-box { display: flex; border: 3px solid #FFCC00; border-radius: 12px; overflow: hidden; height: 55px; }
        .search-type { background: #f8f9fa; padding: 0 25px; display: flex; align-items: center; border-right: 1px solid #eee; font-weight: 700; font-size: 15px; }
        .search-box input { flex: 1; border: none; padding: 0 25px; outline: none; font-size: 16px; font-weight: 500; }
        .search-btn { background: #FFCC00; border: none; padding: 0 40px; font-weight: 900; cursor: pointer; display: flex; align-items: center; gap: 10px; font-size: 16px; }
        .header-actions { display: flex; gap: 35px; }
        .action-item { display: flex; flex-direction: column; align-items: center; text-decoration: none; color: #333; gap: 6px; font-size: 13px; font-weight: 700; transition: 0.3s; }
        .action-item:hover { color: #FFCC00; }
        .header-nav-row { display: flex; align-items: center; gap: 50px; max-width: 1400px; margin: 25px auto 0; padding: 0 20px; }
        .all-categories { display: flex; align-items: center; gap: 12px; font-weight: 900; cursor: pointer; font-size: 16px; color: #111; }
        .nav-links { display: flex; gap: 35px; }
        .nav-links a { text-decoration: none; color: #444; font-weight: 700; font-size: 16px; display: flex; align-items: center; gap: 10px; transition: 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: #FFCC00; }

        .card-base { border: 1px solid #eee; border-radius: 16px; overflow: hidden; background: #fff; transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); cursor: pointer; }
        .card-base:hover { border-color: #FFCC00; box-shadow: 0 20px 40px rgba(0,0,0,0.1); transform: translateY(-10px); }
        .card-base:hover img { transform: scale(1.1); }
        .source-btn:hover { background: #000; color: #fff; box-shadow: 0 10px 20px rgba(0,0,0,0.2); }

        @media (max-width: 1200px) { 
            .prod-grid { grid-template-columns: repeat(3, 1fr) !important; }
            .slide-content h1 { font-size: 48px; }
        }
        @media (max-width: 991px) { 
            .prod-grid { grid-template-columns: repeat(2, 1fr) !important; }
            .header-top-row { flex-direction: column; gap: 20px; }
            .search-container { width: 100%; }
        }
        @media (max-width: 480px) { 
            .prod-grid { grid-template-columns: 1fr !important; }
            .slide-content h1 { font-size: 32px; }
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <div class="container" style="display: flex; justify-content: space-between; max-width: 1400px; margin: 0 auto; padding: 0 20px;">
            <span>Prime Global Sourcing Gateway | Certified Factory Direct</span>
            <div style="display: flex; gap: 25px;">
                <a href="#" style="color: white; text-decoration: none;">Help Center</a>
                <a href="#" style="color: white; text-decoration: none;">English | PKR</a>
            </div>
        </div>
    </div>
    
    <header class="main-header">
        <div class="header-top-row">
            <a href="index.html" class="logo-text">Noshahi<span>baba</span>.com</a>
            <div class="search-container">
                <div class="search-box">
                    <div class="search-type">Products <i data-lucide="chevron-down"></i></div>
                    <input type="text" placeholder="Search by title, category or factory name...">
                    <button class="search-btn"><i data-lucide="search"></i> Search</button>
                </div>
            </div>
            <div class="header-actions">
                <a href="signin.html" class="action-item"><i data-lucide="user"></i><span>Sign In</span></a>
                <a href="messages.html" class="action-item"><i data-lucide="message-square"></i><span>Massages</span></a>
                <a href="cart.html" class="action-item"><i data-lucide="shopping-cart"></i><span>Orders</span></a>
            </div>
        </div>
        <div class="header-nav-row">
            <div class="all-categories"><i data-lucide="menu"></i> Industrial Categories</div>
            <div class="nav-links">
                <a href="index.html" class="active"><i data-lucide="home"></i> Home</a>
                <a href="featured.html">Featured selections</a>
                <a href="tradeassurance.html">Trade Assurance</a>
            </div>
        </div>
    </header>

    <section class="hero-section">
        <div class="hero-carousel" id="hero-carousel">
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1600&auto=format&fit=crop');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Premium Global Industrial Marketplace</h1>
                        <p>Streamline your procurement process with our direct-to-factory network. High compliance and Trade Assurance guaranteed.</p>
                        <button style="padding: 18px 45px; background: #FFCC00; border:none; font-weight:900; border-radius:12px; font-size:18px; cursor:pointer;">Start Sourcing</button>
                    </div>
                </div>
            </div>
            <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1600&auto=format&fit=crop');">
                <div class="container" style="max-width: 1400px; margin:0 auto; padding:0 20px;">
                    <div class="slide-content">
                        <h1>Infinite Variety. Certified Quality.</h1>
                        <p>Explore our deep inventory of 100+ categories sourced from the world's most efficient production zones.</p>
                        <button style="padding: 18px 45px; background: #FFCC00; border:none; font-weight:900; border-radius:12px; font-size:18px; cursor:pointer;">View Collection</button>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-btn prev-hero" onclick="moveSlide(-1)"><i data-lucide="chevron-left"></i></button>
        <button class="carousel-btn next-hero" onclick="moveSlide(1)"><i data-lucide="chevron-right"></i></button>
    </section>

    $mainContent

    <!-- Footer -->
    <footer style="background: #0f172a; padding: 100px 0; color: #fff;">
        <div class="container" style="max-width: 1400px; margin: 0 auto; padding: 0 40px;">
            <div style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 50px;">
                <div><h4 style="margin-bottom:25px; font-size:18px;">Get Support</h4><ul style="list-style:none; padding:0; line-height:2.8;"><li><a href="#" style="color:#94a3b8; text-decoration:none;">Help Center</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Live Chat</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Refunds & Returns</a></li></ul></div>
                <div><h4 style="margin-bottom:25px; font-size:18px;">Trade Services</h4><ul style="list-style:none; padding:0; line-height:2.8;"><li><a href="#" style="color:#94a3b8; text-decoration:none;">Trade Assurance</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Shipping & Logistics</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Inspections</a></li></ul></div>
                <div><h4 style="margin-bottom:25px; font-size:18px;">Source</h4><ul style="list-style:none; padding:0; line-height:2.8;"><li><a href="#" style="color:#94a3b8; text-decoration:none;">Request for Quotation</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Membership Programs</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Verified Suppliers</a></li></ul></div>
                <div><h4 style="margin-bottom:25px; font-size:18px;">Sell</h4><ul style="list-style:none; padding:0; line-height:2.8;"><li><a href="#" style="color:#94a3b8; text-decoration:none;">Become a Supplier</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Seller Central</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Partnership</a></li></ul></div>
                <div><h4 style="margin-bottom:25px; font-size:18px;">About Us</h4><ul style="list-style:none; padding:0; line-height:2.8;"><li><a href="#" style="color:#94a3b8; text-decoration:none;">Our Story</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Noshahi Group</a></li><li><a href="#" style="color:#94a3b8; text-decoration:none;">Careers</a></li></ul></div>
            </div>
            <div style="margin-top:80px; padding-top:40px; border-top:1px solid #1e293b; text-align:center; color:#64748b; font-size:14px;">
                © 2026 Noshahibaba.com  All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Info Modal -->
    <div id="infoModal" style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.85); display:none; z-index:9999; align-items:center; justify-content:center; backdrop-filter: blur(10px);">
        <div id="infoModalInner" style="background:#fff; width:95%; max-width:1150px; padding:60px; border-radius:35px; position:relative; max-height:90vh; overflow-y:auto; box-shadow: 0 40px 100px rgba(0,0,0,0.5);">
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
        if(heroSlides.length > 0) setInterval(() => moveSlide(1), 7000);

        // Advanced Loads More Categories
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
            
            // Scroll smoothly to the first new element
            const firstNew = window.allSections[window.visibleCount - batchSize];
            if(firstNew) {
                window.scrollTo({
                    top: firstNew.offsetTop - 150,
                    behavior: 'smooth'
                });
            }
        }

        // Professional Modal
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
                    <button onclick="closeModal()" style="position:absolute; top:40px; right:40px; border:none; background:#f1f5f9; width:60px; height:60px; border-radius:50%; font-size:45px; cursor:pointer; color:#111; display:flex; align-items:center; justify-content:center; transition:0.3s; z-index:100;">&times;</button>
                    <div style="display:grid; grid-template-columns:1.3fr 1fr; gap:80px; align-items:center;">
                        <div style="position:relative;">
                            <img src="\${img}" style="width:100%; border-radius:25px; box-shadow: 0 30px 60px rgba(0,0,0,0.15);">
                            <div style="position:absolute; top:20px; left:20px; background:#FFCC00; color:#000; padding:8px 20px; border-radius:10px; font-weight:900; box-shadow:0 5px 15px rgba(0,0,0,0.1);">FACTRY VETTED</div>
                        </div>
                        <div>
                            <div style="background:#f8fafc; color:#64748b; padding:8px 18px; border-radius:8px; font-weight:800; font-size:14px; width:fit-content; margin-bottom:25px; border:1px solid #e2e8f0;">SKU: NDI-2026-PREM</div>
                            <h2 style="font-size:42px; font-weight:900; color:#0f172a; margin-bottom:20px; line-height:1.1;">\${title}</h2>
                            <p style="font-size:36px; font-weight:900; color:#000; margin-bottom:40px; display:flex; align-items:center; gap:15px; font-family:'Outfit'">\${price} <span style="font-size:16px; color:#94a3b8; font-weight:500; text-decoration:line-through;">PKR 145,000</span></p>
                            <div style="margin-bottom:45px;">
                                <div style="display:flex; gap:15px; margin-bottom:12px; align-items:center; color:#475569; font-weight:600;"><i data-lucide="check-circle" style="color:#10b981; width:22px;"></i> ISO 9001:2015 Compliance</div>
                                <div style="display:flex; gap:15px; margin-items:center; color:#475569; font-weight:600;"><i data-lucide="check-circle" style="color:#10b981; width:22px;"></i> Optimized B2B Logistics Support</div>
                            </div>
                            <button style="width:100%; padding:25px; background:#000; color:#fff; border:none; border-radius:20px; font-weight:900; font-size:22px; cursor:pointer; box-shadow: 0 15px 40px rgba(0,0,0,0.3); transition:0.3s;" onmouseover="this.style.background='#FFCC00'; this.style.color='#000';" onmouseout="this.style.background='#000'; this.style.color='#fff';">Request Bulk Quotation</button>
                        </div>
                    </div>
                `;
                document.getElementById('infoModal').style.display = 'flex';
                document.body.style.overflow = 'hidden';
                if(window.lucide) lucide.createIcons();
            }
        });

        lucide.createIcons();
    </script>
</body>
</html>
"@

[System.IO.File]::WriteAllText($filePath, $finalHtml)
Write-Host "Upgraded Homepage: 96 Cards total (12 Unique Sections x 8 Cards), Fixed Image fit, and High-Impact Departmental Styling."

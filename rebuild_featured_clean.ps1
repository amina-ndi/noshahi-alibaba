$filePath = "e:\NoshahiBaba\featured.html"
$content = [System.IO.File]::ReadAllText($filePath)

# Helper function for card HTML
function Get-CardHTML($style, $prefix, $index, $cat) {
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
    $basePrices = @(125, 45, 89, 210, 35, 78, 99, 150)
    $price = $basePrices[$index % 8]
    
    return @"
                <div class="$style card-base" onclick="openModal(this)">
                    <div class="img-box">
                        <img src="$imgUrl" alt="Featured $index">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium $prefix Selection - Diamond Verified $cat Quality</div>
                        <div class="price">PKR $($price),000</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                        <button class="source-btn">Source Now</button>
                    </div>
                </div>
"@
}

# 1. Rebuild Head and Styles
$newHead = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Featured Selections | Noshahibaba.com</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { background-color: #fff !important; }
        .filter-bar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            padding: 15px 0;
            border-bottom: 1px solid #eee;
            position: sticky;
            top: 124px;
            z-index: 100;
        }
        .filter-links { display: flex; gap: 15px; overflow-x: auto; scrollbar-width: none; }
        .filter-links a { font-weight: 600; color: #555; font-size: 14px; padding: 10px 24px; border-radius: 999px; background: #f5f5f5; border: 1px solid #eee; }
        .filter-links a.active { background-color: var(--primary); color: #000; border-color: var(--primary); }
    </style>
</head>
"@

# 2. Rebuild Body Top (Header + Top Bar)
$topBarAndHeader = @"
<body>
    <div class="top-bar">
        <div class="container container-flex">
            <div class="top-bar-left"><span>Free delivery for your first order</span></div>
            <div class="top-bar-right">
                <a href="helpcenter.html">Help Center</a>
                <a href="regional-settings.html">Ship to: <img src="https://flagcdn.com/w20/pk.png" width="16" alt="PK"> PKR</a>
                <a href="regional-settings.html">Language: EN</a>
            </div>
        </div>
    </div>
    <header class="main-header sticky-header">
        <div class="container">
            <div class="header-top-row">
                <div class="logo"><a href="index.html"><span class="logo-text">Noshahi<span>baba</span>.com</span></a></div>
                <div class="search-container">
                    <div class="search-box">
                        <div class="search-type">Products <i data-lucide="chevron-down"></i></div>
                        <input type="text" placeholder="What are you looking for...">
                        <button class="search-btn"><i data-lucide="search"></i> <span>Search</span></button>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="signin.html" class="action-item"><i data-lucide="user"></i><span>Sign In</span></a>
                    <a href="messages.html" class="action-item"><i data-lucide="message-square"></i><span>Messages</span></a>
                    <a href="cart.html" class="action-item"><i data-lucide="shopping-cart"></i><span>Cart</span></a>
                </div>
            </div>
            <div class="header-nav-row">
                <div class="all-categories" id="all-categories-btn"><i data-lucide="menu"></i> All categories</div>
                <div class="nav-links">
                    <a href="index.html"><i data-lucide="home"></i> Home</a>
                    <a href="featured.html" class="active">Featured selections</a>
                </div>
            </div>
        </div>
    </header>
"@

# 3. Main Sections (4 per line)
$mainContent = @"
    <div class="filter-bar">
        <div class="container">
            <div class="filter-links">
                <a href="#" class="active">All Categories</a>
                <a href="electronics.html">Consumer Electronics</a>
                <a href="apparel.html">Apparel & Fashion</a>
                <a href="home-garden.html">Home & Garden</a>
                <a href="machinery.html">Machinery</a>
                <a href="beauty.html">Beauty & Personal Care</a>
            </div>
        </div>
    </div>

    <main class="container-fluid" style="padding: 60px 0;">
        <section>
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">💎 Platinum Featured Innovations</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $mainContent += Get-CardHTML "card-bold-dark" "Platinum" $i "Innovations"
}

$mainContent += @"
            </div>
        </section>

        <hr class="section-divider">

        <section>
            <div class="section-title-wrapper container-fluid">
                <h2 class="section-title">🔥 Trending Global Best Sellers</h2>
            </div>
            <div class="prod-grid container-fluid">
"@

for ($i=0; $i -lt 8; $i++) {
    $mainContent += Get-CardHTML "card-glass" "Trending" $i "Best Seller"
}

$mainContent += @"
            </div>
        </section>
    </main>
"@

# 4. Footer
$footer = @"
    <footer>
        <div class="container-fluid">
            <div class="footer-links">
                <div class="footer-col">
                    <h4>Get Support</h4>
                    <ul><li><a href="helpcenter.html">Help Center</a></li><li><a href="live-chat.html">Live Chat</a></li></ul>
                </div>
                <div class="footer-col">
                    <h4>Trade Services</h4>
                    <ul><li><a href="tradeassurance.html">Trade Assurance</a></li><li><a href="logistics.html">Shipping</a></li></ul>
                </div>
                <div class="footer-col">
                    <h4>About Us</h4>
                    <ul><li><a href="our-story.html">Our Story</a></li><li><a href="legal.html">Legal</a></li></ul>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-info">
                    <span class="copyright">© 2026 Noshahibaba.com</span>
                    <a href="privacy.html">Privacy</a><a href="terms.html">Terms</a>
                </div>
                <div class="social-links">
                    <a href="#"><i data-lucide="facebook"></i></a><a href="#"><i data-lucide="twitter"></i></a>
                    <a href="#"><i data-lucide="instagram"></i></a>
                </div>
            </div>
        </div>
    </footer>
    <div class="mobile-bottom-nav">
        <a href="index.html" class="mobile-nav-item active"><i data-lucide="home"></i><span>Home</span></a>
        <a href="#" class="mobile-nav-item"><i data-lucide="layers"></i><span>Categories</span></a>
        <a href="signin.html" class="mobile-nav-item"><i data-lucide="user"></i><span>Account</span></a>
    </div>
    <script src="script.js"></script>
    <script>lucide.createIcons();</script>
</body>
</html>
"@

$finalContent = $newHead + $topBarAndHeader + $mainContent + $footer
[System.IO.File]::WriteAllText($filePath, $finalContent)
Write-Host "Rebuilt featured.html cleanly with global 4-card grid."

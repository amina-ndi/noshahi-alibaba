$filePath = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($filePath)

# Helper function for card generation
function Get-CardHTML($style, $titlePrefix, $index, $cat) {
    $imgs = @(
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
        "https://images.unsplash.com/photo-1546435770-a3e426bf472b",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f",
        "https://images.unsplash.com/photo-1583394838336-acd977736f90",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
        "https://images.unsplash.com/photo-1560393464-5c69a73c5770",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e",
        "https://images.unsplash.com/photo-1491553895911-0055eca6402d",
        "https://images.unsplash.com/photo-1590658268037-6bf12165a8df",
        "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f",
        "https://images.unsplash.com/photo-1550009158-9ebf69173e03"
    )
    $imgUrl = $imgs[$index % $imgs.Length] + "?q=80&w=600&auto=format&fit=crop"
    $price = (Get-Random -Minimum 5 -Maximum 250)
    
    return @"
            <div class="$style card-base">
                <div class="img-box">
                    <img src="$imgUrl" alt="Product $index">
                </div>
                <div class="prod-info">
                    <div class="title">$titlePrefix - Certified $cat Selection #$($index+1)</div>
                    <div class="price">PKR $($price),000</div>
                    <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                    <button class="source-btn">Source Now</button>
                </div>
            </div>
"@
}

# Identify construction points
$headEnd = $content.IndexOf('</style>')
$topPart = $content.Substring(0, $headEnd)
$mainStart = $content.IndexOf('<main')
$footerStart = $content.IndexOf('<footer>')
$bottomPart = $content.Substring($footerStart)

# Section Definitions (12 Sections with unique names and styles)
$sections = @(
    @{title="⚡ Future Tech & Consumer Electronics"; style="card-bold-dark"; prefix="Smart Device"; cat="Electronics"; bg="#ffffff"},
    @{title="💎 Elite Global Diamond Selections"; style="card-glass"; prefix="Luxury Item"; cat="Premium"; bg="#f8f9fc"},
    @{title="🎧 High-Fidelity Audio & Sound Systems"; style="card-style-1"; prefix="Audio Pro"; cat="Acoustics"; bg="#fffbf0"},
    @{title="🏠 Modern Home & Lifestyle Innovations"; style="card-style-2"; prefix="Home Comfort"; cat="Interior"; bg="#f4faf9"},
    @{title="👜 Premium Leather & Fashion Accessories"; style="card-style-3"; prefix="Elite Gear"; cat="Fashion"; bg="#fdf8f8"},
    @{title="⌚ Luxury Watches & Precision Timepieces"; style="card-style-4"; prefix="Master Piece"; cat="Chronograph"; bg="#f0f4f8"},
    @{title="🛠️ Heavy-Duty Industrial Equipment"; style="card-style-5"; prefix="Industrial Tool"; cat="Enterprise"; bg="#fcfcfc"},
    @{title="🧴 Beauty & Personal Care Collections"; style="card-bold-dark"; prefix="Pure Skin"; cat="Wellness"; bg="#fdfaf3"},
    @{title="⚽ Professional Sports & Active Gear"; style="card-glass"; prefix="Titan Performance"; cat="Athletic"; bg="#f5f5fa"},
    @{title="🚗 Next-Gen Automotive Parts & Styling"; style="card-style-1"; prefix="Speed Master"; cat="Automotive"; bg="#fff5f5"},
    @{title="🎒 Smart Adventure & Outdoor Equipment"; style="card-style-2"; prefix="Outdoor Pro"; cat="Survival"; bg="#fdfdfd"},
    @{title="🍼 Elite Mother & Baby Care Selections"; style="card-style-3"; prefix="Gentle Care"; cat="Nursery"; bg="#f9f9ff"}
)

$newMain = "    <main>`n"

foreach($sec in $sections) {
    $idx = $sections.IndexOf($sec)
    $display = if ($idx -lt 2) { "" } else { "style='display:none;'" }
    $hrDisplay = if ($idx -lt 2) { "" } else { "style='display:none;'" }
    
    if ($idx -gt 0) { $newMain += "        <hr class='section-divider' $hrDisplay>`n" }
    
    $newMain += "        <section $display style='padding: 60px 0; background-color: $($sec.bg);'>`n"
    $newMain += "            <div class='section-title-wrapper container-fluid'>`n"
    $newMain += "                <h2 class='section-title'>$($sec.title)</h2>`n"
    $newMain += "            </div>`n"
    $newMain += "            <div class='prod-grid container-fluid'>`n"
    
    for ($i=0; $i -lt 8; $i++) {
        $newMain += Get-CardHTML $sec.style $sec.prefix $i $sec.cat
    }
    
    $newMain += "            </div>`n"
    $newMain += "        </section>`n"
}

# Add the Load More button at the end of main
$newMain += @"
        <div id="loadMoreSection" style="text-align: center; margin: 60px auto; max-width: 1400px; padding: 0 20px;">
            <button onclick="loadMore()" class="source-btn" 
                style="padding: 18px 60px; font-size: 20px; display: inline-block; width: auto; font-family: 'Outfit', sans-serif; background: #FFCC00; color: #000; font-weight: 800; border: none; border-radius: 12px; cursor: pointer; transition: all 0.3s; box-shadow: 0 8px 25px rgba(255, 204, 0, 0.4);">
                Explore More Categories
            </button>
        </div>
"@

$newMain += "    </main>`n"

# Update JS logic to handle 12 sections
$jsFix = @"
    <script>
        // Define Premium Modal Function
        window.openPremiumModal = function(imgSrc, title, priceText) {
            const detailedHTML = `
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 40px; align-items: start;">
                    <div style="background: #f8fafc; border-radius: 20px; overflow: hidden; height: 500px; display: flex; align-items: center; justify-content: center; border: 1px solid #f1f5f9;">
                        <img src="\${imgSrc}" alt="\${title}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                    </div>
                    <div class="detailed-info">
                        <div style="background: #FFCC00; color: #000; padding: 5px 12px; border-radius: 6px; font-weight: 800; font-size: 11px; width: fit-content; text-transform: uppercase; margin-bottom: 15px;">Official Selection</div>
                        <h2 style="font-size: 32px; font-weight: 800; line-height: 1.2; color: #0f172a; margin-bottom: 20px;">\${title}</h2>
                        <div class="price" style="font-size: 36px; font-weight: 900; color: #000; margin-bottom: 25px;">\${priceText}</div>

                        <p style="font-size: 16px; color: #475569; line-height: 1.6; margin-bottom: 25px;">
                            Premium B2B quality product. Sourced from diamond-verified manufacturers, ensuring consistent reliability for your global supply chain.
                        </p>

                        <ul style="margin-bottom: 30px; list-style: none; padding: 0;">
                            <li style="margin-bottom: 12px; display: flex; align-items: center; gap: 10px; color: #475569; font-weight: 600;"><i data-lucide="check" style="color: #16a085; width: 18px;"></i> ISO 9001 Certified Quality</li>
                            <li style="margin-bottom: 12px; display: flex; align-items: center; gap: 10px; color: #475569; font-weight: 600;"><i data-lucide="check" style="color: #16a085; width: 18px;"></i> Direct-to-consumer Pricing</li>
                            <li style="margin-bottom: 12px; display: flex; align-items: center; gap: 10px; color: #475569; font-weight: 600;"><i data-lucide="check" style="color: #16a085; width: 18px;"></i> Trade Assurance Protected</li>
                        </ul>

                        <div style="display: flex; gap: 15px; margin-bottom: 30px;">
                            <a href="shop-now.html" style="flex: 2; height: 55px; background: #000; color: #fff; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-weight: 800; text-decoration: none; transition: all 0.3s;">Start Order</a>
                            <button class="action-btn wishlist-btn" style="flex: 0.5; height: 55px; border-radius: 12px; border: 2px solid #e2e8f0; display: flex; align-items: center; justify-content: center; background: #fff; cursor: pointer;">
                                <i data-lucide="heart"></i>
                            </button>
                        </div>

                        <div style="padding: 15px; background: #f8fafc; border-radius: 15px; border: 1px solid #f1f5f9; display: flex; gap: 12px;">
                            <i data-lucide="truck" style="color: #2563eb; width: 20px; margin-top: 2px;"></i>
                            <div>
                                <div style="font-weight: 800; font-size: 14px; color: #0f172a;">Fast Logistics</div>
                                <p style="font-size: 12px; color: #64748b; margin: 0;">Ocean and Air freight support available globally.</p>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            document.getElementById('infoModalInner').innerHTML = detailedHTML;
            document.getElementById('infoModal').classList.add('active');
            document.body.style.overflow = 'hidden';
            if (window.lucide) {
                lucide.createIcons({ root: document.getElementById('infoModalInner') });
            }
        };

        document.addEventListener('DOMContentLoaded', () => {
            const main = document.querySelector('main');
            window.allProductSections = Array.from(main.querySelectorAll('section'));
            window.visibleCount = 2;

            // Attach click handlers to cards
            document.querySelectorAll('.card-base').forEach(card => {
                card.addEventListener('click', function(e) {
                    if (e.target.closest('.wishlist-btn') || e.target.closest('.source-btn')) return;
                    const imgSrc = this.querySelector('img').src;
                    const title = this.querySelector('.title').textContent;
                    const priceText = this.querySelector('.price').textContent;
                    window.openPremiumModal(imgSrc, title, priceText);
                });
            });

            if (window.lucide) lucide.createIcons();
        });

        function loadMore() {
            const sections = window.allProductSections;
            const nextLimit = window.visibleCount + 2;
            
            for (let i = window.visibleCount; i < nextLimit && i < sections.length; i++) {
                sections[i].style.display = 'block';
                if (sections[i].previousElementSibling && sections[i].previousElementSibling.tagName === 'HR') {
                    sections[i].previousElementSibling.style.display = 'block';
                }
            }
            
            window.visibleCount = nextLimit;
            if (window.visibleCount >= sections.length) {
                document.getElementById('loadMoreSection').style.display = 'none';
            }
            if (window.lucide) lucide.createIcons();
        }

        function closeInfoModal(e) {
            document.getElementById('infoModal').classList.remove('active');
            document.body.style.overflow = 'auto';
        }
    </script>
"@

$finalContent = $topPart + "</style>`n</head>`n<body>" + $newMain + $bottomPart
# Replace the old script block entirely in bottomPart if needed, or just append properly.
# For simplicity in this script, we'll assume bottomPart contains the modal HTML and just needs the JS updated.

[System.IO.File]::WriteAllText($filePath, $finalContent)
# Post-process to fix JS
$finalContent = [System.IO.File]::ReadAllText($filePath)
$scriptStartIdx = $finalContent.IndexOf('<script>')
$scriptEndIdx = $finalContent.LastIndexOf('</script>')
$newFinal = $finalContent.Substring(0, $scriptStartIdx) + $jsFix + $finalContent.Substring($scriptEndIdx + 9)
[System.IO.File]::WriteAllText($filePath, $newFinal)

Write-Host "Rebuilt Homepage with 12 UNIQUE SECTIONS and sequential LOAD MORE functionality."

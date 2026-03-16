const fs = require('fs');
const path = require('path');

function build() {
    const filePath = path.join('e:', 'NoshahiBaba', 'index.html');
    const content = fs.readFileSync(filePath, 'utf-8');

    const headEnd = content.indexOf('</head>');

    // Find the product grid start
    const productGridStart = content.indexOf('<!-- Product Grid -->');
    let topPart = content.substring(0, productGridStart);

    // Remove the extra links from the navbar in topPart
    // We want to keep "All categories", "Home", "Featured selections"
    // "All categories" is its own div outside .nav-links.
    // So we just replace the inner nav links and remove nav-right.
    const navLinksStart = topPart.indexOf('<div class="nav-links">');
    if (navLinksStart !== -1) {
        let navLinksEnd = topPart.indexOf('</div>', navLinksStart) + 6;
        const newNavLinks = '<div class="nav-links">\n                    <a href="index.html" class="active"><i data-lucide="home"></i> Home</a>\n                    <a href="featured.html">Featured selections</a>\n                </div>';
        topPart = topPart.substring(0, navLinksStart) + newNavLinks + topPart.substring(navLinksEnd);
    }

    const navRightStart = topPart.indexOf('<div class="nav-right">');
    if (navRightStart !== -1) {
        let navRightEnd = topPart.indexOf('</div>', navRightStart) + 6;
        topPart = topPart.substring(0, navRightStart) + topPart.substring(navRightEnd);
    }

    const css = `<style>
        body { background-color: #ffffff !important; color: #333333 !important; }
        .section-divider { border: 0; height: 1px; background: #e0e0e0; margin: 50px auto; max-width: 1400px; }
        .card-base { transition: transform 0.2s, box-shadow 0.2s !important; cursor: pointer; }
        .card-base:hover { transform: translateY(-3px) !important; box-shadow: 0 8px 25px rgba(0,0,0,0.1) !important; }
        
        .prod-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; padding: 20px 0; max-width: 1400px; margin: 0 auto; }
        
        .section-title-wrapper { text-align: center; margin-bottom: 40px; margin-top: 20px; }
        .section-title-wrapper .section-title { font-size: 34px; color: #111; font-weight: 800; position: relative; display: inline-block; padding-bottom: 15px; margin: 0;}
        .section-title-wrapper .section-title::after { content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); width: 80px; height: 5px; background: #FFCC00; border-radius: 5px; }
        
        .img-box { width: 100%; height: 240px; background: #f9f9f9; position: relative; overflow: hidden; border-bottom: 1px solid #eee; display: flex; align-items: center; justify-content: center; }
        .img-box img { width: 100%; height: 100%; object-fit: contain; padding: 10px; }
        
        /* Modal Styles */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.85); z-index: 99999; align-items: center; justify-content: center; backdrop-filter: blur(8px); }
        .modal-overlay.active { display: flex; }
        .full-card { background: white; width: 90%; max-width: 550px; border-radius: 16px; padding: 30px; position: relative; box-shadow: 0 25px 60px rgba(0,0,0,0.3); }
        .close-modal { position: absolute; top: -15px; right: -15px; background: #fff; border: 2px solid #ccc; width: 40px; height: 40px; border-radius: 50%; cursor: pointer; font-size: 24px; font-weight: bold; display: flex; align-items: center; justify-content: center; transition: all 0.2s; z-index: 2; box-shadow: 0 4px 10px rgba(0,0,0,0.2); color: #333; }
        .close-modal:hover { background: #FFCC00; border-color: #FFCC00; color: #000; transform: scale(1.1); }
        
        /* Modal specific sizing overrides */
        #modalInner .img-box { height: 350px; background: #fff; border:none; margin-bottom: 20px; border-radius: 12px; }
        #modalInner .img-box img { padding: 0; }
        #modalInner .title { font-size: 22px; height: auto; font-weight: 700; margin-bottom: 15px; line-height: 1.3;}
        #modalInner .price { font-size: 26px; margin-bottom: 15px; }
        #modalInner .source-btn { padding: 18px; font-size: 18px; margin-top: 25px; }
        #modalInner .supplier-badge { font-size: 14px; }
        
        /* Card variations */
        .card-style-1 { border: 1px solid #e5e5e5; border-radius: 12px; background: #fff; padding-bottom: 5px; overflow: hidden; }
        .card-style-1 .prod-info { padding: 20px; }
        
        .card-style-2 { border: none; background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.06); overflow: hidden; padding-bottom: 5px;}
        .card-style-2 .prod-info { padding: 20px; text-align: center; }
        
        .card-style-3 { border: 1px solid #ddd; background: #fafafa; border-radius: 8px; padding-bottom: 5px;}
        .card-style-3 .prod-info { padding: 20px; }
        
        .card-style-4 { border-radius: 16px; border: 1px solid #eee; background: #fff; border-bottom: 5px solid #FFCC00; overflow: hidden; padding-bottom: 5px;}
        .card-style-4 .prod-info { padding: 20px; }
        
        .card-style-5 { border: 1px solid #eee; background: #ffffff; position: relative; border-left: 5px solid #FFCC00; border-radius: 8px; padding-bottom: 5px;}
        .card-style-5 .prod-info { padding: 20px; }
        
        .card-base .price { color: #d9534f; font-weight: 800; font-size: 20px; margin: 8px 0; }
        .card-base .title { font-size: 16px; font-weight: 600; color: #222; line-height: 1.4; height: 44px; overflow: hidden; }
        .card-base .supplier-badge { color: #555; font-size: 13px; display: flex; align-items: center; gap: 6px; margin-top: 12px; font-weight: 500;}
        .card-base .supplier-badge svg { color: #FFCC00; } /* Yellow accent for icon */
        
        .card-base .source-btn { width: 100%; padding: 12px; background: #FFCC00; color: #000; font-weight: 700; border: none; border-radius: 8px; margin-top: 18px; cursor: pointer; transition: all 0.2s; font-size: 15px; }
        .card-base .source-btn:hover { background: #e6b800; box-shadow: 0 4px 12px rgba(255, 204, 0, 0.4); }
        
        @media (max-width: 768px) { .prod-grid { grid-template-columns: repeat(2, 1fr); gap: 15px; padding: 10px; } .img-box { height: 180px; } .section-title-wrapper .section-title { font-size: 26px; } }
        @media (max-width: 480px) { .prod-grid { grid-template-columns: 1fr; } }
        </style>
    `;

    // Inject the CSS at the right spot
    const styleEndIdx = topPart.indexOf('</head>');
    if (styleEndIdx !== -1) {
        topPart = topPart.substring(0, styleEndIdx) + css + topPart.substring(styleEndIdx);
    }

    const sectionNames = ["Just for You", "Featured Innovations", "Trending Products", "Top Rated Accessories", "New Arrivals"];
    const imageUrls = [
        "https://images.unsplash.com/photo-1546435770-a3e426bf472b?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1583394838336-acd977736f90?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1560393464-5c69a73c5770?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=600&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f?q=80&w=600&auto=format&fit=crop"
    ];

    let sectionsHtml = "";
    for (let i = 0; i < sectionNames.length; i++) {
        const styleClass = "card-style-" + (i + 1);
        sectionsHtml += "        <section>\n";
        sectionsHtml += "            <div class=\"section-title-wrapper container\">\n";
        sectionsHtml += "                <h2 class=\"section-title\">" + sectionNames[i] + "</h2>\n";
        sectionsHtml += "            </div>\n";
        sectionsHtml += "            <div class=\"prod-grid container\">\n";

        for (let j = 0; j < 20; j++) {
            const img = imageUrls[Math.floor(Math.random() * imageUrls.length)];
            const price = Math.floor(Math.random() * 235) + 15;
            sectionsHtml += "                <div class=\"" + styleClass + " card-base\" onclick=\"openModal(this)\">\n" +
                "                    <div class=\"img-box\">\n" +
                "                        <img src=\"" + img + "\" alt=\"Product " + j + "\">\n" +
                "                    </div>\n" +
                "                    <div class=\"prod-info\">\n" +
                "                        <div class=\"title\">Premium " + sectionNames[i] + " Item " + (j + 1) + " - Professional Quality Design</div>\n" +
                "                        <div class=\"price\">PKR " + price + ",000</div>\n" +
                "                        <div class=\"supplier-badge\"><i data-lucide=\"shield-check\"></i> Verified Supplier</div>\n" +
                "                        <button class=\"source-btn\">Source Now</button>\n" +
                "                    </div>\n" +
                "                </div>\n";
        }
        sectionsHtml += "            </div>\n";
        sectionsHtml += "        </section>\n";
        if (i < sectionNames.length - 1) {
            sectionsHtml += "        <hr class=\"section-divider\">\n";
        }
    }

    const modalHtml = `
    <!-- Modal Overlay -->
    <div class="modal-overlay" id="cardModal" onclick="closeModal(event)">
        <div class="full-card" id="modalContent" onclick="event.stopPropagation()">
            <button class="close-modal" onclick="closeModal(event)">&times;</button>
            <div id="modalInner"></div>
        </div>
    </div>
    <script>
        function openModal(el) {
            document.getElementById('modalInner').innerHTML = el.innerHTML;
            document.getElementById('cardModal').classList.add('active');
            // Ensure icons are re-rendered in the modal if needed
            if (window.lucide) {
                lucide.createIcons({
                    root: document.getElementById('modalInner')
                });
            }
        }
        function closeModal(e) {
            document.getElementById('cardModal').classList.remove('active');
        }
    </script>
    `;

    // Find the end of main to extract footer
    const mainEndIdx = content.indexOf('</main>');
    const bottomPart = content.substring(mainEndIdx);

    fs.writeFileSync(filePath, topPart + sectionsHtml + modalHtml + '\n' + bottomPart, 'utf-8');
}

build();

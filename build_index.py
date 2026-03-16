import random

def build():
    # Load original HTML to extract header and footer
    with open("e:\\NoshahiBaba\\index.html", "r", encoding="utf-8") as f:
        content = f.read()
        
    head_end = content.find("</head>")
    header_end = content.find("<main>")
    footer_start = content.find("<footer>")
    
    # We will reconstruct the header nav links exactly as requested
    top_part = content[:header_end]
    # Replace nav links in top_part
    nav_links_start = top_part.find('<div class="nav-links">')
    nav_links_end = top_part.find('</div>', nav_links_start) + 6
    if nav_links_start != -1:
        new_nav_links = '''<div class="nav-links">
                    <a href="index.html" class="active"><i data-lucide="home"></i> Home</a>
                    <a href="featured.html">Featured selections</a>
                </div>'''
        top_part = top_part[:nav_links_start] + new_nav_links + top_part[nav_links_end:]
        
    # Remove right part nav if needed
    nav_right_start = top_part.find('<div class="nav-right">')
    if nav_right_start != -1:
        nav_right_end = top_part.find('</div>', nav_right_start) + 6
        top_part = top_part[:nav_right_start] + top_part[nav_right_end:]

    # CSS for product sections
    css = """
    <style>
        body { background-color: #ffffff !important; color: #333333 !important; }
        .section-divider { border: 0; height: 2px; background: #e0e0e0; margin: 40px auto; max-width: 1200px; }
        
        .product-card, .tp-card, .card-style-1, .card-style-2, .card-style-3, .card-style-4, .card-style-5 {
            transition: none !important;
            transform: none !important;
            animation: none !important;
            box-shadow: none !important; /* ensure no hover box shadow animation */
        }
        
        .prod-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            padding: 20px 0;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .section-title {
            text-align: center;
            font-size: 32px;
            margin-bottom: 20px;
            color: #111;
            font-weight: 700;
        }
        
        .img-box {
            width: 100%;
            height: 200px;
            background: #fff;
            position: relative;
            overflow: hidden;
            border-bottom: 1px solid #eee;
        }
        
        .img-box img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        /* Full screen image on hover */
        .card-base:hover .img-box img {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 99999;
            background-color: rgba(255, 255, 255, 0.95);
            object-fit: contain;
            padding: 40px;
            box-sizing: border-box;
            backdrop-filter: blur(5px);
        }
        
        /* Styles */
        .card-style-1 { border: 1px solid #ddd; border-radius: 8px; background: #fff; padding-bottom: 15px; }
        .card-style-1 .prod-info { padding: 10px; }
        
        .card-style-2 { border: 2px solid #f0f0f0; background: #fff; border-radius: 4px; }
        .card-style-2 .prod-info { padding: 15px; text-align: center; }
        
        .card-style-3 { border: 1px solid #333; background: #fafafa; }
        .card-style-3 .prod-info { padding: 12px; }
        
        .card-style-4 { border-radius: 20px; border: 1px solid #eee; background: #fff; border-bottom: 4px solid #FFCC00; overflow: hidden; }
        .card-style-4 .prod-info { padding: 15px; }
        
        .card-style-5 { border: 1px solid #e0e0e0; background: #fff; position: relative; }
        .card-style-5 .prod-info { padding: 15px; background: #fcfcfc; }
        
        .price { color: #d9534f; font-weight: 700; font-size: 18px; margin: 5px 0; }
        .title { font-size: 14px; font-weight: 500; color: #333; line-height: 1.4; height: 40px; overflow: hidden; }
        .supplier-badge { color: #666; font-size: 12px; display: flex; align-items: center; gap: 5px; margin-top: 10px; }
        
        /* Top pick adjustments to make it look responsive */
        @media (max-width: 768px) {
            .prod-grid { grid-template-columns: repeat(2, 1fr); gap: 10px; }
            .img-box { height: 150px; }
            .section-title { font-size: 24px; }
        }
    </style>
    """
    
    # Inject CSS before </head>
    if head_end != -1:
        top_part = top_part[:head_end] + css + top_part[head_end:]

    main_start = '    <main class="container" style="padding-top: 40px;">\n'
    
    section_names = ["Just for You", "Featured Innovations", "Trending Products", "Top Rated Accessories", "New Arrivals"]
    image_urls = [
        "https://images.unsplash.com/photo-1546435770-a3e426bf472b?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1583394838336-acd977736f90?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1572569438068-4099edbf738e?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1560393464-5c69a73c5770?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=400&auto=format&fit=crop",
        "https://images.unsplash.com/photo-1627989580309-bfaf3e58af6f?q=80&w=400&auto=format&fit=crop",
    ]

    sections_html = ""
    for i, section in enumerate(section_names):
        style_class = f"card-style-{i+1}"
        sections_html += f'        <section>\n'
        sections_html += f'            <h2 class="section-title">{section}</h2>\n'
        sections_html += f'            <div class="prod-grid">\n'
        
        for j in range(20):
            img = random.choice(image_urls)
            price = random.randint(15, 250)
            sections_html += f'''                <div class="{style_class} card-base">
                    <div class="img-box">
                        <img src="{img}" alt="Product {j}">
                    </div>
                    <div class="prod-info">
                        <div class="title">Premium Quality Product {j+1} - Great Design</div>
                        <div class="price">PKR {price},000</div>
                        <div class="supplier-badge"><i data-lucide="shield-check"></i> Verified Supplier</div>
                    </div>
                </div>\n'''
                    
        sections_html += f'            </div>\n'
        sections_html += f'        </section>\n'
        if i < len(section_names) - 1:
            sections_html += f'        <hr class="section-divider">\n'

    main_end = '\n    </main>\n'
    
    footer_part = content[footer_start:]
    
    with open("e:\\NoshahiBaba\\index.html", "w", encoding="utf-8") as f:
        f.write(top_part + main_start + sections_html + main_end + footer_part)

if __name__ == "__main__":
    build()

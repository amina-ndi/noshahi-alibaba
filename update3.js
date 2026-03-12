const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

const newSection = `
        <!-- Premium Featured 3D Section -->
        <section class="premium-featured-section">
            <div class="container">
                <div class="pf-title-wrap">
                    <span class="pf-eyebrow">Exclusive Collection</span>
                    <h2 class="pf-title">Featured <span>Innovations</span></h2>
                </div>
                
                <div class="pf-grid">
                    <!-- Featured Product 1 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">New Arrival</span>
                            <h3>Next-Gen Virtual<br>Reality Headset</h3>
                            <p>Experience true immersion with 8K resolution and zero latency wireless tracking.</p>
                            <div class="pf-price">PKR 125,000</div>
                            <a href="featured.html" class="pf-btn">Pre-Order Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/vr_headset_3d.png" alt="VR Headset">
                        </div>
                    </div>

                    <!-- Featured Product 2 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">Limited Edition</span>
                            <h3>Cyberpunk Style<br>Gaming Console</h3>
                            <p>Power your play with the most advanced processing unit and aesthetic design.</p>
                            <div class="pf-price">PKR 180,000</div>
                            <a href="featured.html" class="pf-btn">Source Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/gaming_console_3d.png" alt="Gaming Console">
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Top Picks 3D Section -->`;

html = html.replace('<!-- Top Picks 3D Section -->', newSection);

fs.writeFileSync('index.html', html);
console.log("Updated index.html safely");

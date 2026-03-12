const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

const updatedGrid = `
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

                    <!-- Featured Product 3 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">Trending</span>
                            <h3>Futuristic Hologram<br>Smartwatch</h3>
                            <p>Track your health with the world's first interactive holographic display.</p>
                            <div class="pf-price">PKR 45,000</div>
                            <a href="featured.html" class="pf-btn">Source Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/pf_smartwatch_3d.png" alt="Futuristic Smartwatch">
                        </div>
                    </div>

                    <!-- Featured Product 4 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">Top Seller</span>
                            <h3>Quantum Audio<br>Wireless Earbuds</h3>
                            <p>Ultimate noise cancellation with true lossless audio and futuristic design.</p>
                            <div class="pf-price">PKR 28,000</div>
                            <a href="featured.html" class="pf-btn">Source Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/pf_earbuds_3d.png" alt="Wireless Earbuds">
                        </div>
                    </div>

                    <!-- Featured Product 5 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">Professional</span>
                            <h3>Autonomous AI<br>Camera Drone</h3>
                            <p>Capture cinematic 8K footage with AI-driven obstacle avoidance tracking.</p>
                            <div class="pf-price">PKR 210,000</div>
                            <a href="featured.html" class="pf-btn">Source Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/pf_drone_3d.png" alt="AI Drone">
                        </div>
                    </div>

                    <!-- Featured Product 6 -->
                    <div class="pf-card">
                        <div class="pf-content">
                            <span class="pf-badge">Smart Home</span>
                            <h3>Intelligent Home<br>Assistant Hub</h3>
                            <p>Control your entire ecosystem with intuitive voice commands and AI insights.</p>
                            <div class="pf-price">PKR 35,000</div>
                            <a href="featured.html" class="pf-btn">Source Now <i data-lucide="arrow-right"></i></a>
                        </div>
                        <div class="pf-image-wrap">
                            <div class="pf-glow"></div>
                            <img src="assets/pf_smarthub_3d.png" alt="Smart Home Hub">
                        </div>
                    </div>
                </div>`;

const regex = /<div class="pf-grid">[\s\S]*?<\/div>\s*<\/div>\s*<\/section>/;
const replaceWith = updatedGrid + "\n            </div>\n        </section>";

html = html.replace(regex, replaceWith);

fs.writeFileSync('index.html', html);
console.log("Grid updated with 6 cards successfully.");

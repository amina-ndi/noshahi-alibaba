const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

const updatedGrid = `
                <div class="toppicks-grid" style="grid-template-columns: repeat(3, 1fr);">
                    <!-- Featured Product 1 -->
                    <div class="tp-card">
                        <div class="tp-badge">New Arrival</div>
                        <div class="tp-img-wrap">
                            <img src="assets/vr_headset_3d.png" alt="VR Headset">
                            <div class="tp-glow"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Next-Gen Virtual Reality Headset</p>
                            <p class="tp-price">PKR 125,000</p>
                            <p class="tp-moq">8K Resolution Tracking</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Pre-Order Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Featured Product 2 -->
                    <div class="tp-card tp-card--featured">
                        <div class="tp-badge tp-badge--hot">Limited Edition</div>
                        <div class="tp-img-wrap">
                            <img src="assets/gaming_console_3d.png" alt="Gaming Console">
                            <div class="tp-glow tp-glow--gold"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Cyberpunk Style Gaming Console</p>
                            <p class="tp-price">PKR 180,000</p>
                            <p class="tp-moq">Advanced Processing Unit</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Source Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Featured Product 3 -->
                    <div class="tp-card">
                        <div class="tp-badge tp-badge--new">Trending</div>
                        <div class="tp-img-wrap">
                            <img src="assets/pf_smartwatch_3d.png" alt="Futuristic Smartwatch">
                            <div class="tp-glow"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Futuristic Hologram Smartwatch</p>
                            <p class="tp-price">PKR 45,000</p>
                            <p class="tp-moq">Interactive Holo Display</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Source Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Featured Product 4 -->
                    <div class="tp-card">
                        <div class="tp-badge">Top Seller</div>
                        <div class="tp-img-wrap">
                            <img src="assets/pf_earbuds_3d.png" alt="Wireless Earbuds">
                            <div class="tp-glow"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Quantum Audio Wireless Earbuds</p>
                            <p class="tp-price">PKR 28,000</p>
                            <p class="tp-moq">True Lossless Audio</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Source Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Featured Product 5 -->
                    <div class="tp-card tp-card--featured">
                        <div class="tp-badge tp-badge--hot">Professional</div>
                        <div class="tp-img-wrap">
                            <img src="assets/pf_drone_3d.png" alt="AI Drone">
                            <div class="tp-glow tp-glow--gold"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Autonomous AI Camera Drone</p>
                            <p class="tp-price">PKR 210,000</p>
                            <p class="tp-moq">8K Cinematic Footage</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Source Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Featured Product 6 -->
                    <div class="tp-card">
                        <div class="tp-badge tp-badge--new">Smart Home</div>
                        <div class="tp-img-wrap">
                            <img src="assets/pf_smarthub_3d.png" alt="Smart Home Hub">
                            <div class="tp-glow"></div>
                        </div>
                        <div class="tp-info">
                            <p class="tp-name">Intelligent Home Assistant Hub</p>
                            <p class="tp-price">PKR 35,000</p>
                            <p class="tp-moq">Voice & AI Insights</p>
                            <div class="tp-footer">
                                <span class="tp-verified"><i data-lucide="shield-check"></i> Verified Pro</span>
                                <a href="featured.html" class="tp-btn">Source Now</a>
                            </div>
                        </div>
                    </div>
                </div>`;

const regex = /<div class="pf-grid">[\s\S]*?<\/div>\s*<\/div>\s*<\/section>/;
const replaceWith = updatedGrid + "\n            </div>\n        </section>";

html = html.replace(regex, replaceWith);

fs.writeFileSync('index.html', html);
console.log("Updated HTML with tp-card elements for Featured Innovations section.");

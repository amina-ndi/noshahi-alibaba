from pathlib import Path
path = Path('index.html')
text = path.read_text()
old = '''        <section style='display:none; padding: 80px 0; background-color: #fdfaf3;'>
            <div class='section-title-wrapper container-fluid'
                style='max-width: 1400px; margin: 0 auto; padding: 0 20px;'>
                <h2 class='section-title'
                    style='font-size: 38px; font-weight: 900; margin-bottom: 40px; color: #111; position: relative;'>
                    ? Sports & Outdoor Gear</h2>
            </div>
            <div class='prod-grid container-fluid'
                style='max-width: 1400px; margin: 0 auto; padding: 0 20px; display: grid; grid-template-columns: repeat(4, 1fr); gap: 30px;'>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1633356122544-f134324a6cee?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Pro Fitness Cycle - Speed #1</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            35,000</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1631677351624-94c633a6971a?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Outdoor Camping Tent - 4 Person</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            12,000</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Adjustable Dumbbell Set Pro</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            8,500</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Yoga Mat - Eco Friendly</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            2,200</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1634128221889-82ed6efdfac3?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Fitness Tracker Watch - Smart</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            4,800</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1620121692029-d088224ddc74?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Outdoor Adventure Kayak</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            42,000</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
                <div class="card-bold-dark card-base">
                    <div class="img-box"
                        style="height: 250px; background: #fdfdfd; display: flex; align-items: center; justify-content: center; overflow: hidden; position: relative; border-bottom: 1px solid #f0f0f0;">
                        <img src="https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?q=80&w=600&auto=format&fit=crop"
                            alt="Product"
                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; display: block;">
                    </div>
                    <div class="prod-info" style="padding: 20px;">
                        <div class="title"
                            style="font-weight: 700; font-size: 15px; height: 42px; overflow: hidden; line-height: 1.4; color: #333; margin-bottom: 8px;">
                            Peak Sport - ⚽ Sports & Outdoor Gear Special Selection #4</div>
                        <div class="price" style="color: #000; font-size: 22px; font-weight: 900; margin: 5px 0;">PKR
                            8,500</div>
                        <div class="supplier-badge"
                            style="font-size: 12px; color: #777; display: flex; align-items: center; gap: 6px;"><i
                                data-lucide="shield-check" style="width: 16px; color: #FFCC00;"></i> Verified Factory
                        </div>
                        <button class="source-btn"
                            style="width: 100%; margin-top: 15px; background: #FFCC00; border: none; padding: 12px; border-radius: 8px; font-weight: 800; cursor: pointer; transition: 0.3s;">Source
                            Now</button>
                    </div>
                </div>
            </div>
        </section>'''
new = '''        <section style='display:none; padding: 80px 0; background-color: #fdfaf3;'>
            <div class='section-title-wrapper container-fluid'
                style='max-width: 1400px; margin: 0 auto; padding: 0 20px;'>
                <h2 class='section-title'
                    style='font-size: 38px; font-weight: 900; margin-bottom: 40px; color: #111; position: relative;'>
                    ? Sports & Outdoor Gear</h2>
            </div>
            <div class='container-fluid' style='max-width: 1400px; margin: 0 auto; padding: 0 20px;'>
                <div class="sports-row">
                    <div class="sports-carousel">
                        <div class="sports-nav">
                            <button class="sports-btn" onclick="slideSports(this,-1)"><i data-lucide="chevron-left"></i></button>
                            <button class="sports-btn" onclick="slideSports(this,1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                        <div class="sports-track">
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=600&auto=format&fit=crop" alt="Football">
                                <div class="body">
                                    <div class="title">Match Pro Football - GripTex</div>
                                    <div class="meta"><span class="price">PKR 3,200</span><span>MOQ 200</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=600&auto=format&fit=crop" alt="Boots">
                                <div class="body">
                                    <div class="title">Firm-Ground Cleats Elite</div>
                                    <div class="meta"><span class="price">PKR 6,800</span><span>MOQ 120</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=600&auto=format&fit=crop" alt="Dumbbells">
                                <div class="body">
                                    <div class="title">Hex Dumbbell Set (Pairs)</div>
                                    <div class="meta"><span class="price">PKR 7,500</span><span>MOQ 80</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1502741338009-cac2772e18bc?q=80&w=600&auto=format&fit=crop" alt="Backpack">
                                <div class="body">
                                    <div class="title">TrailBlaze Hiking Pack</div>
                                    <div class="meta"><span class="price">PKR 5,500</span><span>MOQ 150</span></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="sports-carousel">
                        <div class="sports-nav">
                            <button class="sports-btn" onclick="slideSports(this,-1)"><i data-lucide="chevron-left"></i></button>
                            <button class="sports-btn" onclick="slideSports(this,1)"><i data-lucide="chevron-right"></i></button>
                        </div>
                        <div class="sports-track">
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?q=80&w=600&auto=format&fit=crop" alt="Bike">
                                <div class="body">
                                    <div class="title">Carbon Road Bike AeroX</div>
                                    <div class="meta"><span class="price">PKR 85,000</span><span>MOQ 15</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1508184964240-ee0f08b1c34c?q=80&w=600&auto=format&fit=crop" alt="Helmet">
                                <div class="body">
                                    <div class="title">CarbonX Cycling Helmet</div>
                                    <div class="meta"><span class="price">PKR 9,800</span><span>MOQ 90</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1585776245991-cf89dd7fc73e?q=80&w=600&auto=format&fit=crop" alt="Tent">
                                <div class="body">
                                    <div class="title">All-Weather Camping Tent</div>
                                    <div class="meta"><span class="price">PKR 18,500</span><span>MOQ 60</span></div>
                                </div>
                            </div>
                            <div class="sports-card">
                                <img src="https://images.unsplash.com/photo-1579751626657-72bc17010498?q=80&w=600&auto=format&fit=crop" alt="Kayak">
                                <div class="body">
                                    <div class="title">Explorer Inflatable Kayak</div>
                                    <div class="meta"><span class="price">PKR 42,000</span><span>MOQ 25</span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>'''
if old not in text:
    raise SystemExit('old block not found')
path.write_text(text.replace(old,new))
print('replaced')

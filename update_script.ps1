$filePath = "e:\NoshahiBaba\script.js"
$content = [System.IO.File]::ReadAllText($filePath)

$pattern = '(?s)window\.openPremiumModal = function\(imgSrc, title, price\) \{.*?\};'
$newFunc = @"
window.openPremiumModal = function(imgSrc, title, price) {
        const modal = document.getElementById('globalPremiumModal');
        if (!modal) return;

        const infoBody = modal.querySelector('.pm-info-side');
        infoBody.innerHTML = \`
            <div class="pm-badge">Verified Supplier</div>
            <h2 class="pm-title" style="margin-bottom: 5px;">\${title}</h2>
            <div style="font-size: 14px; color: #16a085; font-weight: 700; margin-bottom: 20px;">
                <i data-lucide="check-circle" style="width: 14px; display: inline-block; vertical-align: middle;"></i> Trade Assurance Protected
            </div>
            
            <div class="pm-price" style="margin-bottom: 10px;">\${price}</div>
            <div style="font-size: 13px; color: #64748b; margin-bottom: 25px;">Minimum Order: 10 Pieces (Samples Available)</div>

            <p style="font-size: 15px; color: #475569; line-height: 1.6; margin-bottom: 30px;">
                High-performance industrial grade product. Sourced directly from diamond-tier manufacturers with ISO 9001 certification. Guaranteed export quality for global distribution.
            </p>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 35px;">
                <div style="padding: 15px; border: 1.5px solid #f1f5f9; border-radius: 12px;">
                    <div style="font-size: 11px; font-weight: 800; color: #94a3b8; text-transform: uppercase;">Lead Time</div>
                    <div style="font-size: 14px; font-weight: 700; color: #0f172a;">7-15 Days</div>
                </div>
                <div style="padding: 15px; border: 1.5px solid #f1f5f9; border-radius: 12px;">
                    <div style="font-size: 11px; font-weight: 800; color: #94a3b8; text-transform: uppercase;">Customization</div>
                    <div style="font-size: 14px; font-weight: 700; color: #0f172a;">OEM Supported</div>
                </div>
            </div>

            <div class="pm-cta">
                <a href="shop-now.html" class="pm-btn" style="flex: 3;">Start Order</a>
                <button class="pm-btn wishlist-btn" style="flex: 1; background: #fff; color: #000; border: 2px solid #e2e8f0;">
                    <i data-lucide="heart"></i>
                </button>
            </div>

            <div style="margin-top: auto; display: flex; align-items: center; gap: 15px; opacity: 0.6;">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Former_Visa_%28company%29_logo.svg/1024px-Former_Visa_%28company%29_logo.svg.png" style="height: 15px;">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png" style="height: 20px;">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/1200px-PayPal.svg.png" style="height: 15px;">
            </div>
        \`;

        document.getElementById('pmImage').src = imgSrc;
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        lucide.createIcons();
    };
"@

$content = $content -replace $pattern, $newFunc
[System.IO.File]::WriteAllText($filePath, $content)
Write-Host "script.js updated"

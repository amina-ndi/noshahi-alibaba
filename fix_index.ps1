$filePath = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($filePath)

# 1. Clear out the old loop body
$pattern = '(?s)window\.productSections\.forEach\(\(sec, idx\) => \{.*?window\.currentVisibleSections = 2;'
$newLoop = @"
window.productSections.forEach((sec, idx) => {
                    sec.style.backgroundColor = sectionBackgrounds[idx % sectionBackgrounds.length];
                    sec.style.paddingTop = '50px';
                    sec.style.paddingBottom = '50px';

                    if (sec.previousElementSibling && sec.previousElementSibling.tagName === 'HR') {
                        sec.previousElementSibling.style.display = 'none';
                    }

                    // Entire card click logic
                    sec.querySelectorAll('.card-base').forEach(card => {
                        card.removeAttribute('onclick');
                        card.addEventListener('click', function(e) {
                            if (e.target.closest('.wishlist-btn')) return;
                            const imgSrc = this.querySelector('img').src;
                            const title = this.querySelector('.title').textContent;
                            const priceText = this.querySelector('.price').textContent;
                            openDetailedModal(imgSrc, title, priceText);
                        });
                    });

                    // Action Icons (Only Wishlist)
                    sec.querySelectorAll('.card-base .img-box').forEach(box => {
                        if (box.querySelector('.action-icons')) return;
                        const actionsDiv = document.createElement('div');
                        actionsDiv.className = 'action-icons';
                        actionsDiv.style.cssText = 'right: 15px; top: 15px; opacity: 1; visibility: visible;';
                        
                        const wishBtn = document.createElement('div');
                        wishBtn.className = 'action-btn wishlist-btn';
                        wishBtn.innerHTML = '<i data-lucide="heart"></i>';
                        wishBtn.style.boxShadow = '0 8px 20px rgba(0,0,0,0.1)';
                        
                        actionsDiv.appendChild(wishBtn);
                        box.appendChild(actionsDiv);

                        wishBtn.addEventListener('click', (e) => {
                            e.stopPropagation();
                            wishBtn.style.color = '#e74c3c';
                            wishBtn.innerHTML = '<i data-lucide="heart" fill="#e74c3c"></i>';
                            if (window.lucide) lucide.createIcons({ root: wishBtn });
                            showToast("Item added to Wishlist");
                        });
                    });

                    if (idx >= 2) {
                        sec.style.display = 'none';
                    }
                });

                window.currentVisibleSections = 2;
"@

$content = $content -replace $pattern, $newLoop

# Also fix the close functions
$closePattern = '(?s)function closeModal\(e\) \{.*?\}'
$newClose = @"
function closeModal(e) {
                document.getElementById('cardModal').style.display = 'none';
                document.body.style.overflow = 'auto';
            }
"@
$content = $content -replace $closePattern, $newClose

$infoClosePattern = '(?s)function closeInfoModal\(e\) \{.*?\}'
$newInfoClose = @"
function closeInfoModal(e) {
                document.getElementById('infoModal').classList.remove('active');
                document.body.style.overflow = 'auto';
            }
"@
$content = $content -replace $infoClosePattern, $newInfoClose

[System.IO.File]::WriteAllText($filePath, $content)
Write-Host "Done"

// Initialize Lucide Icons
document.addEventListener('DOMContentLoaded', () => {
    lucide.createIcons();

    // ---- Active Nav Link Detection ----
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.nav-links a');
    navLinks.forEach(link => {
        const linkPage = link.getAttribute('href');
        if (linkPage === currentPage || (currentPage === '' && linkPage === 'index.html')) {
            link.classList.add('active');
        }
    });

    // Sticky Header Effect
    const mainHeader = document.querySelector('.main-header');
    const scrollHandler = () => {
        if (window.scrollY > 50) {
            mainHeader.classList.add('scrolled');
        } else {
            mainHeader.classList.remove('scrolled');
        }
    };
    window.addEventListener('scroll', scrollHandler);

    // Search Interactivity
    const searchBtn = document.querySelector('.search-btn');
    const searchInput = document.querySelector('.search-box input');

    if (searchBtn && searchInput) {
        searchBtn.addEventListener('click', () => {
            const query = searchInput.value.trim();
            if (query) {
                alert(`Redirecting to search for: ${query}\n(Note: This is a demo clone)`);
            } else {
                searchInput.focus();
            }
        });

        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchBtn.click();
            }
        });
    }

    // Category Hover Effect Logic
    const categoryLinks = document.querySelectorAll('.category-sidebar li');
    categoryLinks.forEach(link => {
        link.addEventListener('mouseenter', () => {
            // In a real app, this would show subcategories
        });
    });

    // Newsletter Form Submission
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const emailInput = newsletterForm.querySelector('input');
            const email = emailInput.value.trim();

            if (email && validateEmail(email)) {
                alert(`Thank you for subscribing, ${email}!\nWe'll send you the latest Noshahibaba updates.`);
                emailInput.value = '';
            } else {
                alert('Please enter a valid email address.');
            }
        });
    }

    // Smooth Scrolling for nav links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });

    // User Panel Interactivity
    const joinBtn = document.querySelector('.join-btn');
    const signinBtn = document.querySelector('.signin-btn');

    if (joinBtn) {
        joinBtn.addEventListener('click', () => {
            alert('Welcome! Redirecting you to the registration page.');
        });
    }

    if (signinBtn) {
        signinBtn.addEventListener('click', () => {
            alert('Redirecting you to the login page.');
        });
    }

    // All Categories Toggle & Dropdown Logic
    const allCategoriesBtn = document.getElementById('all-categories-btn');
    const headerNavRow = document.querySelector('.header-nav-row .container') || document.querySelector('.header-nav-row');

    const categoriesHTML = `
        <div class="categories-dropdown" id="global-categories-dropdown">
            <div class="dropdown-header mobile-only" style="padding: 15px 20px; background: #f8fafc; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
                <span style="font-weight: 700; color: #0f172a;">All Categories</span>
                <i data-lucide="x" class="close-dropdown" style="width: 20px; cursor: pointer;"></i>
            </div>
            <ul>
                <li><a href="womens-clothing.html"><i data-lucide="shopping-bag"></i> Women's Clothing</a></li>
                <li><a href="mens-clothing.html"><i data-lucide="user"></i> Men's Clothing</a></li>
                <li><a href="apparel.html"><i data-lucide="shirt"></i> Apparel & Accessories</a></li>
                <li><a href="electronics.html"><i data-lucide="cpu"></i> Consumer Electronics</a></li>
                <li><a href="home-garden.html"><i data-lucide="home"></i> Home & Garden</a></li>
                <li><a href="machinery.html"><i data-lucide="settings"></i> Machinery</a></li>
                <li><a href="beauty.html"><i data-lucide="heart"></i> Beauty & Personal Care</a></li>
                <li><a href="vehicles.html"><i data-lucide="car"></i> Vehicles & Accessories</a></li>
                <li><a href="agriculture.html"><i data-lucide="sprout"></i> Agriculture & Food</a></li>
                <li><a href="computers.html"><i data-lucide="laptop"></i> Computer & Software</a></li>
            </ul>
        </div>
    `;

    if (allCategoriesBtn && headerNavRow) {
        // Inject dropdown if not present
        if (!document.getElementById('global-categories-dropdown')) {
            headerNavRow.insertAdjacentHTML('beforeend', categoriesHTML);
            lucide.createIcons();
        }

        const dropdown = document.getElementById('global-categories-dropdown');
        const closeBtn = dropdown.querySelector('.close-dropdown');

        allCategoriesBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            const isActive = dropdown.classList.toggle('active');
            // Toggle active state for button as well if needed
            allCategoriesBtn.classList.toggle('active', isActive);
        });

        if (closeBtn) {
            closeBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                dropdown.classList.remove('active');
                allCategoriesBtn.classList.remove('active');
            });
        }

        // Close when clicking outside
        document.addEventListener('click', (e) => {
            if (!dropdown.contains(e.target) && !allCategoriesBtn.contains(e.target)) {
                dropdown.classList.remove('active');
                allCategoriesBtn.classList.remove('active');
            }
        });
    }

    // Utility function for email validation
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    // Hero Carousel Logic - Enhanced Smooth Infinite Loop
    const inner = document.getElementById('carouselInner');
    const originalSlides = document.querySelectorAll('.carousel-slide');
    const dotsContainer = document.getElementById('carouselNav');

    if (inner && originalSlides.length > 0) {
        // Clone first and last slides for infinite effect
        const firstClone = originalSlides[0].cloneNode(true);
        const lastClone = originalSlides[originalSlides.length - 1].cloneNode(true);

        inner.appendChild(firstClone);
        inner.insertBefore(lastClone, originalSlides[0]);

        const allSlides = document.querySelectorAll('.carousel-slide');
        const slideCount = originalSlides.length;
        let currentIndex = 1; // Start at the first original slide
        let isTransitioning = false;

        // Reset width and starting position
        inner.style.width = `${(slideCount + 2) * 100}%`;
        allSlides.forEach(slide => {
            slide.style.width = `${100 / (slideCount + 2)}%`;
        });

        // Initial position
        inner.style.transform = `translateX(-${currentIndex * (100 / (slideCount + 2))}%)`;

        window.moveSlide = function (n) {
            if (isTransitioning) return;
            resetAutoPlay();
            goToSlide(currentIndex + n);
        };

        window.goToSlide = function (n) {
            if (isTransitioning) return;
            isTransitioning = true;
            currentIndex = n;

            inner.style.transition = 'transform 1.2s cubic-bezier(0.7, 0, 0.3, 1)';
            inner.style.transform = `translateX(-${currentIndex * (100 / (slideCount + 2))}%)`;

            updateDots();
        };

        inner.addEventListener('transitionend', () => {
            isTransitioning = false;

            // Jump to original slides if we hit clones for infinite effect
            if (currentIndex === 0) {
                currentIndex = slideCount;
                inner.style.transition = 'none';
                inner.style.transform = `translateX(-${currentIndex * (100 / (slideCount + 2))}%)`;
            } else if (currentIndex === slideCount + 1) {
                currentIndex = 1;
                inner.style.transition = 'none';
                inner.style.transform = `translateX(-${currentIndex * (100 / (slideCount + 2))}%)`;
            }
        });

        function updateDots() {
            const dots = document.querySelectorAll('.carousel-dot');
            let activeDotIndex = currentIndex - 1;

            if (currentIndex === 0) activeDotIndex = slideCount - 1;
            if (currentIndex === slideCount + 1) activeDotIndex = 0;

            dots.forEach((dot, index) => {
                dot.classList.toggle('active', index === activeDotIndex);
            });
        }

        // Auto-play management
        let autoPlayInterval;

        function startAutoPlay() {
            autoPlayInterval = setInterval(() => {
                moveSlide(1);
            }, 7000); // 7 seconds for better readability
        }

        function resetAutoPlay() {
            clearInterval(autoPlayInterval);
            startAutoPlay();
        }

        startAutoPlay();

        const carousel = document.querySelector('.hero-carousel');
        if (carousel) {
            carousel.addEventListener('mouseenter', () => clearInterval(autoPlayInterval));
            carousel.addEventListener('mouseleave', () => startAutoPlay());
        }
    }
    // ---- Global Premium Modal & Card Logic ----
    function injectGlobalModal() {
        if (document.getElementById('globalPremiumModal')) return;

        const modalHTML = `
            <div class="premium-modal" id="globalPremiumModal">
                <div class="pm-content">
                    <div class="pm-close" id="closePremiumModal"><i data-lucide="x"></i></div>
                    <div class="pm-image-side">
                        <img id="pmImage" src="" alt="Product">
                    </div>
                    <div class="pm-info-side">
                        <span class="pm-badge">Premium Selection</span>
                        <h2 id="pmTitle" class="pm-title"></h2>
                        <div id="pmPrice" class="pm-price"></div>
                        <div style="color: #64748b; font-size: 15px; display: flex; align-items: center; gap: 8px;">
                            <i data-lucide="truck" style="width: 18px;"></i>
                            Verified global logistics available
                        </div>
                        <hr style="border: none; border-top: 1px solid #f1f5f9;">
                        <div class="pm-cta">
                            <a href="shop-now.html" class="pm-btn">Inquire Now</a>
                            <button class="pm-btn wishlist-btn" style="width: 60px; flex: 0; background: #fff; color: #000; border: 2px solid #e2e8f0;">
                                <i data-lucide="heart"></i>
                            </button>
                        </div>
                        <div style="margin-top: auto; padding: 15px; background: #f8fafc; border-radius: 12px; display: flex; gap: 10px; align-items: center;">
                            <i data-lucide="shield-check" style="color: #10b981; width: 20px;"></i>
                            <span style="font-size: 13px; color: #475569; font-weight: 500;">Noshahi Trade Assurance Protected</span>
                        </div>
                    </div>
                </div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHTML);
        lucide.createIcons();

        const modal = document.getElementById('globalPremiumModal');
        const closeBtn = document.getElementById('closePremiumModal');

        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                modal.classList.remove('active');
                document.body.style.overflow = 'auto';
            });
        }

        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.classList.remove('active');
                document.body.style.overflow = 'auto';
            }
        });
    }

    window.openPremiumModal = function (imgSrc, title, price) {
        const modal = document.getElementById('globalPremiumModal');
        if (!modal) return;

        document.getElementById('pmImage').src = imgSrc;
        document.getElementById('pmTitle').innerText = title;
        document.getElementById('pmPrice').innerText = price;

        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        lucide.createIcons();
    };

    function initPremiumCards() {
        const cardSelectors = ['.featured-card', '.clothing-card', '.card-base', '.product-card'];

        document.querySelectorAll(cardSelectors.join(',')).forEach(card => {
            // Only add if not already handling (to avoid double listeners on index.html etc)
            if (card.dataset.premiumInit) return;
            card.dataset.premiumInit = "true";

            card.addEventListener('click', function (e) {
                if (e.target.closest('.wishlist-btn')) return;

                const imgSrc = this.querySelector('img').src;
                const title = (this.querySelector('h3') || this.querySelector('.title')).innerText;
                const priceElement = this.querySelector('.price-val') || this.querySelector('.price');
                const price = priceElement ? priceElement.innerText : "";

                window.openPremiumModal(imgSrc, title, price);
            });
        });
    }

    injectGlobalModal();
    initPremiumCards();

    // Re-init on load more or dynamic changes if needed
    const observer = new MutationObserver(() => {
        initPremiumCards();
    });
    observer.observe(document.body, { childList: true, subtree: true });

});

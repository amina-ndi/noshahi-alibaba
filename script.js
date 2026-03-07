// Initialize Lucide Icons
document.addEventListener('DOMContentLoaded', () => {
    lucide.createIcons();

    // Sticky Header Effect
    const mainHeader = document.querySelector('.main-header');
    const scrollHandler = () => {
        if (window.scrollY > 50) {
            mainHeader.style.boxShadow = 'var(--shadow-lg)';
            mainHeader.style.padding = '15px 0';
        } else {
            mainHeader.style.boxShadow = 'var(--shadow-sm)';
            mainHeader.style.padding = '20px 0';
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
    const subNav = document.querySelector('.sub-nav .container');

    const categoriesHTML = `
        <div class="categories-dropdown" id="global-categories-dropdown">
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

    if (allCategoriesBtn && subNav) {
        // Inject dropdown if not present
        if (!document.getElementById('global-categories-dropdown')) {
            const navFlex = document.querySelector('.nav-flex');
            navFlex.insertAdjacentHTML('beforeend', categoriesHTML);
            lucide.createIcons();
        }

        const dropdown = document.getElementById('global-categories-dropdown');

        allCategoriesBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            dropdown.classList.toggle('active');
        });

        // Close when clicking outside
        document.addEventListener('click', (e) => {
            if (!dropdown.contains(e.target) && !allCategoriesBtn.contains(e.target)) {
                dropdown.classList.remove('active');
            }
        });
    }

    // Utility function for email validation
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
});

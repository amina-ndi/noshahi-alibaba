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

    // All Categories Toggle
    const allCategoriesBtn = document.getElementById('all-categories-btn');
    const categorySidebar = document.getElementById('category-sidebar');
    const heroGrid = document.querySelector('.hero-grid');

    if (allCategoriesBtn && categorySidebar && heroGrid) {
        allCategoriesBtn.addEventListener('click', (e) => {
            e.stopPropagation(); // Prevent closing immediately if toggle is part of broader click logic
            categorySidebar.classList.toggle('active');
            heroGrid.classList.toggle('with-sidebar');
        });

        // Optional: Close when clicking outside
        document.addEventListener('click', (e) => {
            if (!allCategoriesBtn.contains(e.target) && !categorySidebar.contains(e.target)) {
                categorySidebar.classList.remove('active');
                heroGrid.classList.remove('with-sidebar');
            }
        });
    }

    // Utility function for email validation
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }
});

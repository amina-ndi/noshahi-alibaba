// Initialize Lucide Icons after DOM is fully loaded
document.addEventListener('DOMContentLoaded', () => {
    lucide.createIcons();
});

// Sticky Header Box Shadow on Scroll
const header = document.querySelector('.main-header');
window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
        header.style.boxShadow = '0 10px 15px -3px rgba(0, 0, 0, 0.1)';
    } else {
        header.style.boxShadow = 'var(--shadow)';
    }
});

// Search Bar Interaction
const searchInput = document.querySelector('.search-bar input');
const searchBtn = document.querySelector('.search-btn');

searchBtn.addEventListener('click', () => {
    const query = searchInput.value.trim();
    if (query) {
        alert(`Searching for: ${query}\n(This is a demo clone)`);
    } else {
        searchInput.focus();
    }
});

searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        searchBtn.click();
    }
});

// Smooth Scrolling for nav links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Category Hover Animation (Subtle)
const categoryItems = document.querySelectorAll('.category-list li');
categoryItems.forEach(item => {
    item.addEventListener('mouseenter', () => {
        item.style.paddingLeft = '5px';
        item.style.color = 'var(--primary)';
    });
    item.addEventListener('mouseleave', () => {
        item.style.paddingLeft = '0';
        item.style.color = 'inherit';
    });
});

// Product Card Interaction
const productCards = document.querySelectorAll('.product-card');
productCards.forEach(card => {
    card.addEventListener('click', () => {
        const title = card.querySelector('.product-title').innerText;
        console.log(`Product Clicked: ${title}`);
    });
});

// RFQ Form Submission
const rfqBtn = document.querySelector('.rfq-submit');
if (rfqBtn) {
    rfqBtn.addEventListener('click', (e) => {
        e.preventDefault();
        const input = document.querySelector('.rfq-form input').value;
        const textarea = document.querySelector('.rfq-form textarea').value;

        if (input && textarea) {
            alert(`RFQ Submitted successfully!\nRequirement: ${input}`);
        } else {
            alert('Please fill out all fields in the RFQ form.');
        }
    });
}

// Newsletter Submission
const newsletterForm = document.querySelector('.newsletter-form');
if (newsletterForm) {
    newsletterForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const emailInput = newsletterForm.querySelector('input');
        alert(`Successfully subscribed with: ${emailInput.value}`);
        emailInput.value = '';
    });
}

const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

// Replace the end of supplier-info with the button as well
html = html.replace(/<div class="supplier-info">([\s\S]*?)<\/div>/g, (match, p1, offset, string) => {
    // Only add if it belongs to product-card (we check if it's inside product-info, though supplier-info is only in product-grid right now)
    // Wait, let's just add it to all supplier-info in Just for you section.
    if (offset > html.indexOf('Just for you') && offset < html.indexOf('top-picks')) {
        if(!match.includes("just-for-you-btn")) {
             return match + '\n                            <button class="just-for-you-btn">Source Now</button>';
        }
    }
    return match;
});

fs.writeFileSync('index.html', html);
console.log("Updated index.html");

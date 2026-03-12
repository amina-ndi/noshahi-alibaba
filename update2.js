const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

// The injected code was:
// <div class="supplier-info">
//     <span class="badge">Verified...
// </div>
// <button class="just-for-you-btn">Source Now</button>

// Let's replace those two with a product-footer container
html = html.replace(/<div class="supplier-info">([\s\S]*?)<\/div>\s*<button class="just-for-you-btn">Source Now<\/button>/g, 
`<div class="product-footer">
                                <div class="supplier-info">$1</div>
                                <button class="just-for-you-btn">Source Now</button>
                            </div>`);

fs.writeFileSync('index.html', html);
console.log("Updated index.html");

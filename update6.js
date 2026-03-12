const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

html = html.replace('<div class="toppicks-grid" style="grid-template-columns: repeat(3, 1fr);">', '<div class="toppicks-grid pf-grid-tp">');
fs.writeFileSync('index.html', html);
console.log("Updated HTML to use class for pf-grid-tp");

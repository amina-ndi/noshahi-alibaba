
import re

with open('index.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Define 12 diverse 3D render images
images_3d = [
    "https://images.unsplash.com/photo-1614741487278-7a9ec9ac94bb?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1633356122544-f134324a6cee?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1631677351624-94c633a6971a?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1634128221889-82ed6efdfac3?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1620121692029-d088224ddc74?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1614850523296-d8c1af93d400?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1633356122102-3fe601e05bd2?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1634224143538-ce0221cd6738?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=600&auto=format&fit=crop"
]

sections = re.split(r'(<section.*?>)', content)
new_content = []

image_idx = 0

for part in sections:
    if '<section' in part:
        new_content.append(part)
        continue
    
    # Process the body of the section
    # Find all image tags and replace src
    # Also find all title divs and append " (3D Rendered)" if possible
    
    # Replace images
    cards = re.split(r'(<div class="[^"]*card-base">)', part)
    processed_cards = []
    for card_part in cards:
        if 'card-base' in card_part:
            processed_cards.append(card_part)
            continue
        
        # Replace image src
        card_part = re.sub(r'src="[^"]+"', f'src="{images_3d[image_idx % 12]}"', card_part)
        image_idx += 1
        
        # Update titles
        card_part = re.sub(r'(style="[^"]*height:\s*42px;[^"]*">)(.*?)(</div>)', r'\1\2 | 3D High-Tech Render\3', card_part)
        
        processed_cards.append(card_part)
    
    new_content.append("".join(processed_cards))

final_html = "".join(new_content)

# Fix double style on first sections
final_html = final_html.replace("style='display:none;' style='padding: 80px 0;", "style='display:none; padding: 80px 0;")

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(final_html)

print("Upgrade complete!")

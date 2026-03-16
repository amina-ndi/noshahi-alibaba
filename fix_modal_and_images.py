
import re

with open('index.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Fix the modal syntax error
modal_fix = """
                document.getElementById('infoModalInner').innerHTML = `
                    <button onclick="closeModal()" style="position:absolute; top:40px; right:40px; border:none; background:#f1f5f9; width:60px; height:60px; border-radius:50%; font-size:45px; cursor:pointer; color:#111; display:flex; align-items:center; justify-content:center; transition:0.3s; z-index:100;">&times;</button>
                    <div style="display:grid; grid-template-columns:1.3fr 1fr; gap:80px; align-items:center;">
                        <div style="position:relative;">
                            <img src="${img}" style="width:100%; border-radius:25px; box-shadow: 0 30px 60px rgba(0,0,0,0.15);">
                            <div style="position:absolute; top:20px; left:20px; background:#FFCC00; color:#000; padding:8px 20px; border-radius:10px; font-weight:900; box-shadow:0 5px 15px rgba(0,0,0,0.1);">FACTORY VETTED</div>
                        </div>
                        <div>
                            <div style="background:#f8fafc; color:#64748b; padding:8px 18px; border-radius:8px; font-weight:800; font-size:14px; width:fit-content; margin-bottom:25px; border:1px solid #e2e8f0;">SKU: NDI-2026-PREM</div>
                            <h2 style="font-size:42px; font-weight:900; color:#0f172a; margin-bottom:20px; line-height:1.1;">${title}</h2>
                            <p style="font-size:36px; font-weight:900; color:#000; margin-bottom:40px; display:flex; align-items:center; gap:15px; font-family:'Outfit'">${price} <span style="font-size:16px; color:#94a3b8; font-weight:500; text-decoration:line-through;">PKR 145,000</span></p>
                            <div style="margin-bottom:45px;">
                                <div style="display:flex; gap:15px; margin-bottom:12px; align-items:center; color:#475569; font-weight:600;"><i data-lucide="check-circle" style="color:#10b981; width:22px;"></i> ISO 9001:2015 Compliance</div>
                                <div style="display:flex; gap:15px; margin-items:center; color:#475569; font-weight:600;"><i data-lucide="check-circle" style="color:#10b981; width:22px;"></i> Optimized B2B Logistics Support</div>
                            </div>
                            <button style="width:100%; padding:25px; background:#000; color:#fff; border:none; border-radius:20px; font-weight:900; font-size:22px; cursor:pointer; box-shadow: 0 15px 40px rgba(0,0,0,0.3); transition:0.3s;" onmouseover="this.style.background='#FFCC00'; this.style.color='#000';" onmouseout="this.style.background='#000'; this.style.color='#fff';">Request Bulk Quotation</button>
                        </div>
                    </div>
                `;"""

# Find the broken modal assignment and replace it
content = re.sub(r'document\.getElementById\(\'infoModalInner\'\)\.innerHTML = \s+<button.*?;', modal_fix, content, flags=re.DOTALL)

# 2. Add more 3D render images to rotation
images_3d = [
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
    "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1614741487278-7a9ec9ac94bb?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?q=80&w=600&auto=format&fit=crop"
]

# Apply to all cards
def replace_img(match):
    global img_idx
    url = images_3d[img_idx % len(images_3d)]
    img_idx += 1
    return f'src="{url}"'

img_idx = 0
content = re.sub(r'src="https://images\.unsplash\.com/[^"]+"', replace_img, content)

with open('index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("Modal and images fixed!")

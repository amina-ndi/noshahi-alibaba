$images = @(
    "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1472851294608-062f824d29cc?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1556742049-04ff4d84f3e7?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1521737711867-e3b97375f902?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1454165833968-35616ed5d23b?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1557804506-669a67965ba0?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1600&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1531297484001-80022131f5a1?q=80&w=1600&auto=format&fit=crop"
)

for ($i = 0; $i -lt 14; $i++) {
    $pageSuffix = if ($i -eq 0) { "" } else { "-" + ($i + 1) }
    $file = "e:\Noshahi Alibaba\featured$pageSuffix.html"
    $imgUrl = $images[$i]
    
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        $newCss = @"
        .featured-hero {
            background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('$imgUrl');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 80px 0;
            margin-bottom: 40px;
            color: white;
            text-align: center;
        }

        .featured-header h1 {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 10px;
            color: white;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .featured-header p {
            color: #f3f4f6;
            font-size: 20px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.3);
        }
"@
        
        # Replace the complete CSS block for hero
        $pattern = '(?s)\.featured-hero \{.*?\}\s+\.featured-header h1 \{.*?\}\s+\.featured-header p \{.*?\}'
        if ($content -match $pattern) {
            $content = [regex]::Replace($content, $pattern, $newCss)
        }
        
        $content | Set-Content $file
    }
}

$files = Get-ChildItem "e:\NoshahiBaba\*.html" -Exclude "index.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # Remove float3D animation
    $content = $content -replace '(?s)@keyframes float3D \{.*?\}', ""
    $content = $content -replace 'animation: float3D.*?;', ""
    
    # Remove card hover transforms
    $content = $content -replace 'transform: translateY\(-?\d+px\).*?;', ""
    $content = $content -replace 'transform: rotate\(.*?\).*?;', ""
    
    # Remove local quickView or similar modal scripts
    $content = $content -replace '(?s)function quickView\(.*?\{.*?\}', ""
    $content = $content -replace '(?s)function toggleWishlist\(.*?\{.*?\}', ""
    
    # Ensure script.js is included
    if ($content -notmatch 'src="script.js"') {
        $content = $content -replace '</body>', '<script src="script.js"></script></body>'
    }

    [System.IO.File]::WriteAllText($file.FullName, $content)
    Write-Host "Processed: $($file.Name)"
}

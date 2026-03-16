$files = Get-ChildItem "e:\NoshahiBaba\*.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # Standardize image fitting and remove padding in style blocks or inline
    $content = $content -replace 'object-fit:\s*contain', 'object-fit: cover'
    $content = $content -replace 'padding:\s*\d+px(?=\s*[;\}])', 'padding: 0'
    $content = $content -replace 'padding:\s*15px', 'padding: 0'
    $content = $content -replace 'padding:\s*20px', 'padding: 0'
    $content = $content -replace 'padding:\s*30px', 'padding: 0'

    [System.IO.File]::WriteAllText($file.FullName, $content)
    Write-Host "Fixed Image Fit: $($file.Name)"
}

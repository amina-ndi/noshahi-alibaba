$indexFile = "e:\NoshahiBaba\index.html"
$content = [System.IO.File]::ReadAllText($indexFile)

# 1. Update Featured Innovations section to use card-glass
# We find the section with "Featured Innovations" and replace card classes inside it
$featuredStart = $content.IndexOf("Featured Innovations")
$trendingStart = $content.IndexOf("Trending Products")

if ($featuredStart -gt -1 -and $trendingStart -gt -1) {
    $featuredSection = $content.Substring($featuredStart, $trendingStart - $featuredStart)
    $newFeaturedSection = $featuredSection -replace 'card-style-\d+', 'card-glass'
    $content = $content.Replace($featuredSection, $newFeaturedSection)
}

# 2. Update Trending Products section to use card-bold-dark
$trendingStart = $content.IndexOf("Trending Products")
$extraStart = $content.IndexOf('id="extraSections"') # Approx end of trending

if ($trendingStart -gt -1 -and $extraStart -gt -1) {
    $trendingSection = $content.Substring($trendingStart, $extraStart - $trendingStart)
    $newTrendingSection = $trendingSection -replace 'card-style-\d+', 'card-bold-dark'
    $content = $content.Replace($trendingSection, $newTrendingSection)
}

# 3. Add container-fluid to footer and other sections if desired, 
# but CSS update already made footer .container 100% width.
# Force sections to be container-fluid for more width
$content = $content -replace 'section-title-wrapper container', 'section-title-wrapper container-fluid'
$content = $content -replace 'prod-grid container', 'prod-grid container-fluid'

[System.IO.File]::WriteAllText($indexFile, $content)
Write-Host "index.html updated with distinct card styles and wider layouts"

$filePath = "e:\NoshahiBaba\style.css"
$content = [System.IO.File]::ReadAllText($filePath)

# Remove the old source-btn block first to avoid duplication
$content = $content -replace '(?s)\.source-btn \{.*?\}', ""
$content = $content -replace '(?s)\.source-btn:hover \{.*?\}', ""

$extraStyles = @"

/* ---- Professional Component Styles (Global) ---- */
.section-title-wrapper {
  text-align: left;
  margin-bottom: 40px;
  margin-top: 20px;
  padding-left: 15px;
}

.section-title-wrapper .section-title {
  font-size: 34px;
  color: #111;
  font-weight: 800;
  position: relative;
  display: inline-block;
  padding-bottom: 15px;
  margin: 0;
}

.section-title-wrapper .section-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  transform: none;
  width: 80px;
  height: 5px;
  background: var(--primary);
  border-radius: 5px;
}

.card-base .price, .featured-card .price-val, .clothing-card .price-val {
  color: #d9534f;
  font-weight: 800;
  font-size: 20px !important;
  margin: 8px 0;
}

.card-base .title, .featured-card h3, .clothing-card h3 {
  font-size: 16px !important;
  font-weight: 600 !important;
  color: #222 !important;
  line-height: 1.4 !important;
  height: 44px !important;
  overflow: hidden !important;
  margin-bottom: 10px !important;
}

.source-btn, .source-now-btn, .btn-source {
  width: 100%;
  height: 44px;
  background: #000 !important;
  color: #fff !important;
  border: none !important;
  border-radius: 10px !important;
  font-weight: 700 !important;
  font-size: 14px !important;
  cursor: pointer;
  transition: all 0.3s;
  margin-top: 15px;
  display: flex !important;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.source-btn:hover, .source-now-btn:hover, .btn-source:hover {
  background: var(--primary) !important;
  color: #000 !important;
  box-shadow: 0 4px 12px rgba(255, 204, 0, 0.4);
}

.supplier-badge, .supplier-row {
  color: #64748b;
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 6px;
  margin-top: 12px;
  font-weight: 500;
}

.img-box, .img-container {
    width: 100%;
    height: 240px;
    background: #f8fafc !important;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
}

.img-box img, .img-container img {
    width: 100% !important;
    height: 100% !important;
    object-fit: contain !important;
    padding: 15px !important;
}
"@

$content += $extraStyles
[System.IO.File]::WriteAllText($filePath, $content)
Write-Host "style.css updated with professional styles"

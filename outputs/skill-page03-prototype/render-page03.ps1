Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$outDir = Join-Path $root 'output'
$assetPath = Join-Path $root 'assets\ip-confused-tangle.png'
$outPath = Join-Path $outDir 'skill-page-03.png'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$W = 1080
$H = 1440
$ink = [System.Drawing.ColorTranslator]::FromHtml('#152936')
$muted = [System.Drawing.ColorTranslator]::FromHtml('#62747b')
$accent = [System.Drawing.ColorTranslator]::FromHtml('#35a8be')
$accentDark = [System.Drawing.ColorTranslator]::FromHtml('#16869e')
$wash = [System.Drawing.ColorTranslator]::FromHtml('#eef8f9')
$rule = [System.Drawing.ColorTranslator]::FromHtml('#b9e0e5')
$paper = [System.Drawing.Color]::White

function New-Font([string]$family, [float]$size, [System.Drawing.FontStyle]$style = [System.Drawing.FontStyle]::Regular) {
  return [System.Drawing.Font]::new($family, $size, $style, [System.Drawing.GraphicsUnit]::Pixel)
}

function Draw-WrappedText {
  param(
    [System.Drawing.Graphics]$Graphics,
    [string]$Text,
    [System.Drawing.Font]$Font,
    [System.Drawing.Brush]$Brush,
    [float]$X,
    [float]$Y,
    [float]$Width,
    [float]$LineHeight
  )
  $line = ''
  $cursorY = $Y
  foreach ($char in $Text.ToCharArray()) {
    if ($char -eq "`n") {
      $Graphics.DrawString($line, $Font, $Brush, $X, $cursorY)
      $line = ''
      $cursorY += $LineHeight
      continue
    }
    $candidate = $line + $char
    if ($line.Length -gt 0 -and $Graphics.MeasureString($candidate, $Font).Width -gt $Width) {
      $Graphics.DrawString($line, $Font, $Brush, $X, $cursorY)
      $line = [string]$char
      $cursorY += $LineHeight
    } else {
      $line = $candidate
    }
  }
  if ($line.Length -gt 0) {
    $Graphics.DrawString($line, $Font, $Brush, $X, $cursorY)
    $cursorY += $LineHeight
  }
  return $cursorY
}

$bmp = [System.Drawing.Bitmap]::new($W, $H, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$g.Clear($paper)

$brushInk = [System.Drawing.SolidBrush]::new($ink)
$brushMuted = [System.Drawing.SolidBrush]::new($muted)
$brushAccent = [System.Drawing.SolidBrush]::new($accent)
$brushAccentDark = [System.Drawing.SolidBrush]::new($accentDark)
$brushWash = [System.Drawing.SolidBrush]::new($wash)
$penRule = [System.Drawing.Pen]::new($rule, 1)
$penAccent = [System.Drawing.Pen]::new($accent, 5)

$serif = 'Noto Serif SC'
$mono = 'Noto Sans SC'
$meta = New-Font $mono 20
$title = New-Font $serif 82
$body = New-Font $serif 30
$problemTitle = New-Font $serif 31 ([System.Drawing.FontStyle]::Bold)
$number = New-Font $mono 28
$closingFont = New-Font $serif 29
$footerFont = New-Font $mono 18

$g.DrawString('AI / SKILL', $meta, $brushMuted, 88, 84)
$pageNo = '03 / 05'
$pageNoSize = $g.MeasureString($pageNo, $meta)
$g.DrawString($pageNo, $meta, $brushAccent, 1080 - 88 - $pageNoSize.Width, 84)

$titleX = 88
$titleY = 132
$before = '为什么需要 '
$skill = 'Skill'
$after = '？'
$g.DrawString($before, $title, $brushInk, $titleX, $titleY)
$xSkill = $titleX + $g.MeasureString($before, $title).Width
$g.DrawString($skill, $title, $brushAccent, $xSkill, $titleY)
$xAfter = $xSkill + $g.MeasureString($skill, $title).Width
$g.DrawString($after, $title, $brushInk, $xAfter, $titleY)

$sceneY = 270
$sceneH = 280
$g.FillRectangle($brushWash, 88, $sceneY, 904, $sceneH)
$g.DrawLine($penAccent, 90, $sceneY, 90, $sceneY + $sceneH)
$sceneText = '比如每次做竞品分析，你都要重新交代：查哪些资料、怎样核实来源、按什么结构输出。做过一次，下次还是得从头说。'
Draw-WrappedText $g $sceneText $body $brushInk 126 324 520 49 | Out-Null

$ip = [System.Drawing.Image]::FromFile($assetPath)
$ipW = 300
$ipH = 270
$ipX = 690
$ipY = 275
$g.DrawImage($ip, [System.Drawing.RectangleF]::new($ipX, $ipY, $ipW, $ipH))
$ip.Dispose()

$rowY = 584
$rowH = 120
$problemTitles = @('重复交代', '注意力被稀释', '难以维护')
$problemBodies = @(
  '相同的要求，每次任务都要再输入。',
  '要求越堆越长，关键步骤和约束更容易被淹没。',
  '想改一个步骤，还得通读整段要求，检查它是否与旧规则冲突。'
)
for ($i = 0; $i -lt 3; $i++) {
  $y = $rowY + ($i * $rowH)
  $g.DrawLine($penRule, 88, $y, 992, $y)
  $g.DrawString(('0{0}' -f ($i + 1)), $number, $brushAccent, 110, $y + 28)
  $g.DrawString($problemTitles[$i], $problemTitle, $brushAccentDark, 180, $y + 24)
  Draw-WrappedText $g $problemBodies[$i] $body $brushInk 440 ($y + 28) 510 47 | Out-Null
}
$g.DrawLine($penRule, 88, $rowY + (3 * $rowH), 992, $rowY + (3 * $rowH))

$closingY = 984
$closingH = 178
$g.FillRectangle($brushWash, 88, $closingY, 904, $closingH)
$g.DrawLine($penAccent, 90, $closingY, 90, $closingY + $closingH)
$closing = '把相对固定的步骤、参考资料和工具使用方式整理起来，需要时再调用。这就是 Skill 想解决的一类问题。'
Draw-WrappedText $g $closing $closingFont $brushInk 126 ($closingY + 34) 820 48 | Out-Null

$g.DrawLine($penRule, 88, 1370, 992, 1370)
$footer = 'SKILL / 03'
$footerSize = $g.MeasureString($footer, $footerFont)
$g.DrawString($footer, $footerFont, $brushMuted, 1080 - 88 - $footerSize.Width, 1382)

$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)

foreach ($resource in @($brushInk, $brushMuted, $brushAccent, $brushAccentDark, $brushWash, $penRule, $penAccent, $meta, $title, $body, $problemTitle, $number, $closingFont, $footerFont, $g, $bmp)) {
  if ($null -ne $resource -and $resource.PSObject.Methods.Name -contains 'Dispose') { $resource.Dispose() }
}

Write-Output $outPath

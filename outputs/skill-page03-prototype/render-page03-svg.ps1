$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$outDir = Join-Path $root 'output'
$assetPath = Join-Path $root 'assets\ip-confused-tangle.png'
$outPath = Join-Path $outDir 'skill-page-03.svg'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$asset = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($assetPath))

$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1080" height="1440" viewBox="0 0 1080 1440">
  <style>
    .ink { fill:#152936; }
    .muted { fill:#62747b; }
    .accent { fill:#35a8be; }
    .accent-dark { fill:#16869e; }
    .serif { font-family:'Noto Serif SC','Source Han Serif SC','STSong',serif; font-weight:400; }
    .sans { font-family:'Noto Sans SC','Microsoft YaHei',sans-serif; font-weight:400; }
  </style>
  <rect width="1080" height="1440" fill="#ffffff"/>
  <text x="88" y="105" class="sans muted" font-size="20">AI / SKILL</text>
  <text x="992" y="105" text-anchor="end" class="sans accent" font-size="20">03 / 05</text>

  <text x="88" y="207" class="serif ink" font-size="82">为什么需要 <tspan class="accent">Skill</tspan>？</text>

  <rect x="88" y="270" width="904" height="280" fill="#eef8f9"/>
  <rect x="88" y="270" width="5" height="280" fill="#35a8be"/>
  <text x="126" y="365" class="serif ink" font-size="30">
    <tspan x="126" dy="0">比如每次做竞品分析，你都要重新交</tspan>
    <tspan x="126" dy="49">代：查哪些资料、怎样核实来源、按</tspan>
    <tspan x="126" dy="49">什么结构输出。做过一次，下次还是</tspan>
    <tspan x="126" dy="49">得从头说。</tspan>
  </text>
  <image x="690" y="275" width="300" height="270" preserveAspectRatio="xMidYMid meet" href="data:image/png;base64,$asset"/>

  <g class="serif">
    <line x1="88" y1="584" x2="992" y2="584" stroke="#b9e0e5"/>
    <text x="110" y="650" class="sans accent" font-size="28">01</text>
    <text x="180" y="650" class="accent-dark" font-size="31" font-weight="600">重复交代</text>
    <text x="440" y="650" class="ink" font-size="30">相同的要求，每次任务都要再输入。</text>

    <line x1="88" y1="704" x2="992" y2="704" stroke="#b9e0e5"/>
    <text x="110" y="770" class="sans accent" font-size="28">02</text>
    <text x="180" y="770" class="accent-dark" font-size="31" font-weight="600">注意力被稀释</text>
    <text x="440" y="770" class="ink" font-size="30">
      <tspan x="440" dy="0">要求越堆越长，关键步骤和约束更容</tspan>
      <tspan x="440" dy="47">易被淹没。</tspan>
    </text>

    <line x1="88" y1="824" x2="992" y2="824" stroke="#b9e0e5"/>
    <text x="110" y="890" class="sans accent" font-size="28">03</text>
    <text x="180" y="890" class="accent-dark" font-size="31" font-weight="600">难以维护</text>
    <text x="440" y="890" class="ink" font-size="30">
      <tspan x="440" dy="0">想改一个步骤，还得通读整段要求，</tspan>
      <tspan x="440" dy="47">检查它是否与旧规则冲突。</tspan>
    </text>
    <line x1="88" y1="944" x2="992" y2="944" stroke="#b9e0e5"/>
  </g>

  <rect x="88" y="984" width="904" height="178" fill="#eef8f9"/>
  <rect x="88" y="984" width="5" height="178" fill="#35a8be"/>
  <text x="126" y="1050" class="serif ink" font-size="29">
    <tspan x="126" dy="0">把相对固定的步骤、参考资料和工具使用方式整理起来，需要</tspan>
    <tspan x="126" dy="48">时再调用。这就是 Skill 想解决的一类问题。</tspan>
  </text>

  <line x1="88" y1="1370" x2="992" y2="1370" stroke="#b9e0e5"/>
  <text x="992" y="1400" text-anchor="end" class="sans muted" font-size="18">SKILL / 03</text>
</svg>
"@

[System.IO.File]::WriteAllText($outPath, $svg, [System.Text.UTF8Encoding]::new($false))
Write-Output $outPath

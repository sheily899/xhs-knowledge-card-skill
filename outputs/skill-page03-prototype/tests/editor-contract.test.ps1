$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$html = Get-Content -Raw -LiteralPath (Join-Path $root 'index.html')

$checks = @(
  @{ Name = '模块流容器'; Pattern = 'id="moduleFlow"' },
  @{ Name = '新增文字模块按钮'; Pattern = 'id="addText"' },
  @{ Name = '模块类型选择器'; Pattern = 'id="moduleType"' },
  @{ Name = '模块上移按钮'; Pattern = 'id="moveUp"' },
  @{ Name = '模块下移按钮'; Pattern = 'id="moveDown"' },
  @{ Name = '图片替换入口'; Pattern = 'id="imageInput"' },
  @{ Name = '图片位置恢复按钮'; Pattern = 'id="resetImagePosition"' },
  @{ Name = '新增模块函数'; Pattern = 'function addTextModule' },
  @{ Name = '新增指定类型模块函数'; Pattern = 'function addModule' },
  @{ Name = '新增模块焦点函数'; Pattern = 'function focusCustomModule' },
  @{ Name = '删除状态更新函数'; Pattern = 'function updateModuleActions' },
  @{ Name = '模块顺序移动函数'; Pattern = 'function moveSelectedModule' },
  @{ Name = '图片替换事件'; Pattern = "addEventListener('change'" },
  @{ Name = '图片拖拽开始事件'; Pattern = "addEventListener('pointerdown'" },
  @{ Name = '图片拖拽移动事件'; Pattern = "addEventListener('pointermove'" },
  @{ Name = '图片位置恢复函数'; Pattern = 'function resetImagePosition' },
  @{ Name = '导出前移除编辑控件'; Pattern = "querySelectorAll('.editor-only" },
  @{ Name = '导出前只移除选中样式'; Pattern = "classList.remove('is-selected')" }
)

$missing = @($checks | Where-Object { $html -notmatch [regex]::Escape($_.Pattern) })
if ($missing.Count -gt 0) {
  Write-Output 'RED: 当前原型缺少以下可编辑模块能力：'
  $missing | ForEach-Object { Write-Output ("- " + $_.Name) }
  exit 1
}

if ($html -match 'id="applyModuleType"' -or $html -match 'function applyModuleType') {
  Write-Output 'RED: 控制区仍保留了不必要的“套用到选中”功能。'
  exit 1
}

if ($html -notmatch '(?s)\.custom-text\s*\{[^}]*border-left:\s*0[^}]*background:\s*transparent') {
  Write-Output 'RED: 纯文字模块仍带有色块或边线样式。'
  exit 1
}

Write-Output 'GREEN: 模块新增、顺序调整、图片替换和导出清理入口均存在。'

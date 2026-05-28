
# В файл (true) или в консоль (false)
$OutputToFile = $true

# Путь к файлу для сохранения дерева
$OutputPath = "project_tree.txt"

# Расширения, которые будут включены в вывод
$extensions = @("*.cs", "*.hbs", "*.yml", "*.yaml", "*.json", , "*.sln", "*.slnx", "*.conf", "*.js", "*.ts", "*.tsx", "*.jsx", "*.css", "*.html")

# Исключаемые из вывода папки
$excludedFolders = @('bin', 'obj', 'node_modules', '.git', '.github', '.vs', '.vscode', '.idea')

$csFiles = @()
$folders = @()

foreach ($ext in $extensions) {
    $csFiles += Get-ChildItem -Path "." -Recurse -Include $ext
}

foreach ($file in $csFiles) {
    $dir = $file.DirectoryName
    while ($dir -and $dir -ne "." -and $dir -ne $PWD.Path) {
        if ((Split-Path $dir -Leaf) -notin $excludedFolders) {
            $folders += $dir
        }
        $dir = Split-Path $dir -Parent
    }
}

$allPaths = ($folders | Sort-Object -Unique) + ($csFiles | ForEach-Object { $_.FullName })
$allPaths = $allPaths | Sort-Object -Unique

$tree = @{}
foreach ($path in $allPaths) {
    $parts = $path -replace "^[A-Za-z]:\\", "" -split "\\"
    $cursor = $tree
    for ($i = 0; $i -lt $parts.Length; $i++) {
        $part = $parts[$i]
        if (-not $cursor.ContainsKey($part)) {
            $cursor[$part] = @{}
        }
        $cursor = $cursor[$part]
    }
}

$outputLines = @()

function Write-Tree($node, $indent = "", $isLast = $true) {
    $keys = $node.Keys | Where-Object { $_ -ne "" -and $_ -notin $excludedFolders }
    $count = $keys.Count
    $index = 0

    foreach ($key in $keys) {
        $index++
        $isLastItem = ($index -eq $count)
        $branch = if ($isLastItem) {"└── "} else {"├── "}
        $padding = if ($isLastItem) {"    "} else {"│   "}

        Write-Output "$indent$branch$key"

        Write-Tree $node[$key] ($indent + $padding) $isLastItem | ForEach-Object { Write-Output $_ }
    }
}

$outputLines = Write-Tree $tree

if ($OutputToFile) {
    ($outputLines -join "`n") | Set-Content -Path $OutputPath
    Write-Host "Дерево проекта успешно сохранено в файл: $OutputPath"
} else {
    Write-Output $outputLines
}

pause
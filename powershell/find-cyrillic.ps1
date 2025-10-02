$path = Get-Location
$files = Get-ChildItem -Path $path -Recurse -Filter *.cs

# Функция для проверки наличия кириллических символов
function Contains-Cyrillic {
    param (
        [string]$text
    )
    return $text -match '[u0400-u04FF]'
}

# Ищем файлы, содержащие кириллицу
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    if (Contains-Cyrillic $content) {
        Write-Output "$($file.FullName)"
    }
}

Read-Host
Write-Output "--- START ---"

$path = Get-Location
$files = Get-ChildItem -Path $path -Recurse -Filter *.cs

# Функция для проверки наличия кириллических символов
function Contains-Cyrillic {
    param (
        [string]$text
    )
    # Используем правильный синтаксис Unicode \u
    return $text -match '[\u0400-\u04FF]'
}

# Новая функция: ищет первую строку с кириллицей в массиве строк
function Get-FirstCyrillicLine {
    param (
        [string[]]$lines
    )
    
    foreach ($line in $lines) {
        if (Contains-Cyrillic $line) {
            return $line
        }
    }
    return $null
}

# Ищем файлы, содержащие кириллицу, и выводим первую найденную строку
foreach ($file in $files) {
    # Читаем файл как массив строк
    $lines = Get-Content -Path $file.FullName -Encoding UTF8 -ErrorAction SilentlyContinue

    if ($lines) {
        $firstCyrillicLine = Get-FirstCyrillicLine -lines $lines

        if ($firstCyrillicLine) {
            $firstCyrillicLineTrimmed = $firstCyrillicLine.Trim()
            Write-Output "Файл с кириллицей:   $($file.FullName)"
            Write-Output "Доказательство:      $firstCyrillicLineTrimmed"
            Write-Output "" # Пустая строка для разделения вывода
        }
    }
}

Write-Output "---- END ----"

Read-Host
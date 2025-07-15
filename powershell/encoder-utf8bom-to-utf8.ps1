param (
    [string]$Path
)

if (-not $Path) {
    Write-Host "Usage: .encoder-bom.ps1 -Path <YourPath>"
    exit
}

$path = $Path
$files = Get-ChildItem -Path $path -Recurse -File

function Test-UTF8WithBOM {
    param (
        [string]$filePath
    )

    if (-Not (Test-Path $filePath)) {
        throw "Файл не найден: $filePath"
    }

    $fileStream = [System.IO.File]::OpenRead($filePath)
    try {
        $buffer = New-Object byte[] 3
        $bytesRead = $fileStream.Read($buffer, 0, 3)

        if ($bytesRead -eq 3 -and $buffer[0] -eq 0xEF -and $buffer[1] -eq 0xBB -and $buffer[2] -eq 0xBF) {
            return $true
        } else {
            return $false
        }
    } finally {
        $fileStream.Close()
    }
}

foreach ($file in $files) {
    $filePath = $file.FullName

    try {
        if (Test-UTF8WithBOM -filePath $filePath) {
            Write-Host "CHANGED: '$($file.FullName)'"

            $content = Get-Content -Path $filePath -Raw
            $utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)

            $streamWriter = [System.IO.StreamWriter]::new($filePath, $false, $utf8WithoutBom)
            $streamWriter.Write($content)
        }
    } catch {
        Write-Host "Ошибка при обработке файла '$($filePath)': $_"
    } finally {
        if ($streamWriter) {
            $streamWriter.Close()
        }
    }
}
$path = Get-Location
$files = Get-ChildItem -Path $path -Recurse -Filter *.cs

# ������� ��� �������� ������� ������������� ��������
function Contains-Cyrillic {
    param (
        [string]$text
    )
    return $text -match '[u0400-u04FF]'
}

# ���� �����, ���������� ���������
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    if (Contains-Cyrillic $content) {
        Write-Output "$($file.FullName)"
    }
}

Read-Host
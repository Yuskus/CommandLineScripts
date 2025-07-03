#### Поиск в поддиректории файлов с указанным словом:  
```
findstr /spin /c:"слово" *.*  
```
  
#### Удаление строки с указанным словом:  
```
powershell -Command "(gc filename.txt) | Where-Object {$_ -notmatch 'слово'} | Out-File filename.txt"  
```
  
#### Замена вхождений слова:  
```
powershell -Command "(gc filename.txt) -replace 'старое слово', 'новое слово' | Out-File filename.txt"  
```
  
#### Изменение кодировки файла:  
```
powershell -Command "(Get-Content filename.txt -Raw) | Set-Content filename.txt -Encoding UTF8"  
```
  
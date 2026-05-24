#!/usr/bin/dotnet run
#:sdk Microsoft.NET.Sdk
#:property PublishAot=false

System.Console.OutputEncoding = System.Text.Encoding.UTF8;

var b = "⬜";           // default background
var f = "⬛";           // default front
var phrase = "ПРИВЕТ"; // default word

if (args.Length >= 3)
{
    b = args[0];
    f = args[1];
    phrase = string.Join(' ', args[2..]).ToUpper();
}

var dict = new System.Collections.Generic.Dictionary<char, int>
{
    { ' ', 0 },
    { 'А', 1 },
    { 'Б', 2 },
    { 'В', 3 },
    { 'Г', 4 },
    { 'Д', 5 },
    { 'Е', 6 },
    { 'Ё', 7 },
    { 'Ж', 8 },
    { 'З', 9 },
    { 'И', 10 },
    { 'Й', 11 },
    { 'К', 12 },
    { 'Л', 13 },
    { 'М', 14 },
    { 'Н', 15 },
    { 'О', 16 },
    { 'П', 17 },
    { 'Р', 18 },
    { 'С', 19 },
    { 'Т', 20 },
    { 'У', 21 },
    { 'Ф', 22 },
    { 'Х', 23 },
    { 'Ц', 24 },
    { 'Ч', 25 },
    { 'Ш', 26 },
    { 'Щ', 27 },
    { 'Ъ', 28 },
    { 'Ы', 29 },
    { 'Ь', 30 },
    { 'Э', 31 },
    { 'Ю', 32 },
    { 'Я', 33 }
};

var alphabet = new string[]
{
    // space
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n",
    // А
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{f}{f}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // Б
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n",
    // В
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n",
    // Г
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n",
    // Д
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{f}{f}{f}{f}{f}\n" +
    $"{b}{f}{b}{b}{b}{f}\n" +
    $"{b}{f}{b}{b}{b}{f}\n",
    // Е
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n",
    // Ё
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n",
    // Ж
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n",
    // З
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n",
    // И
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{f}{f}{b}\n" +
    $"{b}{f}{f}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // Й
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{f}{f}{b}\n" +
    $"{b}{f}{f}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // К
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n",
    // Л
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{f}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // М
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{b}{b}{f}\n" +
    $"{b}{f}{b}{b}{b}{f}\n",
    // Н
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{f}{f}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // О
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n",
    // П
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // Р
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n",
    // С
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n",
    // Т
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n",
    // У
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{b}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n",
    // Ф
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{b}{f}{f}{f}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n",
    // Х
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // Ц
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{f}{f}{b}\n" +
    $"{b}{b}{b}{b}{f}{b}\n",
    // Ч
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n",
    // Ш
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{f}{f}{f}{f}\n" +
    $"{b}{b}{b}{b}{b}{b}\n",
    // Щ
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{f}{b}{f}{b}{f}{b}\n" +
    $"{f}{b}{f}{b}{f}{b}\n" +
    $"{f}{b}{f}{b}{f}{b}\n" +
    $"{f}{b}{f}{b}{f}{b}\n" +
    $"{f}{b}{f}{b}{f}{f}\n" +
    $"{b}{b}{b}{b}{b}{f}\n",
    // Ъ
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n",
    // Ы
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{b}{f}\n" +
    $"{b}{f}{b}{b}{b}{f}\n" +
    $"{b}{f}{f}{b}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{f}{b}{b}{f}\n" +
    $"{b}{b}{b}{b}{b}{b}\n",
    // Ь
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{b}{b}{b}\n" +
    $"{b}{b}{f}{f}{b}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{f}{f}{b}\n",
    // Э
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{b}{b}{f}{b}{b}\n" +
    $"{b}{f}{f}{b}{b}{b}\n",
    // Ю
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{f}{b}{b}{f}{b}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{f}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{f}{b}{f}\n" +
    $"{b}{f}{b}{b}{f}{b}\n",
    // Я
    $"{b}{b}{b}{b}{b}{b}\n" +
    $"{b}{b}{b}{f}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{b}{f}{f}{b}\n" +
    $"{b}{b}{b}{f}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n" +
    $"{b}{b}{f}{b}{f}{b}\n"
};

for (int i = 0; i < phrase.Length; i++)
{
    var key = char.ToUpper(phrase[i]);
    if (dict.TryGetValue(key, out var index))
    {
        System.Console.Write(alphabet[index]);
    }
    else
    {
        System.Console.Write("--NOT--FOUND--");
    }
}

System.Console.ReadKey(true);
System.Console.ReadKey();
System.Console.ReadKey(true);
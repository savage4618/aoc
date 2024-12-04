$path = '.\2015\day05\input.txt'
$content = Get-Content $path


$threeVowelsPattern = '.*[aeiou].*[aeiou].*[aeiou].*'
$doubleLetterPattern = '(.)\1'
$forbiddenPattern = '^(?!.*(ab|cd|pq|xy)).*'



$naughty = 0
$nice = 0

foreach ($line in $content) {
    if ($line -match $threeVowelsPattern -and $line -match $doubleLetterPattern -and $line -match $forbiddenPattern) {
        $nice++
    } else {
        $naughty++
    }
}

write-output "Nice count: $nice"
write-output "Naughty count: $naughty"
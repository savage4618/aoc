$path = '.\2015\day05\input.txt'
$content = Get-Content $path


$pairPattern = '(?=(..).*?\1)'
$repeatPattern = '(.).\1'


$naughty = 0
$nice = 0

foreach ($line in $content) {
    if ($line -match $pairPattern -and $line -match $repeatPattern) {
        $nice++
    } else {
        $naughty++
    }
}

write-output "Nice count: $nice"
write-output "Naughty count: $naughty"
$file = '.\input.txt'
$content = Get-Content $file
$diff = 0

foreach ($line in $content) {
    $beforeTotal = $line.Length
    $numQuotes = 0
    $numBackslash = 0

    for ($i = 0; $i -lt $line.Length; $i++) {
        if ($line[$i] -eq '"') {
            $numQuotes++
        }
        elseif ($line[$i] -eq [char]'\') {
            $numBackslash++
        }
    }

    $afterTotal = $beforeTotal + 2 + $numBackslash + $numQuotes
    $diff += ($afterTotal - $beforeTotal)
}
$diff
$diff | clip

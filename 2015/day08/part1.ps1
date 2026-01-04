$file = '.\input.txt'
$content = Get-Content $file

$codeTotal = 0
$memTotal = 0

foreach ($line in $content) {
    $codeTotal += $line.Length

    $noQuotes = $line.SubString(1, $line.Length - 2)

    $i = 0
    while ($i -lt $noQuotes.Length) {

        if ($noQuotes[$i] -ne '\') {

            $memTotal += 1
            $i += 1
            continue
        }

        if ($noQuotes[$i + 1] -eq '\' -or $noQuotes[$i + 1] -eq '"') {

            $memTotal += 1
            $i += 2
            continue
        }

        If ($noQuotes[$i + 1] -eq 'x') {
            $memTotal += 1
            $i += 4
            continue
        }

        throw "Unexpected escape at index $i in: $line"

    }
}

"codeTotal = $codeTotal"
"memTotal = $memTotal"
"diff = $($codeTotal - $memTotal)"
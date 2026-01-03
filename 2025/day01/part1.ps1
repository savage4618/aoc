$file = '.\input.txt'
$content = Get-Content $file

$pos = 50
$count0 = 0

foreach ($line in $content) {
    $direction = $line.SubString(0,1)  # left or right
    # L = subtract, R = add
    $n = [int]$line.SubString(1) # number of steps
 
    if ($direction -eq 'R') {$pos += $n}
    else {$pos -= $n}

    while ($pos -ge 100) {$pos -= 100}
    while ($pos -lt 0) {$pos += 100}

    if ($pos -eq 0) {$count0++}

}

"Final pass = $count0"
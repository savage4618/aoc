$file = '.\input.txt'
$lines = Get-Content $file 

$file = '.\input.txt'
$lines = Get-Content $file

$total = [System.Numerics.BigInteger]::Zero
$lineNumber = 0

foreach ($line in $lines) {

    if ([string]::IsNullOrWhiteSpace($line)) {
        $lineNumber++
        continue
    }

    $k = 12
    $remove = $line.Length - $k

    $stack = @()

    for ($i = 0; $i -lt $line.Length; $i++) {
        $d = $line[$i]

        while ($remove -gt 0 -and $stack.Count -gt 0 -and $stack[$stack.Count - 1] -lt $d) {
            # pop last
            if ($stack.Count -eq 1) {
                $stack = @()
            } else {
                $stack = $stack[0..($stack.Count - 2)]
            }
            $remove--
        }

        $stack += $d
    }

    # Remove extra digits from the end if needed
    while ($remove -gt 0) {
        if ($stack.Count -eq 1) {
            $stack = @()
        } else {
            $stack = $stack[0..($stack.Count - 2)]
        }
        $remove--
    }

    $bestString = -join $stack[0..($k - 1)]
    $bestValue = [System.Numerics.BigInteger]::Parse($bestString)

    "Line $lineNumber best = $bestString"

    $total += $bestValue
    $lineNumber++
}

"Total output joltage = $total"
$total | clip

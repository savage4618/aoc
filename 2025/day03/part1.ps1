$file = '.\input.txt'
$lines = Get-Content $file 

$total = 0

foreach ($line in $lines) {
    # make empty array of digits
    $digits = @()
    # parse digits
    for ($i = 0; $i -le $line.Length-1; $i++) {
        $digits += [int]$line.Substring($i, 1)
    }
    # init var
    $best = 0
    # define max tens digit index
    $maxRight = $digits[$digits.Count - 1]
    # process pairs starting from the right of the line (more efficient, I learned `O(n^2)` vs `O(n)` here)
    for ($i = $digits.Count -2; $i -ge 0; $i--) {
        # this is the number
        $candidate = (10 * $digits[$i]) + $maxRight
        
        # this checks if the current number is higher than the best found so far
        if ($candidate -gt $best) {
            $best = $candidate
        }

        # update $maxRight for the next step left
        if ($digits[$i] -gt $maxRight) {
            $maxRight = $digits[$i]
        }
    }
    # say stuff for watching the process
    "Line {$line} best = $best"
    $total += $best
}
$total
$total | clip
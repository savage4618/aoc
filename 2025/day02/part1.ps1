Add-Type -AssemblyName System.Numerics

function Make-InvalidId {
    param([long]$x)
    return [long]("$x$x")
}

function Parse-Ranges {
    param([string]$line)

    $ranges = @()

    foreach ($part in ($line -split ",")) {
        $t = $part.Trim()
        if ($t.Length -eq 0) { continue }

        $ab = $t -split "-", 2
        if ($ab.Count -ne 2) { continue }

        [long]$a = $ab[0]
        [long]$b = $ab[1]

        $ranges += [pscustomobject]@{ Start = $a; End = $b }
    }

    return $ranges
}

# Read input
$file = '.\input.txt'
$line = (Get-Content -Raw $file).Trim()

$ranges = Parse-Ranges $line

# Sort + merge overlapping/adjacent ranges to avoid double counting
$ranges = $ranges | Sort-Object Start, End
$merged = @()

foreach ($r in $ranges) {
    if ($merged.Count -eq 0) {
        $merged += $r
        continue
    }

    $last = $merged[-1]
    if ($r.Start -le ($last.End + 1)) {
        if ($r.End -gt $last.End) { $last.End = $r.End }
    } else {
        $merged += $r
    }
}

# Determine max half-digits to generate
$maxEnd = ($merged | Measure-Object End -Maximum).Maximum
$maxDigits = $maxEnd.ToString().Length
$maxHalfDigits = [int][math]::Floor($maxDigits / 2)

[System.Numerics.BigInteger]$total = 0

foreach ($range in $merged) {
    [long]$A = $range.Start
    [long]$B = $range.End

    for ($digits = 1; $digits -le $maxHalfDigits; $digits++) {
        [long]$startX = if ($digits -eq 1) { 1 } else { [long][math]::Pow(10, $digits - 1) }
        [long]$endX   = [long]([math]::Pow(10, $digits) - 1)

        for ($x = $startX; $x -le $endX; $x++) {
            [long]$id = Make-InvalidId $x

            if ($id -gt $B) { break }
            if ($id -lt $A) { continue }

            $total += $id
        }
    }
}

Write-Host ("Final sum = {0}" -f $total)

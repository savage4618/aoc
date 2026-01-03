# Day 2: Gift Shop - Part 2 (PowerShell)
# Invalid if it is some digit sequence repeated at least twice (e.g., 55, 999, 121212, 123123123)

Add-Type -AssemblyName System.Numerics

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

function In-AnyRange {
    param(
        [long]$n,
        $mergedRanges
    )
    # mergedRanges sorted and non-overlapping
    foreach ($r in $mergedRanges) {
        if ($n -lt $r.Start) { return $false }
        if ($n -le $r.End) { return $true }
    }
    return $false
}

# Read + normalize input (works whether file is one line or wrapped)
$file = '.\input.txt'
$line = ((Get-Content $file) -join "").Trim()

$ranges = Parse-Ranges $line

# Sort + merge overlapping/adjacent ranges
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

$maxEnd = ($merged | Measure-Object End -Maximum).Maximum
$maxDigits = $maxEnd.ToString().Length

# Track seen IDs so we don't double-count numbers like 1111 (1 repeated 4 OR 11 repeated 2)
$seen = New-Object "System.Collections.Generic.HashSet[long]"

[System.Numerics.BigInteger]$total = 0

# Generate candidates:
# block length k = 1..maxDigits
# repeat count t >= 2 such that k*t <= maxDigits
for ($k = 1; $k -le $maxDigits; $k++) {

    # x must be exactly k digits (no leading zeros)
    [long]$startX = if ($k -eq 1) { 1 } else { [long][math]::Pow(10, $k - 1) }
    [long]$endX   = [long]([math]::Pow(10, $k) - 1)

    for ($t = 2; ($k * $t) -le $maxDigits; $t++) {

        for ($x = $startX; $x -le $endX; $x++) {

            # build repeated string explicitly (clear + readable)
            $sx = $x.ToString()
            $s = ""
            for ($i = 0; $i -lt $t; $i++) { $s += $sx }

            # If it's longer than maxDigits we can stop for this t (shouldn't happen due to loop condition)
            if ($s.Length -gt $maxDigits) { break }

            # Convert to number (fits in Int64 as long as maxEnd does; AoC inputs usually do)
            [long]$id = [long]$s

            # Early break: for fixed k,t, ids grow as x grows
            if ($id -gt $maxEnd) { break }

            if (-not (In-AnyRange $id $merged)) { continue }

            # Add once
            if ($seen.Add($id)) {
                $total += $id
            }
        }
    }
}

Write-Host ("Final sum (part 2) = {0}" -f $total)
$total | clip

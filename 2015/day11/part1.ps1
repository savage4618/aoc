$chars = 'hepxcrrq'   # original input

function IncrementPassword($pw) {
    for ($i = $pw.Length - 1; $i -ge 0; $i--) {
        if ($pw[$i] -eq 'z') {
            $pw = $pw.Substring(0, $i) + 'a' + $pw.Substring($i + 1)
        }
        else {
            $nextChar = [char]([int][char]$pw[$i] + 1)
            $pw = $pw.Substring(0, $i) + $nextChar + $pw.Substring($i + 1)
            break
        }
    }
    return $pw
}

function IsValidPassword($password) {

    # Rule 1: no i, o, or l
    if ($password -match '[iol]') {
        return $false
    }

    # Rule 2: increasing straight of 3
    $hasStraight = $false
    for ($i = 0; $i -lt $password.Length - 2; $i++) {
        if (
            [int][char]$password[$i + 1] -eq [int][char]$password[$i] + 1 -and
            [int][char]$password[$i + 2] -eq [int][char]$password[$i] + 2
        ) {
            $hasStraight = $true
            break
        }
    }
    if (-not $hasStraight) {
        return $false
    }

    # Rule 3: two different, non-overlapping pairs
    $pairs = @{}
    for ($i = 0; $i -lt $password.Length - 1; $i++) {
        if ($password[$i] -eq $password[$i + 1]) {
            $pairs[$password[$i]] = $true
            $i++
        }
    }
    if ($pairs.Count -lt 2) {
        return $false
    }

    return $true
}

# ---- Part 1 ----
do {
    $chars = IncrementPassword $chars
} until (IsValidPassword $chars)

$part1 = $chars
"Part 1: $part1"

# ---- Part 2 ----
$chars = IncrementPassword $chars
do {
    $chars = IncrementPassword $chars
} until (IsValidPassword $chars)

"Part 2: $chars"
$chars | clip

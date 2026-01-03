$path = '.\2015\day07\input.txt'
$lines = Get-Content $path

$wires = @{}

foreach ($line in $lines) {
    $parts = $line -split ' -> '
    $target = $parts[1]
    $expression = $parts[0] -split ' '

    if ($expression.Length -eq 1) {
        $wires[$target] = @{ Operator = 'ASSIGN'; Input = $expression[0] }
    } elseif ($expression.Length -eq 2) {
        $wires[$target] = @{ Operator = $expression[0]; Input = $expression[1] }
    } elseif ($expression.Length -eq 3) {
        $wires[$target] = @{
            Operator = $expression[1]
            Input1   = $expression[0]
            Input2   = $expression[2]
        }
    }
}

function Get-WireValue($wire) {
    # If it's a number literal like "123", return it.
    if ($wire -match '^\d+$') { return ([int]$wire) -band 0xFFFF }

    if (-not $wires.ContainsKey($wire)) {
        throw "Wire '$wire' is not defined."
    }

    $op = $wires[$wire]

    # Memoization (cache)
    if ($op.ContainsKey('Value')) { return $op.Value }

    $value = switch ($op.Operator) {
        'ASSIGN' { Get-WireValue $op.Input }

        'NOT'    { (-bnot (Get-WireValue $op.Input)) }

        'AND'    { (Get-WireValue $op.Input1) -band (Get-WireValue $op.Input2) }

        'OR'     { (Get-WireValue $op.Input1) -bor  (Get-WireValue $op.Input2) }

        'LSHIFT' {
            $left  = Get-WireValue $op.Input1
            $shift = Get-WireValue $op.Input2   # usually a number literal
            ($left -shl $shift)
        }

        'RSHIFT' {
            $left  = Get-WireValue $op.Input1
            $shift = Get-WireValue $op.Input2
            ($left -shr $shift)
        }

        default { throw "Unknown operation: $($op.Operator)" }
    }

    # IMPORTANT: force 16-bit after EVERY operation
    $op.Value = $value -band 0xFFFF
    return $op.Value
}

# ---------- Part 1 ----------
$a1 = Get-WireValue 'a'
"a (part 1) = $a1"

# ---------- Part 2 ----------
# Override b to the old a signal
$wires['b'] = @{ Operator = 'ASSIGN'; Input = "$a1" }

# Clear all cached values so the circuit recomputes from scratch
foreach ($k in @($wires.Keys)) {
    $wires[$k].Remove('Value') | Out-Null
}

$a2 = Get-WireValue 'a'
"a (part 2) = $a2"

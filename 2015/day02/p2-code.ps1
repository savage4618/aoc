$file = '.\2015\day02\input.txt'
$runningtotal = 0
$smallest = 0

$lines = Get-Content $file

foreach ($line in $lines) {
    $dimensions = $line -split 'x'
    $L = [int]$dimensions[0]
    $W = [int]$dimensions[1]
    $H = [int]$dimensions[2]

    $1 = (2 * $L) + (2 * $W)
    $2 = (2 * $L) + (2 * $H)
    $3 = (2 * $W) + (2 * $H)
    $volume = $L * $W * $H

    $faces = @($1, $2, $3)
    $smallest = $faces | Sort-Object | Select-Object -First 1

    $runningtotal += ($volume + $smallest)

}

Write-Output "fuck off, they gonna need too much ribbon, in the amount of $runningtotal ft"
$runningtotal | clip

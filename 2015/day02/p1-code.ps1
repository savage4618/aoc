$file = '.\2015\day02\input.txt'
$area = 0
$runningtotal = 0
$smallest = 0

$lines = Get-Content $file

foreach ($line in $lines) {
    $dimensions = $line -split 'x'
    $L = [int]$dimensions[0]
    $W = [int]$dimensions[1]
    $H = [int]$dimensions[2]

    $top = $L * $W
    $side = $W * $H
    $end = $H * $L

    $sides = @($top, $side, $end)
    $smallest = $sides | Sort-Object | Select-Object -First 1


    $area = (2 * $L * $W) + (2 * $W * $H) + (2 * $H * $L) + $smallest
    $runningtotal += $area

}

Write-Output "fuck off, they gonna need too much goddamn paper, in the amount of $runningtotal sqft"
$runningtotal | clip

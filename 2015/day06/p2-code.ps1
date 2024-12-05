$path = '.\2015\day06\input.txt'
$directions = Get-Content $path


$grid = @()
for ($i = 0; $i -lt 1000; $i++) {
    $grid += , (@(0) * 1000)
}

$lightslitthefuckup = 0

foreach ($row in $directions) {
    if ($row -match "^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)$") {
        $action = $Matches[1]
        $x1 = [int]$Matches[2]
        $y1 = [int]$Matches[3]
        $x2 = [int]$Matches[4]
        $y2 = [int]$Matches[5]
    }


    for ($x = $x1; $x -le $x2; $x++) {
        for ($y = $y1; $y -le $y2; $y++) {
            if ($action -eq "turn on") { 
                $grid[$x][$y] += 1 #increase the brightness of the coordinate light
            }
            elseif ($action -eq "turn off") {
                $grid[$x][$y] =[Math]::Max(0, $grid[$x][$y] -1) #decrease the brightness of the coordinate light
                # [math]::Max(n,m) returns the greater of 2 numbers
                # so by setting 0 as the lower limit, I'm making sure it never drops below 0, which was a requirement in the puzzle
            }
            elseif ($action -eq "toggle") {
                $grid[$x][$y] += 2 #increase the brightness of the coordinate light by 2
            }
        }
    }
}
foreach ($line in $grid) {
    $lightslitthefuckup += ($line | Measure-Object -Sum).Sum
}

write-output "Total brightness: $lightslitthefuckup"
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
                $grid[$x][$y] = 1 #turn on the coordinate light
            }
            elseif ($action -eq "turn off") {
                $grid[$x][$y] = 0 # turn off the coordinate light
            }
            elseif ($action -eq "toggle") {
                $grid[$x][$y] = 1 - $grid[$x][$y] #toggle the coordinate light
            }
        }
    }
}
foreach ($line in $grid) {
    $lightslitthefuckup += ($line | Measure-Object -Sum).Sum
}

write-output "There are $lightslitthefuckup lights lit up"
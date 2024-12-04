$file = 'D:\Github Clones\aoc\2015\day01\input.txt'
$floor = 0
$position = 0

$string = Get-Content $file -Raw
$array = $string.ToCharArray()


foreach ($x in $array) {
    if ($x -eq '(') {
        $floor ++
    }
    elseif ($x -eq ')') {
        $floor --
    }
    $position ++
    if ($floor -lt 0) {
        break
    }
}


Write-Output "Motherfucker, you done sent Santa to the basement in $position moves"
$position | clip

$file = 'D:\Github Clones\aoc\2015\day01\input.txt'
$floor = 0

$string = Get-Content $file -Raw
$array = $string.ToCharArray()


foreach ($x in $array) {
    if ($x -eq '(') {
        $floor ++
    }
    elseif ($x -eq ')') {
        $floor --
    }
}

Write-Output "Hey dipshit, $floor is the floor you're on now."
$floor | clip

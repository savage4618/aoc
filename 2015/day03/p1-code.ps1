$file = '.\2015\day03\input.txt'
$content = Get-Content $file

$x = 0
$y = 0

$visited = @{}
$visited["$x,$y"] = 1

foreach ($direction in $content.ToCharArray()) {
    switch ($direction) {
        '^' { $y++ }
        'v' { $y-- }
        '>' { $x++ }
        '<' { $x-- }
    }
    if ($visited.ContainsKey("$x,$y")) {
        $visited["$x,$y"]++
    }
    else {
        $visited["$x,$y"] = 1
    }
}

Write-Output "Houses Visited: $($visited.Keys.Count)"
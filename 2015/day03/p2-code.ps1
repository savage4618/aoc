$file = '.\2015\day03\input.txt'
$content = Get-Content $file
$directions = $content.ToCharArray()

$xSanta = 0
$ySanta = 0

$xRobo = 0
$yRobo = 0


$visited = @{}
$visited["0,0"] = $true


for ($i = 0; $i -lt $directions.Length; $i++) {
    $direction = $directions[$i]
    
    if ($i % 2 -eq 0) {
        #santa
        switch ($direction) {
            '^' { $ySanta++ }
            'v' { $ySanta-- }
            '>' { $xSanta++ }
            '<' { $xSanta-- }
        }
        $currentPosition = "$xSanta,$ySanta"
    } else {
        #robo
        switch ($direction) {
            '^' { $yRobo++ }
            'v' { $yRobo-- }
            '>' { $xRobo++ }
            '<' { $xRobo-- }
        }
        $currentPosition = "$xRobo,$yRobo"
    }

    $visited[$currentPosition] = $true
    
}

Write-Output "Houses Visited: $($visited.Keys.Count)"
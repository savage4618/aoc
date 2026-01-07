$file = '.\input.txt'
$content = Get-Content $file

$cities = @()
$distance = @{}
$total = 0

function Get-Permutations {
    param([string[]]$items)

    # base case
    if ($items.Count -eq 1) {
        return , @($items)   # comma forces "array of 1 route"
    }

    $result = @()

    for ($i = 0; $i -lt $items.Count; $i++) {
        $first = $items[$i]

        $rest = @()
        for ($j = 0; $j -lt $items.Count; $j++) {
            if ($j -ne $i) { $rest += $items[$j] }
        }

        $perms = Get-Permutations -items $rest
        foreach ($perm in $perms) {
            $result += , (@($first) + @($perm))
        }
    }


    return $result
}

foreach ($line in $content) {

    $parts = $line -split ' to '
    $city1 = $parts[0]
    $theRest = $parts[1]

    $parts2 = $theRest -split ' = '
    $city2 = $parts2[0]
    $d = [int]$parts2[1]

    $key1 = "$city1|$city2"
    $key2 = "$city2|$city1"
    $distance[$key1] = $d
    $distance[$key2] = $d
    
    if ($cities -notcontains $city1) {
        $cities += $city1
    }
    if ($cities -notcontains $city2) {
        $cities += $city2
    }

}

$perms = Get-Permutations -items $cities
$shortest = [int]::MaxValue
$longest = 0

foreach ($route in $perms) {
    $total = 0
    for ($i = 0; $i -lt $route.Count - 1; $i++) {
        $a = $route[$i]
        $b = $route[$i+1]
        $total += $distance["$a|$b"]
    }
    if ($total -lt $shortest) { $shortest = $total }
    if ($total -gt $longest) { $longest = $total }
}

"City count = $($cities.Count)"
"Permutation count = $($perms.Count)"
"Shortest = $shortest"
"Longest = $longest"

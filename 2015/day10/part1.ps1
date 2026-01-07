#$file = '.\input.txt'
#$content = Get-Content $file
$start = Get-Date

$current = "3113322113"
$loops = 50

for ($j = 0; $j -lt $loops; $j++) {
    $count = 1
    $sb = [System.Text.StringBuilder]::new()

    for ($i = 0; $i -lt $current.Length; $i++) {
        $char = $current[$i]
        $nextChar = if ($i + 1 -lt $current.Length) {
            $current[$i + 1]
        }
        else {
            "END"
        }
        if ($char -eq $nextChar) {
            $count++
        }
        else {
            [void]$sb.Append($count)
            [void]$sb.Append($char)
            $count = 1
        }
    }
    $current = $sb.ToString()
    "Afterloop $j length = $($current.Length)"

}

$answer = $current.Length

$elapsed = (Get-Date) - $start

$answer | clip
"Elapsed: {0:n3} seconds" -f $elapsed.TotalSeconds

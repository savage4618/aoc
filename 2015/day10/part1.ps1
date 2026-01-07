$file = '.\input.txt'
$content = Get-Content $file

$current = $content[0]
$loops = 40

for ($j = 0; $j -lt $loops; $j++) {
    $count = 1
    $out = ""
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
            $out += $count
            $out += $char

            $count = 1
        }
    $current = $out
    }
}
$current.Length
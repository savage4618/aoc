$file = '.\2015\day04\input.txt'
$content = Get-Content $file
$startswith = "000000"

$number = 1

function Get-MD5Hash([string]$content) {
    $md5 = [System.Security.Cryptography.MD5]::Create()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    $hash = $md5.ComputeHash($bytes)
    $hashHEX = -join ($hash | ForEach-Object { $_.ToString("x2") })
    return $hashHEX
}

while ($true) {
    $hashInput = "$content$number"
    $hash = Get-MD5Hash $hashInput

    if ($hash.StartsWith($startswith)) {
        Write-Output "Lowest Number: $number"
        Write-Output "MD5: $hash"
        break
    }

    $number++
}
// this took FOREVER to find the 6 leading zeros
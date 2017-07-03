$folder = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$files = Get-Childitem $folder
$pictures = $files | Where-Object {$_.length -ge 300000}

if ((Test-Path "$env:USERPROFILE\Pictures\Win10 Lockscreen") -eq $false) {
    New-Item -Path "$env:USERPROFILE\Pictures\Win10 Lockscreen" -ItemType Directory
}

$i = 1
foreach ($picture in $pictures) {
    $png = New-Object System.Drawing.Bitmap $folder\$picture
    if ($png.Width -gt $png.Height){    
        Write-Progress -Activity "Copying Windows 10 lockscreen pictures" -Status "Copy picture number: $i" -PercentComplete ($i / $pictures.Count*100)
        if ((Test-Path "$env:USERPROFILE\Pictures\Win10 Lockscreen\$picture.jpg") -eq $false) {
            Copy-Item "$folder\$picture" "$env:USERPROFILE\Pictures\Win10 Lockscreen"
            mv "$env:USERPROFILE\Pictures\Win10 Lockscreen\$picture" "$env:USERPROFILE\Pictures\Win10 Lockscreen\$picture.jpg"
        }
    }
    $i++
}
# Get sai2 directory from argument 1.
$sai_dir=$args[0]

# Shoosh the web request progress bars.
$ProgressPreference = 'SilentlyContinue'

# Tell the user what's up.
Write-Host "Is sai2 up to date? " -NoNewLine

# Go to sai directory so we don't hit permission blips.
Set-Location -Path "$sai_dir"

# Create Updates folder for zips.
New-Item updates -ItemType Directory -ErrorAction Ignore

# Fetch hash of current history_v2.txt and compare to locally installed history.txt
Invoke-WebRequest -Uri https://www.systemax.jp/en/sai/history_v2.txt -OutFile "$sai_dir\updates\history_v2.txt"

# Compare the hashes to see if we're up to date.
$history_local = Get-FileHash -Path "$sai_dir\history.txt"
$history_v2 = Get-FileHash -Path "$sai_dir\updates\history_v2.txt"
$updated = $history_v2.Hash -eq $history_local.Hash

# Debugging results.
#Write-Host "Local sha256:" $history_local.Hash
#Write-Host "Remote sha256:" $history_v2.Hash
#Write-Host "Hash Matched?:" $updated

switch ($updated)
{
    True {
        Write-Host "Yes, starting sai2."
        Write-Host ""
        Start-Process -FilePath "$sai_dir\sai2.exe"
    }
    False {
        Write-Host "No, starting update process."
        Write-Host ""
        
        # Get new version number from history_v2.txt.
        $new_version = (Get-Content -Path "$sai_dir\updates\history_v2.txt" -TotalCount 2)[-1] -replace '-','' -replace "[^0-9]"
        $new_version_zip = 'sai2-' + "$new_version" + '-64bit-en.zip'
        $new_version_url = 'https://www.systemax.jp/bin/' + "$new_version_zip"

        # Download updated sai2 zip.
        Invoke-WebRequest -Uri "$new_version_url" -OutFile "$sai_dir\updates\$new_version_zip"

        # Expand zip into place.
        Expand-Archive -Path "$sai_dir\updates\$new_version_zip" -DestinationPath "$sai_dir" -Force

        Write-Host "Starting updated sai2."
        Write-Host ""
        Start-Process -FilePath "$sai_dir\sai2.exe"
    }
}

# Get sai2 directory from argument 1, otherwise use root drive\sai2
if ( $args[0] -eq $null )
{
    $sai_dir="C:\sai2"
}
else
{
    $sai_dir=$args[0]
}

# Shoosh the web request progress bars.
$ProgressPreference = 'SilentlyContinue'

if ( -not ( Test-Path -Path $sai_dir ) )
{
    # Create install directory if it doesn't exist.
    Write-Host "Creating $sai_dir"
    New-Item -Path "$sai_dir" -Name "sai2" -ItemType Directory
}

# Tell the user what's up.
Write-Host "Is sai2 up to date? " -NoNewLine

# Go to sai directory so we don't hit permission blips.
Set-Location -Path "$sai_dir"

# Create Updates folder for zips.
New-Item updates -ItemType Directory -ErrorAction Ignore

# Fetch hash of current history_v2.txt and compare to locally installed history.txt
Invoke-WebRequest -Uri https://www.systemax.jp/en/sai/history_v2.txt -OutFile "$sai_dir\updates\history_v2.txt"

if ( Test-Path "$sai_dir\history.txt" -PathType Leaf )
{
    # Compare the hashes to see if we're up to date.
    $version_local = (Get-Content -Path "$sai_dir\history.txt" -TotalCount 2)[-1] -replace '-','' -replace "[^0-9]"
    $version_remote = (Get-Content -Path "$sai_dir\updates\history_v2.txt" -TotalCount 2)[-1] -replace '-','' -replace "[^0-9]"
    Write-Host "Local version:" $version_local.Value
    Write-Host "Remote version:" $version_remote.Value
}

# Update/download logic.
if ( $version_remote.Value -eq $version_local.Value )
{
    Write-Host "Yes, starting sai2."
    Write-Host ""
    Start-Process -FilePath "$sai_dir\sai2.exe"
}
else
{
    Write-Host "No, starting update process."
    Write-Host ""
    
    # Construct new version URL.
    $new_version_zip = 'sai2-' + "$version_remote" + '-64bit-en.zip'
    $new_version_url = 'https://www.systemax.jp/bin/' + "$new_version_zip"

    # Download updated sai2 zip.
    Invoke-WebRequest -Uri "$new_version_url" -OutFile "$sai_dir\updates\$new_version_zip"

    # Expand zip into place.
    Expand-Archive -Path "$sai_dir\updates\$new_version_zip" -DestinationPath "$sai_dir" -Force

    Write-Host "Starting updated sai2."
    Write-Host ""
    Start-Process -FilePath "$sai_dir\sai2.exe"
}

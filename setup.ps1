param (
    [string]$url
)

# Check if HOME_PATH environment variable is set
if ($env:HOME_PATH) {
    $desktopPath = Join-Path $env:HOME_PATH "Desktop"
} else {
    $desktopPath = "~\Desktop"
}

# Create Desktop directory if not present
New-Item -ItemType Directory -Force -Path $desktopPath
# Go to Desktop and create Project directory
cd $desktopPath
New-Item -ItemType Directory -Force -Path Project
cd Project

# Clone the repository specified by the URL
git clone $url

$projfolder = ($url -split '/' | select -last 1 )
$projfolder = ($projfolder -split '\.' | select -first 1 )

New-Item -ItemType Directory -Force -Path $projfolder
cd $projfolder

Remove-Item -LiteralPath ".git" -Force -Recurse -ErrorAction Ignore
Remove-Item -LiteralPath "validation.ps1" -Force -Recurse -ErrorAction Ignore
Remove-Item -LiteralPath "score.ps1" -Force -Recurse -ErrorAction Ignore

if (Test-Path "install.ps1") { 
    & .\install.ps1
}

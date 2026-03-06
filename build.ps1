$configFile = "build_files.txt"
$target = "processed_script.lua"
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent

$filesToProcess = @()

$entries = Get-Content -Path $configFile | Where-Object { $_ -and -not $_.StartsWith("#") }

foreach ($entry in $entries) {
    $entry = $entry.Trim()
    
    # Skip empty lines
    if ([string]::IsNullOrWhiteSpace($entry)) {
        continue
    }
    
    $fullPath = Join-Path -Path $scriptDir -ChildPath $entry
    
    if (Test-Path -Path $fullPath -PathType Container) {
        # If it's a directory, find all files in it
        $files = Get-ChildItem -Path $fullPath -File -Recurse
        $filesToProcess += $files.FullName
    } elseif (Test-Path -Path $fullPath -PathType Leaf) {
        # If it's a file, add it directly
        $filesToProcess += $fullPath
    }
}

Write-Output "Concatenating:"
foreach ($item in $filesToProcess) {
    Write-Output $item
}

# Clear the target file and process each file
Set-Content -Path $target -Value ""

foreach ($file in $filesToProcess) {
    Add-Content -Path $target -Value "-- $file"
    Add-Content -Path $target -Value (Get-Content -Path $file -Raw)
    Add-Content -Path $target -Value ""
}

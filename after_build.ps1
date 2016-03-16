"start collecting nupkg"
$folder = $env:APPVEYOR_BUILD_FOLDER + "\" + ($env:solution_path -split "\.")[0]
(Get-ChildItem $folder -Recurse).Where{ $_.Extension -eq ".nupkg"} | %{ Push-AppveyorArtifact $_.FullName -FileName $_.Name }
"done collectiong nupkg"
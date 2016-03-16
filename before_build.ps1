"start version setting"
$vs = $env:APPVEYOR_BUILD_VERSION -split "\."
$env:nupkg_version = $vs[0] + "." + $vs[1] + "." + $vs[2]
$env:is_prerelease = "false"
if($env:stage -ne "release"){ # prerelease
    $env:nupkg_version = $env:nupkg_version + "-" + $env:stage
    $env:is_prerelease = "true"
}
"done version setting"

"start rewriting nuspec"
$nuspec = (ls $env:APPVEYOR_BUILD_FOLDER -Recurse).Where{ $_.Extension -eq ".nuspec"} | Select -First 1
[xml]$xml = Get-Content $nuspec.FullName
$xml.package.metadata.version = $env:nupkg_version
$xml.package.metadata.releaseNotes = $env:release_notes
$xml.Save($nuspec.FullName)
"done rewriting nuspec"

"start nuget restore"
nuget restore $env:solution_path
"done nuget restore"
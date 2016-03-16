"start making coverage data"
$opencover = (Resolve-Path "src/packages/OpenCover.*/tools/OpenCover.Console.exe").ToString()
$runner = (Resolve-Path "src\packages\xunit.runner.console.*\tools\xunit.console.x86.exe").ToString()
$targetargs = """Analyzer1.Test.dll"" -noshadow -appveyor"
$filter = "+[Analyzer1*]* -[Analyzer1.Test*]*"

& $opencover -register:user -target:$runner "-targetargs:$targetargs" -targetdir:$env:test_dll_dir "-filter:$filter" -returntargetcode -hideskipped:All -output:opencoverCoverage.xml
"done making coverage data"

"start uploading coverage data"
$env:Path = "C:\Python34;C:\Python34\Scripts;$env:Path"
python -m pip install --upgrade pip
pip install codecov
&{codecov -f "opencoverCoverage.xml"}
"done uploading coverage data"
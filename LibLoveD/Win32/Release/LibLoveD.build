set PATH=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\\bin;C:\Program Files (x86)\Microsoft Visual Studio 12.0\\Common7\IDE;C:\Program Files (x86)\Windows Kits\8.1\\bin;C:\D\dmd2\windows\bin;%PATH%
dmd -O -inline -release -X -Xf"Win32\Release\LibLoveD.json" -deps="Win32\Release\LibLoveD.dep" -c -of"Win32\Release\LibLoveD.obj" CVector.d defines.d dllmain.d structs.d types.d UniLib.d
if errorlevel 1 goto reportError

set LIB="C:\D\dmd2\windows\bin\..\lib"
echo. > C:\Users\root\DOCUME~1\VISUAL~1\Projects\LibLoveD\LibLoveD\Win32\Release\LIBLOV~1.LNK
echo "Win32\Release\LibLoveD.obj","Win32\Release\LibLoveD.dll","Win32\Release\LibLoveD.map",user32.lib+ >> C:\Users\root\DOCUME~1\VISUAL~1\Projects\LibLoveD\LibLoveD\Win32\Release\LIBLOV~1.LNK
echo kernel32.lib/NOMAP/NOI/DELEXE >> C:\Users\root\DOCUME~1\VISUAL~1\Projects\LibLoveD\LibLoveD\Win32\Release\LIBLOV~1.LNK

"C:\Program Files (x86)\VisualD\pipedmd.exe" -deps Win32\Release\LibLoveD.lnkdep C:\D\dmd2\windows\bin\link.exe @C:\Users\root\DOCUME~1\VISUAL~1\Projects\LibLoveD\LibLoveD\Win32\Release\LIBLOV~1.LNK
if errorlevel 1 goto reportError
if not exist "Win32\Release\LibLoveD.dll" (echo "Win32\Release\LibLoveD.dll" not created! && goto reportError)

goto noError

:reportError
echo Building Win32\Release\LibLoveD.dll failed!

:noError

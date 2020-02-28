@echo off
SET MyProgram= "%~1"


REM ������ ������� ��������
if %MyProgram%=="" (
	echo Please specify path to program
	exit /B 1
)

REM ������ �������������� ���������� ����������
%MyProgram% "test/input1.txt" "%TEMP%\output.txt" fff > "%TEMP%\output.txt" && goto err1
fc test\output1.txt "%TEMP%\output.txt" || goto err2
echo test 1 passed successfuly

REM ������ � ������ ��������� ������� 
%MyProgram% "test/input1.txt" "%TEMP%\output.txt" "" asdasd > "%TEMP%\output.txt" && goto err1
fc test\output2.txt "%TEMP%\output.txt" || goto err2
echo test 2 passed successfuly

REM ������ � ������������ ������� ������ 
%MyProgram% "test/input1.xtx" "%TEMP%\output.txt" fff aaa > "%TEMP%\output.txt" && goto err1
fc test\output3.txt "%TEMP%\output.txt" || goto err2
echo test 3 passed successfuly

REM ����������� ����� ��� ���������
%MyProgram% "test/input4.txt" "%TEMP%\output.txt" frank dog || goto err1
fc test\output4.txt "%TEMP%\output.txt" || goto err2
echo test 4 passed successfuly

REM ��������� �������� ��� ��������� ������
%MyProgram% "test/input5.txt" "%TEMP%\output.txt" 1231234 dog || goto err1
fc test\output5.txt "%TEMP%\output.txt" || goto err2
echo test 5 passed successfuly

%MyProgram% "test/input6.txt" "%TEMP%\output.txt" " " * || goto err1
fc test\output6.txt "%TEMP%\output.txt" || goto err2
echo test 6 passed successfuly

%MyProgram% "test/input7.txt" "%TEMP%\output.txt" "dog dog" "turtle" || goto err1
fc test\output7.txt "%TEMP%\output.txt" || goto err2
echo test 7 passed successfuly

REM �������� �� ������������
%MyProgram% "test/input8.txt" "%TEMP%\output.txt" ma mama || goto err1
fc test\output8.txt "%TEMP%\output.txt" || goto err2
echo test 8 passed successfuly


echo all test passed successfuly 
exit /B 0

:err1
echo fail with input file
exit /B 0

:err2
echo fail with comparing files
exit /B 0
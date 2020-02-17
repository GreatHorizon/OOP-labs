@echo off
SET MyProgram= "%~1"


REM ������ ������� ��������
if %MyProgram%=="" (
	echo Please specify path to program
	exit /B 1
)

REM ������������� ���������� ����������
%MyProgram% > "%TEMP%\out.txt" && goto err1
fc Tests\one_argument.txt "%TEMP%\out.txt" || goto err2
echo test 1 passed successfuly

REM ������ ������	
%MyProgram% 0 > "%TEMP%\out.txt" || goto err1
fc Tests\lower_limit.txt "%TEMP%\out.txt" || goto err2
echo test 2 passed successfuly

REM ������� ������
%MyProgram% 255 > "%TEMP%\out.txt" || goto err1
fc Tests\upper_limit.txt "%TEMP%\out.txt" || goto err2
echo test 3 passed successfuly

REM �� �����
%MyProgram% a2 > "%TEMP%\out.txt" && goto err1
fc Tests\is_not_a_digit.txt "%TEMP%\out.txt" || goto err2
echo test 4 passed successfuly

REM ������ �������� �������
%MyProgram% 256 > "%TEMP%\out.txt" && goto err1
fc Tests\more_than_upper_limit.txt "%TEMP%\out.txt" || goto err2
echo test 5 passed successfuly

REM ������ ������� �������
%MyProgram% -10 > "%TEMP%\out.txt" && goto err1
fc Tests\below_than_lower_limit.txt "%TEMP%\out.txt" || goto err2
echo test 6 passed successfuly


echo all tests have passed successfuly
exit /B 0

:err1
echo fail with input
exit /B 0

:err2
echo fail with comparing files
exit /B 0
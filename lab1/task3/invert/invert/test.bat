@echo off
SET MyProgram= "%~1"

REM ������ ������� ��������
if %MyProgram%=="" (
	echo Please specify path to program
	exit /B 1
)

REM ������������� ���������� ����������
%MyProgram% > "%TEMP%\out.txt" && goto err1
echo test 1 passed successfully

REM ���������� �������
%MyProgram% "test/invalid_matrix_elements_input.txt" > "%TEMP%\out.txt" && goto err1
echo test 2 passed successfully

REM ������������ ��� �������� �����
%MyProgram% "test/input.xtx" > "%TEMP%\out.txt" && goto err1
echo test 3 passed successfully

REM ������������ ������ �������
%MyProgram% "test/invalid_matrix_size_input.txt" > "%TEMP%\out.txt" && goto err1
echo test 4 passed successfully

REM ������� �����
%MyProgram% "test/zero_matrix_input.txt" > "%TEMP%\out.txt" && goto err1
echo test 5 passed successfully

REM ��������� �������
%MyProgram% "test/unit_matrix_input.txt" > "%TEMP%\out.txt" && goto err1
echo test 6 passed successfuly

%MyProgram% "test/matrix1_input.txt" > "%TEMP%\out.txt" || goto err1
fc "%TEMP%\out.txt" test\matrix1_output.txt || goto err2
echo test 7 passed successfully

%MyProgram% "test/matrix2_input.txt" > "%TEMP%\out.txt" || goto err1
fc test\matrix2_output.txt "%TEMP%\out.txt" || goto err2
echo test 8 passed successfully

%MyProgram% "test/matrix3_input.txt" > "%TEMP%\out.txt" || goto err1
fc test\matrix3_output.txt "%TEMP%\out.txt" || goto err2
echo test 9 passed successfully

echo all tests have passed successfully
exit /B 0

:err1
echo fail with input
exit /B 0

:err2
echo fail with comparing files
exit /B 0
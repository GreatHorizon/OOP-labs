SET MyProgram= "%~1"

if %myProgram%=="" (
	echo Please specify path to the programm
	exit /B 1
)

REM ������������� ���������� ����������
%MyProgram% > "%TEMP%\output.txt" && goto err1
echo test 1 passed successfuly 

REM ������������ �����
%MyProgram% "epack" "test/input.txt" "%TEMP%\output.txt" > "%TEMP%\output.txt" && goto err1
echo test 2 passed successfuly 

REM ������ ������� ���� ��� ��������
%MyProgram% "pack" "test/empty.txt" "%TEMP%\output.txt" || goto err1
fc "test\empty.txt" %TEMP%\output.txt || goto err2
echo test 3 passed successfuly

REM ������ ������� ���� ��� ����������
%MyProgram% "unpack" "test/empty.txt" "%TEMP%\output.txt" || goto err1
fc "test\empty.txt" %TEMP%\output.txt || goto err2
echo test 4 passed successfuly

REM ���� � �������� ����������� ���� ��� ����������
%MyProgram% "unpack" "test/unpack_odd_byte_amount_input.txt" "%TEMP%\output.txt" && goto err1
echo test 5 passed successfuly

REM �������������� ������� ����
%MyProgram% "unpack" "test/inputFFF.txt" %TEMP%\output.txt && goto err1
echo test 6 passed successfuly

REM ��������� 256 ������ 
%MyProgram% "pack" "test\pack_input_1.txt" %TEMP%\output.txt || goto err1
fc "test\pack_output_1.txt" %TEMP%\output.txt || goto err2
echo test 7 passed successfuly

REM ��������� 255 ������ 
%MyProgram% "pack" "test\pack_input_2.txt" %TEMP%\output.txt || goto err1
fc "test\pack_output_2.txt" %TEMP%\output.txt || goto err2
echo test 8 passed successfuly

REM ���������� 256 ����� 
%MyProgram% "unpack" "test\unpack_input_1.txt" %TEMP%\output.txt || goto err1
fc "test\unpack_output_1.txt" %TEMP%\output.txt || goto err2
echo test 9 passed successfuly

REM ���������� 255 ������ 
%MyProgram% "unpack" "test/unpack_input_2.txt" %TEMP%\output.txt || goto err1
fc "test\unpack_output_2.txt" %TEMP%\output.txt || goto err2
echo test 10 passed successfuly

REM ��������� ������������������� �� ������ �����
%MyProgram% "pack" "test/pack_single_symbols_input.txt" %TEMP%\output.txt || goto err1
fc "test\pack_single_symbols_output.txt" %TEMP%\output.txt || goto err2
echo test 11 passed successfuly

REM ���������� ������������������� �� ������ �����
%MyProgram% "unpack" "test/pack_single_symbols_output.txt" %TEMP%\output.txt || goto err1
fc "test\pack_single_symbols_input.txt" %TEMP%\output.txt || goto err2
echo test 12 passed successfuly

REM ��������� 1 �����
%MyProgram% "pack" "test/pack_input_3.txt" %TEMP%\output.txt || goto err1
fc "test\pack_output_3.txt" %TEMP%\output.txt || goto err2
echo test 13 passed successfuly

REM ���������� 1 �����
%MyProgram% "unpack" "test/pack_output_3.txt" %TEMP%\output.txt || goto err1
fc "test\pack_input_3.txt" %TEMP%\output.txt || goto err2
echo test 14 passed successfuly

%MyProgram% "pack" "test/pack_input_4.txt" %TEMP%\output.txt || goto err1
fc "test\pack_output_4.txt" %TEMP%\output.txt || goto err2
echo test 15 passed successfuly

%MyProgram% "unpack" "test/pack_output_4.txt" %TEMP%\output.txt || goto err1
fc "test\pack_input_4.txt" %TEMP%\output.txt || goto err2
echo test 16 passed successfuly

echo All tests passed successuly
exit /B 0

:err1
echo fail with input
exit /B 0

:err2
echo fail with comparing files
exit /B 0
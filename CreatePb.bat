@echo off

::Э���ļ�·��, ���Ҫ����\������
set SOURCE_FOLDER=.

::C#������·��
set CS_COMPILER_PATH=.\CSharpTools\protogen.exe
::C#�ļ�����·��, ���Ҫ����\������
set CS_TARGET_PATH=.

::Python_TARGET_PATH������·��
set Python_COMPILER_PATH=.\PythonTools\protoc.exe
::Python_TARGET_PATH�ļ�����·��, ���Ҫ����\������
set Python_TARGET_PATH=.

::ɾ��֮ǰ�������ļ�
del %CS_TARGET_PATH%\*.cs /f /s /q
del %Python_TARGET_PATH%\*.py /f /s /q

::���������ļ�
for /f "delims=" %%i in ('dir /b "%SOURCE_FOLDER%\*.proto"') do (
    
	echo %%i
    ::���� C# ����
    echo %CS_COMPILER_PATH% -i:%%i -o:%CS_TARGET_PATH%\%%~ni.cs
    %CS_COMPILER_PATH% -i:%%i -o:%CS_TARGET_PATH%\%%~ni.cs
    
    ::���� Python ����
    echo %Python_COMPILER_PATH%  --python_out=%Python_TARGET_PATH% %%i
    %Python_COMPILER_PATH%  --python_out=%Python_TARGET_PATH% %%i
    
)

echo Э��������ϡ�

pause
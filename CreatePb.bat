@echo off

::协议文件路径, 最后不要跟“\”符号
set SOURCE_FOLDER=.

::C#编译器路径
set CS_COMPILER_PATH=.\CSharpTools\protogen.exe
::C#文件生成路径, 最后不要跟“\”符号
set CS_TARGET_PATH=.

::Python_TARGET_PATH编译器路径
set Python_COMPILER_PATH=.\PythonTools\protoc.exe
::Python_TARGET_PATH文件生成路径, 最后不要跟“\”符号
set Python_TARGET_PATH=.

::项目C#协议文件所在位置
set CS_PROTOCOL_PATH=C:\xGameClient\Assets\_Scripts\Common
::项目Python协议文件所在位置
set PYTHON_PROTOCOL_PATH=C:\xGame\common


::删除之前创建的文件
del %CS_TARGET_PATH%\*.cs /f /s /q
del %Python_TARGET_PATH%\*.py /f /s /q

::遍历所有文件
for /f "delims=" %%i in ('dir /b "%SOURCE_FOLDER%\*.proto"') do (
    
	echo %%i
    ::生成 C# 代码
    echo %CS_COMPILER_PATH% -i:%%i -o:%CS_TARGET_PATH%\%%~ni.cs
    %CS_COMPILER_PATH% -i:%%i -o:%CS_TARGET_PATH%\%%~ni.cs
    
    ::生成 Python 代码
    echo %Python_COMPILER_PATH%  --python_out=%Python_TARGET_PATH% %%i
    %Python_COMPILER_PATH%  --python_out=%Python_TARGET_PATH% %%i
    
)

echo 协议生成完毕。

::替换旧的文件
echo xcopy %CS_TARGET_PATH%\CmdMessage.cs  %CS_PROTOCOL_PATH%\CmdMessage.cs /s /e /y
xcopy %CS_TARGET_PATH%\CmdMessage.cs  %CS_PROTOCOL_PATH%\CmdMessage.cs /s /e /y
echo xcopy %Python_TARGET_PATH%\CmdMessage_pb2.py %PYTHON_PROTOCOL_PATH%\CmdMessage_pb2.py /s /e /y
xcopy %Python_TARGET_PATH%\CmdMessage_pb2.py %PYTHON_PROTOCOL_PATH%\CmdMessage_pb2.py /s /e /y


pause
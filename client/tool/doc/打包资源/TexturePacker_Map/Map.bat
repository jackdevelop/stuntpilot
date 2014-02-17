set DIR=%~dp0


resm 注释： 打包E:\chengxuziyuan\assets\res\fight 下的所有资源   最后输出Sheet_Map.plist文件

rem 注释：设置工作目录
set SRC_DIR="E:\chengxuziyuan\assets\res"





rem 注释：发布的目录
set srcdirs="fight"





rem 注释：设置发布的plist名称
set DEST_NAME="Sheet_Map"

















rem 注释：设置发布的scal
set SCALE="0.5"


set webp="false"

rem 注释：设置目标文件
set DEST_DIR="E:\chengxuziyuan\res"



set PHPPATH="update_build.php"
php %DIR%/%PHPPATH% -s %SRC_DIR% -d %DEST_DIR% -n %DEST_NAME% -scale %SCALE% -srcdirs %srcdirs% -webp %webp%


@echo success!!
pause;
set DIR=%~dp0


resm ע�ͣ� ���E:\chengxuziyuan\assets\res\fight �µ�������Դ   ������Sheet_Map.plist�ļ�

rem ע�ͣ����ù���Ŀ¼
set SRC_DIR="E:\chengxuziyuan\assets\res"





rem ע�ͣ�������Ŀ¼
set srcdirs="fight"





rem ע�ͣ����÷�����plist����
set DEST_NAME="Sheet_Map"

















rem ע�ͣ����÷�����scal
set SCALE="0.5"


set webp="false"

rem ע�ͣ�����Ŀ���ļ�
set DEST_DIR="E:\chengxuziyuan\res"



set PHPPATH="update_build.php"
php %DIR%/%PHPPATH% -s %SRC_DIR% -d %DEST_DIR% -n %DEST_NAME% -scale %SCALE% -srcdirs %srcdirs% -webp %webp%


@echo success!!
pause;
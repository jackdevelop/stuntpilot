<?php

require(__DIR__ . '/config.php');

require(__DIR__ . '/search.php');

/**



define('BASE_DIR', rtrim(__DIR__, '/\\'));
define('WORK_DIR', BASE_DIR . DS . 'workdir_');
define('SRC_DIR',  BASE_DIR . DS . 'build');
define('DEST_DIR', rtrim(realpath(BASE_DIR . '/../res'), '/\\'));
define('SCALE', 0.5);
**/

$baseDir = rtrim(__DIR__, '/\\');
$config = array(
    'BASE_DIR'        => $baseDir,
    'WORK_DIR'           => $baseDir . DS . 'workdir_',
    'SRC_DIR'             => $baseDir . DS . 'build',
    'DEST_DIR' => rtrim(realpath($baseDir . '/../res'), '/\\'),
    'SCALE'                => 0.5,
	'webp'	=> false,
	'destname' =>'SheetMapBattle',
);




if ($argv[1] == '-s')
{	
  $config["SRC_DIR"] = $argv[2];

}
if ($argv[3] == '-d')
{
  $config["DEST_DIR"] = $argv[4];
}
if ($argv[5] == '-n')
{
  $config["destname"] = $argv[6];
}
if ($argv[7] == '-scale')
{
  $config["SCALE"] = $argv[8];
}
if ($argv[9] == '-srcdirs')
{
  $config["srcdirs"] = $argv[10];
}

if ($argv[11] == '-webp')
{
  if ( $argv[12] == "false" ){
	 $config["webp"] =false;
  }else
	 $config["webp"] = $argv[12];
}



print("aaaaaaaaaaaaaaa");

print($config["srcdirs"]);
print("\n");
print($config["SRC_DIR"]."\\".$config["srcdirs"]);
print("\n");
$config["srcdirs"]=GetFolders($config["SRC_DIR"].'/'.$config["srcdirs"]);

print($config["srcdirs"]);
print("\n");
print("ppppppppppp");

if (!file_exists($config["WORK_DIR"]))
{
    mkdir($config["WORK_DIR"]);
}


chdir($config["SRC_DIR"]);










$time = time();
printf("START TIME: %s\n", date('Y-m-d H:i:s', $time));
printf("SRC_DIR  = %s\n", $config["SRC_DIR"]); //Դ�ļ�
printf("WORK_DIR = %s\n", $config["WORK_DIR"]); //��ʱ�����ռ�Ŀ¼
printf("DEST_DIR = %s\n", $config["DEST_DIR"]); //Ŀ���ļ� 
print("\n");

// ----------------------------------------

createTexture(array(
    'workdir' => $config["WORK_DIR"],
    'destdir' => $config["DEST_DIR"],
    'destname' => $config["destname"],
	
    'srcdirs' => explode("|", $config["srcdirs"]),
	//-srcdirs %srcdirs%
	//'srcdirs' => array(
   //     'build',
    //    'beahaviors',
       // 'static',
  //  ),
	
    'mode' => MODE_RGBA8888,
    'scale' => $config["SCALE"],
    'freesize' => false,
    'webp' => $config["webp"]
));

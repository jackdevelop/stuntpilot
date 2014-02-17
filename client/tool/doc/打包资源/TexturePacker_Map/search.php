<?php
/**
 * 获取给定路径下的所有目录
 * @staticvar array $all
 * @staticvar null $len
 * @param type $dir
 * @return array
 */
function GetFolders($dir) {
    $dir = realpath($dir);
    static $all = array();
    static $len = NULL;
    if ($len === NULL) {
        $len = strlen($dir) - strlen(basename($dir));
    }
    $dh = opendir($dir);
    if (!$dh) {
        exit("Can't open dir({$dir})!");
    }
    while (($file = readdir($dh)) !== false) {
        if ($file === '.' || $file === '..' || $file === '.svn') {
            continue;
        }
        $fullPath = $dir . DIRECTORY_SEPARATOR . $file;
        if (is_dir($fullPath)) {
            call_user_func(__FUNCTION__, $fullPath);
            continue;
        }
        $all[str_replace('\\', '/', substr($dir, $len))] = 1;
    }
    closedir($dh);
    return implode('|', array_keys($all));
}

//$dir = dirname(__FILE__);
//echo GetFolders($dir);

/*
function GetFolders2($currentFolder) {

    $sServerDir = $currentFolder;

    // Array that will hold the folders names.
    $aFolders = array();

    $oCurrentFolder = opendir($sServerDir);

    while ($sFile = readdir($oCurrentFolder)) {
        if ($sFile != '.' && $sFile != '..' && is_dir($sServerDir . $sFile))
            $aFolders[] = '<Folder name="' . ConvertToXmlAttribute($sFile) . '" />';
    }

    closedir($oCurrentFolder);

    // Open the "Folders" node.
    echo "<Folders>";

    natcasesort($aFolders);
    foreach ($aFolders as $sFolder)
        echo $sFolder;

    // Close the "Folders" node.
    echo "</Folders>";
}
*/
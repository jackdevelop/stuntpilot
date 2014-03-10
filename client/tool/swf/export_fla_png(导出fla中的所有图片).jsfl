//导出fla中的所有图片出来 
//图片的名称是以链接名为名称
var doc = fl.getDocumentDOM(); 
 var name = doc.name; 
 //设定输出路径为flaout 
 var path = "file:///D:/jsfltest/"; 
 //获取fla文件名，并且去除.fla扩展名 
var dir = name.substring(0, name.length-4) 
 var items = doc.library.items; 
 path = path + dir; 
 //在输出路径里创建一个和fla同名的目录 
FLfile.createFolder(path); 
 for (i = 0; i < items.length; i++) 
 { 
    if(items[i].itemType == "bitmap") 
    { 
       fl.trace("输出文件=>" + path + "/" +items[i].name + ":>>" + items[i].linkageClassName); 
       items[i].allowSmoothing = true; 
       items[i].compressionType = "lossless"; 

       //获取当前元件所在目录 
      var subpath = path + "/" + items[i].name; 
       subpath = subpath.substring(0,subpath.lastIndexOf("/")); 
       //创建目录 
      FLfile.createFolder(subpath); 
       //输出文件 
       var linkageClassName = items[i].linkageClassName;
       //var index = linkageClassName.indexOf(".");
        var str_after = (linkageClassName.split(".")[1]).toString();
 
	if(str_after.indexOf("Embeds_") == 0 ){
	 str_after = str_after.split("Embeds_")[1];
	}

 fl.trace("=="+str_after);
     // items[i].exportToFile(path + "/" + items[i].name + ".png" ); 
      items[i].exportToFile(path + "/" + str_after + ".png" ); 
    } 
 } 
 alert("输出完毕，关闭文件，请勿保存"); 
doc.close(); 
//����fla�е�����ͼƬ���� 
//ͼƬ����������������Ϊ����
var doc = fl.getDocumentDOM(); 
 var name = doc.name; 
 //�趨���·��Ϊflaout 
 var path = "file:///D:/jsfltest/"; 
 //��ȡfla�ļ���������ȥ��.fla��չ�� 
var dir = name.substring(0, name.length-4) 
 var items = doc.library.items; 
 path = path + dir; 
 //�����·���ﴴ��һ����flaͬ����Ŀ¼ 
FLfile.createFolder(path); 
 for (i = 0; i < items.length; i++) 
 { 
    if(items[i].itemType == "bitmap") 
    { 
       fl.trace("����ļ�=>" + path + "/" +items[i].name + ":>>" + items[i].linkageClassName); 
       items[i].allowSmoothing = true; 
       items[i].compressionType = "lossless"; 

       //��ȡ��ǰԪ������Ŀ¼ 
      var subpath = path + "/" + items[i].name; 
       subpath = subpath.substring(0,subpath.lastIndexOf("/")); 
       //����Ŀ¼ 
      FLfile.createFolder(subpath); 
       //����ļ� 
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
 alert("�����ϣ��ر��ļ������𱣴�"); 
doc.close(); 
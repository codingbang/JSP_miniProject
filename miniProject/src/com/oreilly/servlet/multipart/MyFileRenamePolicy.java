package com.oreilly.servlet.multipart;
import java.io.*;
import java.util.Date;

import java.text.SimpleDateFormat;

public class MyFileRenamePolicy implements FileRenamePolicy{

	@Override
	public File rename(File file) {
		long currentTime = System.currentTimeMillis();
		SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");
		int rabNum = (int)(Math.random()*100000);
		
		String uniqueFileName = "" + rabNum + simDf.format(new Date(currentTime));
		
		String name = file.getName();
		String body = null;
		String ext = null;
		
		int dot = name.lastIndexOf(".");
		if(dot != -1) {
			body = name.substring(0, dot);
			ext = name.substring(dot);
		} else {
			body = name;
			ext = "";
		}
		 String tempName = uniqueFileName + ext;
         file = new File(file.getParent(), tempName);
         if (createNewFile(file)) {
              return file;
         }

         int count = 0;
         while (!createNewFile(file) && count < 9999) {
              count++;
              String newName = uniqueFileName + "_" + count + ext;
              file = new File(file.getParent(), newName);
         }

         return file;
	}
	
	
	
	private boolean createNewFile(File file) {
        try {
             return file.createNewFile();
        }
        catch (IOException ignored) {
             return false;
        }
   }

}

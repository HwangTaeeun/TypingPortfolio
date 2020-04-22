package com.typingPP.eun.util;

import java.io.File;

// 이 클래스는 파일 업로드에 필요한 기능을 처리하기 위해서 만든 유틸리티적 클래스이다.
public class FileUtil {

	//동일한 파일이름이 업로드가 될경우 파일 이름을 바꿔서 저장해주는 메소드
	public static String rename(String path, String oldName) {
		
		int count =0; //동일한 파일의 경우 붙여질 번호를 기억할 변서
		
		String tmpName = oldName; //현재이름을 따로 기억해놓기
		 
		//먼저 oldName 으로 만들어진 파일이 있는지 체크한다
		File file = new File(path, oldName);
		 
		 while(file.exists()) {
			 //oldName으로 된 파일이 있는 경우
			 count++;
			 int len = tmpName.lastIndexOf(".");
			 System.out.println("FileUtil.java in len ====" + len);
			 String tmp1 =tmpName.substring(0, len);
			 System.out.println("FileUtil.java in tmp1 ====" + tmp1);
			 oldName = tmp1 + "_" + count + tmpName.substring(len);
			 
			 file = new File(path, oldName);
			 
		 }
		 return oldName;
	}
}

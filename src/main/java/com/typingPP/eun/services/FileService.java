package com.typingPP.eun.services;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.typingPP.eun.util.FileUtil;

public class FileService {
	Object dao;
	String spath;
	
	public void setDAO(Object dao) {
		this.dao = dao;
	}

	//파일 업로드를 처리할 함수
	public String singleUpProc(HttpSession session, MultipartFile multi) {
		String tpath = "";
		String saveName = "";
		long len = 0;
		
		spath = session.getServletContext().getRealPath(tpath);
		//실제 경로(real path)출력
		spath = spath + "resources\\upload";
		
		System.out.println("spath : " + spath);
		
		String rePath = spath.substring(0, spath.indexOf("\\source\\.metadata"));
		System.out.println("rePath : " + rePath);
		
		rePath = rePath + "\\source\\typingpp\\src\\main\\webapp\\resources\\upload";
		System.out.println("repath :" + rePath);
		
		//클라이언트가 업로드한 원본 이름을 알아낸다.
		String oriName = "";
		try {
			oriName = multi.getOriginalFilename();
			System.out.println("oriName ==" + oriName);
		}catch(Exception e) {
			return "";
		}
		
		saveName = FileUtil.rename(spath, oriName);
		
		//이라인이 존재한다는 의미는 업로드한 파일이 존재한다는 의미
		//혹시 중복되는 파일이름이 이미 존재할 경우에는 다른이름으로 저장을 한다.
		
		//저장할 이름이 생겼으므로 준비된 변수에 기억해 놓는다
		
		try {
			File file = new File(spath,saveName);
			System.out.println("####dao upfile complete!");
			
			len =multi.getSize();
			
			file = new File(rePath,saveName);
			multi.transferTo(file);
			
			System.out.println("upload Success");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return saveName;
	}
}

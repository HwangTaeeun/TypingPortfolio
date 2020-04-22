package com.typingPP.eun.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.typingPP.eun.vo.FileVO;

public class FileDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	public void memInfoPic(MultipartFile sFile,String sname, String sid) {
		FileVO fVO = new FileVO();
		
		fVO.setMid(sid);
		System.out.println("mid ==" + fVO.getMid());
		fVO.setOriname(sFile.getOriginalFilename());
		
		System.out.println("Ori ==" + fVO.getOriname());
		fVO.setSavename(sname);
		System.out.println("Save ==" + fVO.getSavename());
		fVO.setDir("/profile/");
		System.out.println("Dir ==" + fVO.getDir());
		fVO.setLen(sFile.getSize());
		System.out.println("Len ==" + fVO.getLen());
		System.out.println();
		
		int ck = sqlSession.selectOne("fSQL.profCk",fVO);
			System.out.println(ck);
		if(ck == 1) {
			sqlSession.update("fSQL.profUp",fVO);
		}else {
			sqlSession.insert("fSQL.profIn",fVO);
		}
	}
	
	public String getProf(FileVO fVO) {
		String result = sqlSession.selectOne("fSQL.getProf",fVO);
		return result;
	}
}

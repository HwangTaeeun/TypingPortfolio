package com.typingPP.eun.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.typingPP.eun.vo.MemberVO;

//mDAO
public class MemberDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	//로그인처리
	public int loginProc(MemberVO mVO) {
		int cnt = sqlSession.selectOne("mSQL.Login",mVO);
		return cnt;
	}
	
	//회원정보 가져오기
	public MemberVO memInfo(String id) {
		return sqlSession.selectOne("mSQL.memInfo", id);
	}
	
	//아이디중복체크
	public int idCheck(String id) {
		return sqlSession.selectOne("mSQL.idCheck", id);
	}
	
	//아이디중복체크
		public int nnameCheck(String nname) {
			return sqlSession.selectOne("mSQL.nnameCheck", nname);
	}
		
	
	//회원가입처리
	public int joinProc(MemberVO mVO) {
		return sqlSession.insert("mSQL.Join", mVO);
	}
	
	//회원정보 수정
	public int updateInfo(MemberVO mVO) {
		System.out.println("DAO nname==" +mVO.getNname());
		System.out.println("DAO id =="+mVO.getId());
		int cnt = sqlSession.update("mSQL.UpdateInfo", mVO);
		return cnt;
	}

}

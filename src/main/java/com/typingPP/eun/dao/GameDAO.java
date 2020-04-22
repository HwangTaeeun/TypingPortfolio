package com.typingPP.eun.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.typingPP.eun.vo.MemberVO;

//gDAO
public class GameDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int scoreUp(MemberVO mVO) {
		return sqlSession.update("gSQL.sUPDATE" , mVO);
	}
	
	public List ranking() {
		return sqlSession.selectList("gSQL.rankingSql");
	}
	
}

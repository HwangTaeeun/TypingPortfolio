package com.typingPP.eun;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.typingPP.eun.dao.GameDAO;
import com.typingPP.eun.dao.MemberDAO;
import com.typingPP.eun.vo.MemberVO;

@Controller
@RequestMapping


public class MainController {
	@Autowired
	MemberDAO mDAO;
	@Autowired
	GameDAO gDAO;
	@Autowired
	MemberVO mVO;
	
	@RequestMapping("/main.van")
	public ModelAndView getMain(ModelAndView mv,HttpSession session, MemberVO mVO) {
		List list = gDAO.ranking();
		
		String sid = (String) session.getAttribute("SID");
		
		session.setAttribute("SID", sid);
		
		mv.addObject("LIST",list);

		if( sid == null) {
			mv.setViewName("main/main");
			return mv;
		}else {		
			mVO.setId(sid);
			MemberVO memVO = mDAO.memInfo(mVO.getId());
			session.setAttribute("SSCORE", memVO.getScore());
			session.setAttribute("SNNAME", memVO.getNname());
			mv.addObject("DATA", memVO);
			mv.setViewName("main/main");
			return mv;
		}
		
	}
	
	
}

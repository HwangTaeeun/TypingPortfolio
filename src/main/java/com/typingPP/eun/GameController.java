package com.typingPP.eun;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.typingPP.eun.dao.GameDAO;
import com.typingPP.eun.vo.MemberVO;

@Controller
@RequestMapping("/game/")
public class GameController {
	@Autowired
	GameDAO gDAO;
	@Autowired
	MemberVO mVO;
	
	
	//스코어 가져오기
	@RequestMapping("scoreProc.van")
	public ModelAndView scoreProc(ModelAndView mv, RedirectView rv, HttpSession session, MemberVO mVO) {
		
		String sid = (String) session.getAttribute("SID");
		session.setAttribute("SID", sid);
		mVO.setId(sid);
		
		System.out.println("score ::" + mVO.getScore());
		System.out.println("id ::" +mVO.getId());
		int cnt = gDAO.scoreUp(mVO);
		if(cnt == 1) {
			rv.setUrl("/eun/main.van");
			mv.setView(rv);
			return mv;
		}else {
			rv.setUrl("/eun/main.van");
			mv.setView(rv);
			return mv;
		}
	}
}
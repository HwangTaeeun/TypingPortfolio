package com.typingPP.eun;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.typingPP.eun.dao.FileDAO;
import com.typingPP.eun.dao.MemberDAO;
import com.typingPP.eun.services.FileService;
import com.typingPP.eun.vo.FileVO;
import com.typingPP.eun.vo.MemberVO;

@Controller
@RequestMapping("/member/")
public class Member {
	@Autowired
	MemberDAO mDAO;
	@Autowired
	MemberVO mVO;
	@Autowired
	FileService fileSrvc;
	@Autowired
	FileDAO fDAO;

	// 로그인화면 매핑
	@RequestMapping("login.van")
	public ModelAndView login(ModelAndView mv) {
		mv.setViewName("login/login");
		return mv;
	}

	// 로그인 확인 처리
	@RequestMapping("loginProc.van")
	@ResponseBody
	public int loginProc(MemberVO mVO, RedirectView rv, HttpSession session, ModelAndView mv) {

		int cnt = mDAO.loginProc(mVO);
		if (cnt == 1) {
			session.setAttribute("SID", mVO.getId());
			return cnt;
		} else {
			return cnt;
		}
	}

	// 로그아웃
	@RequestMapping("logout.van")
	public ModelAndView logout(ModelAndView mv, RedirectView rv, HttpSession session) {
		session.setAttribute("SID", null);
		rv.setUrl("/eun/main.van");
		mv.setView(rv);
		return mv;
	}

	// 아이디 중복확인
	@RequestMapping("idCk.van")
	@ResponseBody
	public int idCk(String id) {
		int cnt = mDAO.idCheck(id);
		System.out.println(cnt);
		return cnt;
	}

	// 닉네임 중복확인
	@RequestMapping("nnameCk.van")
	@ResponseBody
	public int nnameCk(String nname) {
		int cnt = mDAO.nnameCheck(nname);
		return cnt;
	}

	// 회원가입 처리
	@RequestMapping("joinProc.van")
	public ModelAndView joinProc(ModelAndView mv, RedirectView rv, HttpSession session, MemberVO mVO) {
		System.out.println(mVO.getId());
		int cnt = mDAO.joinProc(mVO);
		System.out.println("mDAO--1");
		if (cnt == 1) {
			session.setAttribute("SID", mVO.getId());
			rv.setUrl("/eun/main.van");
		} else {
			rv.setUrl("/eun/login.van");
		}
		mv.setView(rv);
		return mv;
	}

	// 회원정보보기
	@RequestMapping("userInfo.van")
	public ModelAndView userInfo(ModelAndView mv, HttpSession session, MemberVO mVO,FileVO fVO) {
		String sid = (String) session.getAttribute("SID");
		MemberVO memVO = mDAO.memInfo(sid);
		fVO.setMid(sid);
		String sname = fDAO.getProf(fVO);
		
		mv.addObject("DATA", memVO);
		mv.addObject("SNAME", sname);
		mv.setViewName("main/userInfo");
		return mv;
	}

	// 회원정보수정하기
	@RequestMapping("editProc.van")
	public ModelAndView editProc(ModelAndView mv, RedirectView rv, MemberVO mVO, HttpSession session) {
		System.out.println("1111");
		int cnt = mDAO.updateInfo(mVO);
		
		
		MultipartFile sfile = mVO.getsFile();
		String sname;
		String sid = (String) session.getAttribute("SID");

		if (cnt ==1 && sfile != null) {
			System.out.println("파일이름"+mVO.getsFile().getSize());
			sname = fileSrvc.singleUpProc(session, sfile);
			fDAO.memInfoPic(sfile, sname, sid);
		}

		else if (cnt == 1 && sfile == null) {
			System.out.println("파일이 없습니다.");
			rv.setUrl("/eun/member/userInfo.van");
			mv.setView(rv);
		} else {
			System.out.println("실패");
		}
		
		rv.setUrl("/eun/member/userInfo.van");
		mv.setView(rv);
		return mv;
	}

}

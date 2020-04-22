package com.typingPP.eun.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

//	mVO
public class MemberVO {
	
	private int mno;
	private String id;
	private String pw;
	private String nname;
	private String birth;
	private Date wDate;
	private String sDate;

	private int score;
	private int ranking;
	private MultipartFile sFile;
	
	
	public int getMno() {
		return mno;
	}
	
	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getNname() {
		return nname;
	}

	public void setNname(String nname) {
		this.nname = nname;
	}
	
	
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public Date getwDate() {
		return wDate;
	}
	public void setwDate(Date wDate) {
		setsDate();
		this.wDate = wDate;
	}
	
	
	public String getsDate() {
		return sDate;
	}
	public void setsDate() {
		SimpleDateFormat form = new SimpleDateFormat("yyyy/MM/dd");
		this.sDate = form.format(wDate);
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}

	public MultipartFile getsFile() {
		return sFile;
	}

	public void setsFile(MultipartFile sFile) {
		this.sFile = sFile;
	}
	
	
	
	
	
}
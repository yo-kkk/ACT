package com.project.act.models_dto;

import java.io.Serializable;
import java.sql.Date;

public class ArticleDTO implements Serializable{
	private long art_no			;
	private String title		;
	private String content		;
	private int likes			;
	private int dislikes		;
	private Date reg_date		;
	private int readcnt			;
	private BoardDTO boardDTO	;
	private EmployeeDTO empDTO	;
	
	public ArticleDTO() {}
	
	public ArticleDTO(long art_no, String title, String content, int likes, int dislikes, Date reg_date, int readcnt,
			BoardDTO boardDTO, EmployeeDTO empDTO) {
		super();
		this.art_no = art_no;
		this.title = title;
		this.content = content;
		this.likes = likes;
		this.dislikes = dislikes;
		this.reg_date = reg_date;
		this.readcnt = readcnt;
		this.boardDTO = boardDTO;
		this.empDTO = empDTO;
	}
	
	@Override
	public String toString() {
		return "ArticleDTO [art_no=" + art_no + ", title=" + title + ", content=" + content + ", likes=" + likes
				+ ", dislikes=" + dislikes + ", reg_date=" + reg_date + ", readcnt=" + readcnt + ", boardDTO="
				+ boardDTO + ", empDTO=" + empDTO + "]";
	}
	
	public long getArt_no() {
		return art_no;
	}
	public void setArt_no(long art_no) {
		this.art_no = art_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getDislikes() {
		return dislikes;
	}
	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public BoardDTO getBoardDTO() {
		return boardDTO;
	}
	public void setBoardDTO(BoardDTO boardDTO) {
		this.boardDTO = boardDTO;
	}
	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}
	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}
	
	
}

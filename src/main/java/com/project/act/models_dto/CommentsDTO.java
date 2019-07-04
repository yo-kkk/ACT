package com.project.act.models_dto;

import java.io.Serializable;
import java.sql.Date;


public class CommentsDTO implements Serializable{
	
	private long com_no;
	private String content;
	private Date regdate;
	private int likes;
	private int dislikes;
	private ArticleDTO articleDTO;
	private EmployeeDTO empDTO;
	
	public CommentsDTO() {}
	
	public CommentsDTO(long com_no, String content, Date regdate, int likes, int dislikes, ArticleDTO articleDTO,
			EmployeeDTO empDTO) {
		super();
		this.com_no = com_no;
		this.content = content;
		this.regdate = regdate;
		this.likes = likes;
		this.dislikes = dislikes;
		this.articleDTO = articleDTO;
		this.empDTO = empDTO;
	}
	
	@Override
	public String toString() {
		return "CommentsDTO [com_no=" + com_no + ", content=" + content + ", regdate=" + regdate + ", likes=" + likes
				+ ", dislikes=" + dislikes + ", articleDTO=" + articleDTO + ", empDTO=" + empDTO + "]";
	}
	public long getCom_no() {
		return com_no;
	}
	public void setCom_no(long com_no) {
		this.com_no = com_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
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
	public ArticleDTO getArticleDTO() {
		return articleDTO;
	}
	public void setArticleDTO(ArticleDTO articleDTO) {
		this.articleDTO = articleDTO;
	}
	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}
	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}
	
	

}

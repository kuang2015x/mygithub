package com.atguigu.crud.bean;

public class AdminLog {

	private int id;
	private String adminname;
	private String contentlog;
	private String createtime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAdminname() {
		return adminname;
	}
	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}
	public String getContentlog() {
		return contentlog;
	}
	public void setContentlog(String contentlog) {
		this.contentlog = contentlog;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	
}

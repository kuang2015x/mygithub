package com.atguigu.crud.bean;

import java.util.Date;

public class UploadAttached {

	private int id;
	private String name;
	private String uploadtime;
	private String attachedurl;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	
	public String getUploadtime() {
		return uploadtime;
	}
	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}
	public String getAttachedurl() {
		return attachedurl;
	}
	public void setAttachedurl(String attachedurl) {
		this.attachedurl = attachedurl;
	}
	 
}

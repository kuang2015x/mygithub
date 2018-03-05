package com.atguigu.crud.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.atguigu.crud.bean.UploadAttached;

public interface UploadAttchedMapper {

	void add(UploadAttached uploadAttached);

	List<UploadAttached> selectAll();

	UploadAttached selectById(int id);

	
}

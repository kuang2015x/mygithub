package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.dao.UploadAttchedMapper;
 import com.atguigu.crud.bean.UploadAttached;
import com.atguigu.crud.bean.User;
@Service
public class UploadAttachedService {

	@Autowired
	private UploadAttchedMapper uploadAttchedMapper;

	public void addAttached(UploadAttached uploadAttached) {
		uploadAttchedMapper.add(uploadAttached);
	}

	public List<UploadAttached> getAll() {

		return uploadAttchedMapper.selectAll();
	}

	public UploadAttached getById(int id) {
		return uploadAttchedMapper.selectById(id);
	}


}

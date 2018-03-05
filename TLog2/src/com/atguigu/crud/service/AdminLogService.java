package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.AdminLog;
import com.atguigu.crud.dao.AdminLogMapper;

@Service
public class AdminLogService {
	
	@Autowired
	private AdminLogMapper adminLogMapper;

	public void addLog(AdminLog al){
		
		 adminLogMapper.insertLog(al);
	}

	public List<AdminLog> getAll() {
		
		return adminLogMapper.selectAll();
	}

	public void deleteLog(Integer id) {
		// TODO Auto-generated method stub
		
		adminLogMapper.removeLog(id);
	}

}

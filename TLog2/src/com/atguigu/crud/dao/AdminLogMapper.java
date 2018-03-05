package com.atguigu.crud.dao;

import java.util.List;

import com.atguigu.crud.bean.AdminLog;

public interface AdminLogMapper {

	void insertLog(AdminLog al);

	List<AdminLog> selectAll();

	void removeLog(Integer id);

}

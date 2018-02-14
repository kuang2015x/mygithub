package com.atguigu.crud.dao;

import java.util.List;

import com.atguigu.crud.bean.User;

public interface UserMapper {

	User selectByName(String user);

	int addUser(User user);

	int UpdateById(User user);

	int UpdatePasswordById(User user);

	List<User> selectAll();

	User selectById(int userId);

	void deleteById(Integer id);

	void deleteByBatch(List<Integer> del_ids);

	List<User> findAllByName(String name);

}

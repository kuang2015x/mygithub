package com.atguigu.crud.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.LoginTicket;
import com.atguigu.crud.bean.User;
import com.atguigu.crud.dao.LoginTicketMapper;
import com.atguigu.crud.dao.UserMapper;

@Service
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private LoginTicketMapper loginTicketDAO;

	public User Login(String user){
		User user1 = userMapper.selectByName(user);
		
		return user1;
	}
	
	public boolean register(User user){
		int flag = userMapper.addUser(user);
		//System.out.println(flag);
		if(flag!=0){
			return true;
		}else{
			return false;
		}
	}
	public String addLoginTicket(int userId){
        LoginTicket ticket = new LoginTicket();
        ticket.setUserId(userId);
        Date date = new Date();
        date.setTime(date.getTime() + 1000*3600*24);
        ticket.setExpired(date);
        ticket.setStatus(0);
        ticket.setTicket(UUID.randomUUID().toString().replaceAll("-", ""));
        int flag = loginTicketDAO.addTicket(ticket);
        if(flag!=0){
        	return ticket.getTicket();
        }else{
        	return null;
        }
	}

	public boolean UpdateInfo(User user) {
		// TODO Auto-generated method stub
		int flag = userMapper.UpdateById(user);
		if(flag!=0){
			return true;
		}else{
			
			return false;
		}
		
	}

	public boolean UpdatePwd(User user) {

		int flag = userMapper.UpdatePasswordById(user);
		if(flag!=0){
			return true;
		}else{
			
			return false;
		}
	}

	public List<User> getAll() {
		// TODO Auto-generated method stub
		return userMapper.selectAll();
	}

	public LoginTicket selectByTicket(String value) {
		LoginTicket loginTicket= loginTicketDAO.selectByTicket(value);
		return loginTicket;
	}

	public User selectById(int userId) {
		User user = userMapper.selectById(userId);
		return user;
	}

	public void deleteBatch(List<Integer> del_ids) {
		
		userMapper.deleteByBatch(del_ids);
		
	}


	public void deleteUser(Integer id) {

		userMapper.deleteById(id);
	}

	public List<User> getAllByName(String name) {

		return userMapper.findAllByName(name);
	}
}

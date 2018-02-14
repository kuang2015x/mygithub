package com.atguigu.crud.dao;

import com.atguigu.crud.bean.LoginTicket;

public interface LoginTicketMapper {

	int addTicket(LoginTicket ticket);
	LoginTicket selectByTicket(String ticket);

}

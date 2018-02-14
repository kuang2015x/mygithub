package com.atguigu.crud.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.UserService;

/**
 * �˴����ڲ��������������Ӧ����ת
 * @author kuangxiang
 *
 */
@Controller
public class RouteController {
	
	@Autowired
	private UserService userService;

	//��ת������Ա��Ϣҳ
	@RequestMapping(path={"/info/{id}"})
	public String ToInfo(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "info";
	}
	//��Ա�б�
	@RequestMapping(path={"/index1/{id}"})
	public String ToEmplements(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "Emplements";
	}
	
	//����Ա�б�
	@RequestMapping(path={"/checkAdmin/{id}"})
	public String ToadminList(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "adminList";
	}
	
	//������
	@RequestMapping(path={"/importExcel/{id}"})
	public String importExcel(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "importExcel";
	}
}

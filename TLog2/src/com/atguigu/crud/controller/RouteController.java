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
 * 此处用于侧边栏点击后进行相应的跳转
 * @author kuangxiang
 *
 */
@Controller
public class RouteController {
	
	@Autowired
	private UserService userService;

	//跳转到管理员信息页
	@RequestMapping(path={"/info/{id}"})
	public String ToInfo(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "info";
	}
	//人员列表
	@RequestMapping(path={"/index1/{id}"})
	public String ToEmplements(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "Emplements";
	}
	
	//管理员列表
	@RequestMapping(path={"/checkAdmin/{id}"})
	public String ToadminList(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "adminList";
	}
	
	//导入表格
	@RequestMapping(path={"/importExcel/{id}"})
	public String importExcel(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "importExcel";
	}
	
	//跳转到上传页面
	@RequestMapping(path={"/upAttached/{id}"})
	public String ToupAttached(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "uploadAttached";
	}
	
	//跳转到日记页面
	@RequestMapping(path={"/adLog/{id}"})
	public String ToadminLog(@PathVariable("id") int id,Model model){
		User user = userService.selectById(id);
		model.addAttribute("user", user);
		return "adminLog";
	}
}

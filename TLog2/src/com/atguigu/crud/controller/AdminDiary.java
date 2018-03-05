package com.atguigu.crud.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.AdminLog;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.AdminLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class AdminDiary {

	@Autowired
	private AdminLogService adminLogService;
	
	@RequestMapping(value="addLog/{name}",method=RequestMethod.POST)
	@ResponseBody
	public Msg addLog(@PathVariable("name") String name,HttpServletRequest request,@RequestParam("content") String content){

		AdminLog adminLog = new AdminLog();
		adminLog.setAdminname(name);
		System.out.println(name);
		adminLog.setContentlog(content);
		Date datetime = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = format.format(datetime);
		adminLog.setCreatetime(dateString);
		
		adminLogService.addLog(adminLog);
		return Msg.success();
	}
	
	@RequestMapping(value="/alllog",method=RequestMethod.GET)
	public Msg allLog(@RequestParam(value="pn",defaultValue="1")Integer pn){
		
		PageHelper.startPage(pn,5);//每页大小也就是每页显示的数据的条数
		List<AdminLog> adminLog = adminLogService.getAll();
		//使用pageinfo包装查询出来的结果，只需要将pageinfor交给页面就行
		//分装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(adminLog,5);
		return Msg.success().add("pageInfo", page);
		
	}
	
	@RequestMapping(value="/deletLog/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteLogById(@PathVariable("id")Integer id){
		
		adminLogService.deleteLog(id);
		return Msg.success();
	}
	
}

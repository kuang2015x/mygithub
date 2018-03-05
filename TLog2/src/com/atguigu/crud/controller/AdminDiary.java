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
		
		PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
		List<AdminLog> adminLog = adminLogService.getAll();
		//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
		//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
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

package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.LoginTicket;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.UserService;
import com.atguigu.crud.utils.Tutils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class UserLogin {
	@Autowired
	private UserService userService;
	@RequestMapping(path={"/login"},method={RequestMethod.GET, RequestMethod.POST})
	public String Login(HttpServletRequest request,HttpServletResponse response,Model model){
		//User user = new User();
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String []remember=null;
		remember = request.getParameterValues("remember");
		//System.out.println("shuzu"+remember);
		Map<String,String> map = new HashMap<String,String>();
		User user1 = userService.Login(name);
		if(user1==null){
			map.put("code", "faile");
			map.put("ms", "用户名不存在");
			model.addAttribute("msg", map);
			return "index";			 
		}else{
			if (Tutils.MD5(password+user1.getSalt()).equals(user1.getPassword())){
				String str = userService.addLoginTicket(user1.getId());
				//System.out.println(str);
				Cookie cookie = new Cookie("ticket", str);
                cookie.setPath("/");
                if (remember!=null&&remember[0].equals("rememberme")) {
                    cookie.setMaxAge(3600*24*5);
                }
                response.addCookie(cookie);
                //return ToutiaoUtil.getJSONString(0, "注册成功");
				model.addAttribute("user", user1);
				return "info";
	        }
			//return Msg.success().add("user", user1);
			else{
				map.put("code", "faile");
				map.put("ms", "密码错误");
				model.addAttribute("msg", map);
				return "index";
			}
			
		}
	}
	
	@RequestMapping(value="/reg",method=RequestMethod.POST)
	public String Regist(HttpServletRequest request,HttpServletResponse response,Model model){
		String name = request.getParameter("name");
		//System.out.println(name);
		if(name.isEmpty()){
			Map<String,String>map = new HashMap<String,String>();
			//String a = "woshi";
			return "index";
		}
		User user1 = userService.Login(name);
		if(user1!=null){
			return "index";
		}
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		if(password!=password){
			return "index";
		}
		String email = request.getParameter("email");
		User user = new User();
		user.setName(name);
		user.setSalt(UUID.randomUUID().toString().substring(0, 5));
		user.setPassword(Tutils.MD5(password+user.getSalt()));
		user.setEmail(email);
		String head = String.format("http://images.nowcoder.com/head/%dt.png", new Random().nextInt(1000));
		user.setHeadUrl(head);
		//System.out.println(name);
		boolean flag = userService.register(user);
		//System.out.println(flag);
		if(flag){
			//System.out.println("注册成功");
			model.addAttribute("user", user);
			return "index1";
		}else{
			//System.out.println("注册失败");
			return "index";
		}
		//return "index1";
		
	}
	
	@RequestMapping(path={"/update/{id}"},method=RequestMethod.POST)
	@ResponseBody
	public Msg Update(@PathVariable("id") int id,@RequestParam("name")String name
			,@RequestParam("email") String email){
		Map<String,Object> map = new HashMap<>();
		User user = new User();
		user.setId(id);
		user.setName(name);//此处要判断修改的名称是否已经存在以给前端页面提示
		user.setEmail(email);
		boolean flag = userService.UpdateInfo(user);
		if(flag){
			return Msg.success();
		}else{
			return Msg.fail();
		}
	}
	
	//修改密码
	@RequestMapping(path={"/uppwd/{id}"},method=RequestMethod.POST)
	@ResponseBody
	public Msg updatePassword(@PathVariable("id") int id,@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword,@RequestParam("conPassword") String conPassword,
			@RequestParam("name") String name){
		User user1 = userService.Login(name);
		if(oldPassword.isEmpty()){
			return Msg.fail().add("msg", "旧密码不能为空");
		}
		if(!newPassword.equals(conPassword)){
			return Msg.fail().add("msg","两次输入的新密码不一致");
		}
		if (!Tutils.MD5(oldPassword+user1.getSalt()).equals(user1.getPassword())){
			return Msg.fail().add("msg","旧密码错误");
		}else{
			User user = new User();
			user.setId(id);
			user.setSalt(UUID.randomUUID().toString().substring(0, 5));
			user.setPassword(Tutils.MD5(newPassword+user.getSalt()));
			boolean flag = userService.UpdatePwd(user);
			if(flag){
				return Msg.success();
			}else{
				return Msg.fail();
			}
		}
	}
	@RequestMapping(path={"/users"})
	public String Users(HttpServletRequest request,Model model){

		Cookie[] cookies =request.getCookies();
		if (cookies!=null){
			if(cookies[1].getName().equals("ticket")){
				LoginTicket loginTicket = userService.selectByTicket(cookies[1].getValue());
				if (loginTicket.getStatus()==0){
					User user = userService.selectById(loginTicket.getUserId());
					if(user!=null){
						model.addAttribute("user", user);
						return "adminList";
					}else{
						return "index";
					}
				}else{
					return "index";
				}
			}
		}else{
			return "index";
		}
		return "index";
	}
	
	@RequestMapping("/allusers")
	@ResponseBody
	public Msg allUsers(@RequestParam(value="pn",defaultValue="1")Integer pn){
		PageHelper.startPage(pn,5);//每页大小也就是每页显示的数据的条数
		List<User> susers = userService.getAll();
		//使用pageinfo包装查询出来的结果，只需要将pageinfor交给页面就行
		//分装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(susers,5);
		return Msg.success().add("pageInfo", page);
	}
	
	//按id查询管理员
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		User user = userService.selectById(id);
		return Msg.success().add("user", user);
	}
	
	//保存管理员更改
	@RequestMapping(value="user/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(User user){
	System.out.println(user.getName());
		//employeeService.updateEmp(employee);
		userService.UpdateInfo(user);
		return Msg.success();
	}
	
	//删除员工
		@RequestMapping(value="/user/{ids}",method=RequestMethod.DELETE)
		@ResponseBody
		public Msg deleteEmpById(@PathVariable("ids")String ids){
			if(ids.contains("-")){
				//批量删除
				List<Integer> del_ids = new ArrayList<Integer>();
				String[] str_ids = ids.split("-");
				for(String string:str_ids){
					del_ids.add(Integer.parseInt(string));
				}
				userService.deleteBatch(del_ids);
			}else{
				Integer id = Integer.parseInt(ids);
				userService.deleteUser(id);
			}
			
			return Msg.success();
		}
		
		//按名称搜索
		@RequestMapping(value="/allusers/{name}")
		@ResponseBody
		public Msg allUsersByName(@RequestParam(value="pn",defaultValue="1")Integer pn,@PathVariable(value="name")String name){
			PageHelper.startPage(pn,5);//每页大小也就是每页显示的数据的条数
			List<User> susers = userService.getAllByName(name);
			//使用pageinfo包装查询出来的结果，只需要将pageinfor交给页面就行
			//分装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
			PageInfo page = new PageInfo(susers,5);
			return Msg.success().add("pageInfo", page);
		}
}

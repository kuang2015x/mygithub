package com.atguigu.crud.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.LoginTicket;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.UploadAttached;
import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.UploadAttachedService;
import com.atguigu.crud.service.UserService;
import com.atguigu.crud.utils.Tutils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class UserLogin {
	@Autowired
	private UserService userService;
	
	@Autowired
	private UploadAttachedService uploadAttachedService;
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
			map.put("ms", "�û���������");
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
                //return ToutiaoUtil.getJSONString(0, "ע��ɹ�");
				model.addAttribute("user", user1);
				return "info";
	        }
			//return Msg.success().add("user", user1);
			else{
				map.put("code", "faile");
				map.put("ms", "�������");
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
			//System.out.println("ע��ɹ�");
			model.addAttribute("user", user);
			return "index1";
		}else{
			//System.out.println("ע��ʧ��");
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
		user.setName(name);//�˴�Ҫ�ж��޸ĵ������Ƿ��Ѿ������Ը�ǰ��ҳ����ʾ
		user.setEmail(email);
		boolean flag = userService.UpdateInfo(user);
		if(flag){
			return Msg.success();
		}else{
			return Msg.fail();
		}
	}
	
	//�޸�����
	@RequestMapping(path={"/uppwd/{id}"},method=RequestMethod.POST)
	@ResponseBody
	public Msg updatePassword(@PathVariable("id") int id,@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword,@RequestParam("conPassword") String conPassword,
			@RequestParam("name") String name){
		User user1 = userService.Login(name);
		if(oldPassword.isEmpty()){
			return Msg.fail().add("msg", "�����벻��Ϊ��");
		}
		if(!newPassword.equals(conPassword)){
			return Msg.fail().add("msg","��������������벻һ��");
		}
		if (!Tutils.MD5(oldPassword+user1.getSalt()).equals(user1.getPassword())){
			return Msg.fail().add("msg","���������");
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
			for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals("ticket")){
				LoginTicket loginTicket = userService.selectByTicket(cookies[i].getValue());
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
		}
		}else{
			return "index";
		}
		return "index";
	}
	
	@RequestMapping("/allusers")
	@ResponseBody
	public Msg allUsers(@RequestParam(value="pn",defaultValue="1")Integer pn){
		PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
		List<User> susers = userService.getAll();
		//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
		//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
		PageInfo page = new PageInfo(susers,5);
		return Msg.success().add("pageInfo", page);
	}
	
	//��id��ѯ����Ա
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		User user = userService.selectById(id);
		return Msg.success().add("user", user);
	}
	
	//�������Ա����
	@RequestMapping(value="user/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(User user){
	System.out.println(user.getName());
		//employeeService.updateEmp(employee);
		userService.UpdateInfo(user);
		return Msg.success();
	}
	
	//ɾ��Ա��
		@RequestMapping(value="/user/{ids}",method=RequestMethod.DELETE)
		@ResponseBody
		public Msg deleteEmpById(@PathVariable("ids")String ids){
			if(ids.contains("-")){
				//����ɾ��
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
		
		//����������
		@RequestMapping(value="/allusers/{name}")
		@ResponseBody
		public Msg allUsersByName(@RequestParam(value="pn",defaultValue="1")Integer pn,@PathVariable(value="name")String name){
			PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
			List<User> susers = userService.getAllByName(name);
			//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
			//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
			PageInfo page = new PageInfo(susers,5);
			return Msg.success().add("pageInfo", page);
		}
		
		//�����ϴ�����
		@RequestMapping(value="uploadAttached/{name}")
		@ResponseBody
		public Msg uploadAttached(@RequestParam(value = "file") MultipartFile file,
			HttpSession session,@PathVariable(value="name") String name){
			if(file.isEmpty()){
				return Msg.fail();
			}else{
				String location = session.getServletContext().getRealPath("attached");
				String url = location+"/"+file.getOriginalFilename()+"-"+System.currentTimeMillis();
				//System.out.println(url);
				try {
					Date datetime = new Date();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String dateString = format.format(datetime);
					UploadAttached uploadAttached = new UploadAttached();
					uploadAttached.setName(name);
					uploadAttached.setAttachedurl(url);
					uploadAttached.setUploadtime(dateString);
					file.transferTo(new File(url));
					uploadAttachedService.addAttached(uploadAttached);
					return Msg.success();
					
				} catch (Exception e) {
					e.printStackTrace();
					return Msg.fail();
				} 
			}
			
			//return Msg.fail();
		}
		
		@RequestMapping(value="allattache")
		@ResponseBody
		public Msg getAllAttache(@RequestParam(value="pn",defaultValue="1")Integer pn){
			
			PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
			List<UploadAttached> attached = uploadAttachedService.getAll();
			//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
			//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
			PageInfo page = new PageInfo(attached,5);
			return Msg.success().add("pageInfo", page);
//			return Msg.fail();
		}
		
		@RequestMapping(value="/checkAttached/{id}",method=RequestMethod.POST)
		public void checkAttached(@PathVariable(value="id")int id,HttpServletRequest request, HttpServletResponse response,HttpSession session){
			
			response.setContentType("text/html;charset=utf-8");
	        response.setCharacterEncoding("utf-8");
	        UploadAttached uploadAttached = uploadAttachedService.getById(id);

	        
	        try {

	            // ���ļ�
	            // ��ȡ��Ҫ�����ļ���ȫ·��
	            // �õ�Ҫ���ص��ļ�����С�����Ը����Լ���ʵ���ļ������ģ������ǲ����Լ�������ļ���
	            String destinationfileName = uploadAttached.getAttachedurl();
	            String name = destinationfileName.substring(destinationfileName.lastIndexOf("/")+1);
	            //destinationfileName = new String(destinationfileName.getBytes("iso8859-1"), "utf-8");
	            // �õ�Ҫ���ص��ļ�������Ŀ¼��ͬ�ϣ�С�����Ը����Լ���Ŀ��������
	            name = name.substring(0, name.lastIndexOf("-"));
	            name = new String(name.getBytes("iso8859-1"),"utf-8");
	            String uploadpath = session.getServletContext().getRealPath("attached");
	            // �õ�Ҫ���ص��ļ�
	            File file = new File(destinationfileName);
	            //����ļ������ڣ�����ʾ����ʧ��
	            if (!file.exists()) {
	                System.out.println("�ļ������ڣ�����ʧ��");
	            } else {

	                // ������Ӧͷ��������������ظ��ļ���������ǻ���ֵ��������غ󣬳��ֵ����ص�ַ��
	                response.setHeader("content-disposition",
	                        "attachment;filename=" + URLEncoder.encode(name, "utf-8"));
	                // ��ȡҪ���ص��ļ������浽�ļ�������
	                FileInputStream in = new FileInputStream(destinationfileName);
	                // ���������
	                OutputStream out = response.getOutputStream();
	                // ����������
	                byte buffer[] = new byte[1024];
	                int len = 0;
	                // ѭ�����������е����ݶ�ȡ����������
	                while ((len = in.read(buffer)) > 0) {
	                    // ������������ݵ��������ʵ���ļ�����
	                    out.write(buffer, 0, len);
	                }
	                // �ر��ļ���
	                in.close();
	                // �ر������
	                out.close();
	            }
	        } catch (Exception e) {
	            // TODO: handle exception

	        }
			//return Msg.success();
		}
}

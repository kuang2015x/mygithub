package com.atguigu.crud.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.sl.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.atguigu.crud.utils.ExportExcelUtil;
import com.atguigu.crud.utils.Tutils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	//删除员工
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			//批量删除
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for(String string:str_ids){
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	//校验用户名是否可用
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|([\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "用户名必须是6到16位数字和字母");
		}
		boolean b = employeeService.chechUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	
	//保存员工信息
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			List<FieldError> errors = result.getFieldErrors();
			Map<String, Object> map = new HashMap<String, Object>();
			for(FieldError fieldError : errors){
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("FieldErrors", map);
		}else{
		employeeService.saveEmp(employee);
		return Msg.success();
		}
	}
	
	//查询所有员工信息
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		//引入pageHelper插件
				//在查询之前只需要调用，传入页码以及每页大小
				PageHelper.startPage(pn,5);//每页大小也就是每页显示的数据的条数
				List<Employee> emps = employeeService.getAll();
				//使用pageinfo包装查询出来的结果，只需要将pageinfor交给页面就行
				//分装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo", page);
	}
	
	//按id查询员工信息
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	//更新信息
	@RequestMapping(value="emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
	//System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		
		//引入pageHelper插件
		//在查询之前只需要调用，传入页码以及每页大小
		PageHelper.startPage(pn,5);//每页大小也就是每页显示的数据的条数
		List<Employee> emps = employeeService.getAll();
		//使用pageinfo包装查询出来的结果，只需要将pageinfor交给页面就行
		//分装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		//System.out.println(page.getTotal());
		return "list";
	}
	
	//导入Excel表格
	@RequestMapping(value="/uploadExcel",method=RequestMethod.POST )
	@ResponseBody
	public Msg importExcel(@RequestParam(value = "file") MultipartFile file,Model model,
			HttpSession session){
		if(file.isEmpty()){
			return Msg.fail();
		}else{
			String location = session.getServletContext().getRealPath("upload");
			String url = location+"/"+System.currentTimeMillis()+file.getOriginalFilename();
			//System.out.println(url);
			try {
				file.transferTo(new File(url));
				List<Employee>list = new ArrayList<>();
				list = Tutils.readExcel(url);
				//System.out.println(list.get(0).getdId());
				if(list==null){
					return Msg.fail();
				}else{
					employeeService.saveBatch(list);
					return Msg.success();
				}
			} catch (Exception e) {
				e.printStackTrace();
				return Msg.fail();
			} 
		}
		
	}
	
	//下载表格
	@RequestMapping(value="/downLoadExcel/{type}",method=RequestMethod.POST )
	public void downLoad(@PathVariable("type") String type,HttpServletRequest request,HttpServletResponse response) throws Exception{ 
		if("dai".equals(type)){
		List<Employee>list = employeeService.getAll();
		 String[] excelHeader = { "姓名", "性别", "邮箱","部门编号"};
		 int[] ds_format = { 1, 1, 1}; 
		try {
			Tutils.export( "export", "sheet1", excelHeader, ds_format, null,
					 list,  request,  response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		}else{
			
	        OutputStream os = null;    
	        Workbook wb = null;    //工作薄  
	          
	        try {  
	            //模拟数据库取值  
	            List<Employee> lo = new ArrayList<Employee>();  
	            for (int i = 0; i <1; i++) {  
	                Employee vo = new Employee();  
	                vo.setEmpName("110"+i);  
	                vo.setGender("M");  
	                vo.setEmail("js@163.com");   
	                vo.setdId(1);  
	                lo.add(vo);  
	            }  
	              
	            //导出Excel文件数据  
	            ExportExcelUtil util = new ExportExcelUtil();  
	            File file =util.getExcelDemoFile("/ExcelDemoFile/测试模板.xlsx"); 
	            System.out.println(file.length());
	            String sheetName="sheet1";    
	            wb = util.writeNewExcel(file, sheetName,lo);     
	            response.setContentType("application/vnd.ms-excel");  
	            response.setHeader("Content-disposition", "attachment;filename="+ new String(("model" + ".xlsx").getBytes(), "iso-8859-1"));  
	            os = response.getOutputStream();  
	            wb.write(os);    
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	        finally{  
	            os.flush();  
	            os.close();  
	            wb.close();  
	        }
			
		}
		 
	}
	
}

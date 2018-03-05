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
	
	//ɾ��Ա��
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			//����ɾ��
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
	
	//У���û����Ƿ����
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|([\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)){
			return Msg.fail().add("va_msg", "�û���������6��16λ���ֺ���ĸ");
		}
		boolean b = employeeService.chechUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "�û���������");
		}
	}
	
	//����Ա����Ϣ
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
	
	//��ѯ����Ա����Ϣ
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		//����pageHelper���
				//�ڲ�ѯ֮ǰֻ��Ҫ���ã�����ҳ���Լ�ÿҳ��С
				PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
				List<Employee> emps = employeeService.getAll();
				//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
				//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo", page);
	}
	
	//��id��ѯԱ����Ϣ
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	//������Ϣ
	@RequestMapping(value="emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
	//System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		
		//����pageHelper���
		//�ڲ�ѯ֮ǰֻ��Ҫ���ã�����ҳ���Լ�ÿҳ��С
		PageHelper.startPage(pn,5);//ÿҳ��СҲ����ÿҳ��ʾ�����ݵ�����
		List<Employee> emps = employeeService.getAll();
		//ʹ��pageinfo��װ��ѯ�����Ľ����ֻ��Ҫ��pageinfor����ҳ�����
		//��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ���������ݣ�����������ʾ��ҳ��
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		//System.out.println(page.getTotal());
		return "list";
	}
	
	//����Excel���
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
	
	//���ر��
	@RequestMapping(value="/downLoadExcel/{type}",method=RequestMethod.POST )
	public void downLoad(@PathVariable("type") String type,HttpServletRequest request,HttpServletResponse response) throws Exception{ 
		if("dai".equals(type)){
		List<Employee>list = employeeService.getAll();
		 String[] excelHeader = { "����", "�Ա�", "����","���ű��"};
		 int[] ds_format = { 1, 1, 1}; 
		try {
			Tutils.export( "export", "sheet1", excelHeader, ds_format, null,
					 list,  request,  response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		}else{
			
	        OutputStream os = null;    
	        Workbook wb = null;    //������  
	          
	        try {  
	            //ģ�����ݿ�ȡֵ  
	            List<Employee> lo = new ArrayList<Employee>();  
	            for (int i = 0; i <1; i++) {  
	                Employee vo = new Employee();  
	                vo.setEmpName("110"+i);  
	                vo.setGender("M");  
	                vo.setEmail("js@163.com");   
	                vo.setdId(1);  
	                lo.add(vo);  
	            }  
	              
	            //����Excel�ļ�����  
	            ExportExcelUtil util = new ExportExcelUtil();  
	            File file =util.getExcelDemoFile("/ExcelDemoFile/����ģ��.xlsx"); 
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

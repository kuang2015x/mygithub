package com.atguigu.crud.utils;
import java.io.File;  
import java.io.FileInputStream;  
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;  
import org.apache.poi.ss.usermodel.CellStyle;  
import org.apache.poi.ss.usermodel.Row;  
import org.apache.poi.ss.usermodel.Sheet;  
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.atguigu.crud.bean.Employee;

public class ExportExcelUtil {
	 public  File getExcelDemoFile(String fileDir) throws Exception{  
	        String classDir = null;  
	        String fileBaseDir = null;  
	        File file = null;  
	        classDir = Thread.currentThread().getContextClassLoader().getResource("/").getPath();  
	        fileBaseDir = classDir.substring(0, classDir.lastIndexOf("classes"));  
	          //System.out.println(fileBaseDir);
	        file = new File(fileBaseDir+fileDir);  
	        if(!file.exists()){  
	            throw new Exception("模板文件不存在！");  
	        }  
	        return file;  
	    }  
	      
	    public  Workbook writeNewExcel(File file,String sheetName,List<Employee> lo) throws Exception{  
	        Workbook wb = null;  
	        Row row = null;   
	        Cell cell = null;  
	          
	        FileInputStream fis = new FileInputStream(file);   
	            wb = new XSSFWorkbook(fis);  //2007+  
	        
	        Sheet sheet = wb.getSheet(sheetName);  
	          
	        //循环插入数据  
	        int lastRow = sheet.getLastRowNum()+1;    //插入数据的数据ROW  
	        for (int i = 0; i < lo.size(); i++) {  
	            row = sheet.createRow(lastRow+i); //创建新的ROW，用于数据插入  
	              
	            //按项目实际需求，在该处将对象数据插入到Excel中  
	            Employee vo  = lo.get(i);  
	            if(null==vo){  
	                break;  
	            }  
	            //Cell赋值开始  
	            cell = row.createCell(0);  
	            cell.setCellValue(vo.getEmpName());  
	             
	              
	            cell = row.createCell(1);  
	            cell.setCellValue(vo.getGender());  
	              
	              
	            cell = row.createCell(2);  
	            cell.setCellValue(vo.getEmail());  
	              
	              
	            cell = row.createCell(3);  
	            cell.setCellValue(Integer.valueOf(vo.getdId()));  
	              
	        }  
	        return wb;  
	    }   
}

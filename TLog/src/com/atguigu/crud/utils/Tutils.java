package com.atguigu.crud.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.jni.File;
import org.springframework.util.StringUtils;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.User;

public class Tutils {

	/**
	 * md5加密
	 * @param key
	 * @return
	 */
	public static String MD5(String key) {
        char hexDigits[] = {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
        };
        try {
            byte[] btInput = key.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            //logger.error("生成MD5失败", e);
            return null;
        }
    }
	/**
	 * 解析Excel表
	 * @param path
	 * @return
	 */
	public static List<Employee> readExcel(String path){
		XSSFWorkbook workbook;
		
		List<Employee> list = new ArrayList<Employee>();
		try {
			workbook = new XSSFWorkbook(new FileInputStream(path));
			//XSSFSheet sheet = workbook.getSheetAt(0);// 得到工作表
			XSSFSheet sheet = workbook.getSheet("Sheet1");//获取Excel中的工作表
			int rows = sheet.getPhysicalNumberOfRows();	//获取工作表中的行数
			
			for(int i=1;i<rows;i++){
				XSSFRow row = sheet.getRow(i);
				
				if(row!=null){
					//int cells = row.getPhysicalNumberOfCells(); //表中的总列数
					//for(int j=0;j<cells;j++){
						//System.out.print(row.getCell(j)+" ");
						Employee user = new Employee();
						user.setEmpName(String.valueOf(row.getCell(0)));
						user.setGender(String.valueOf(row.getCell(1)));
						user.setEmail(String.valueOf(row.getCell(2)));
						String str=String.valueOf(row.getCell(3));
						user.setdId(Integer.valueOf(str.substring(0, 1)));
						list.add(user);
						
					//}
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//File.close(0);
			e.printStackTrace();
		}
		return list; 
		
		//return null;
		
	}
	
	//导出Excel表格
	public static void export(String excelName, String sheetName, String[] headers,int[] ds_format, int[] widths,
			List<Employee> list, HttpServletRequest request, HttpServletResponse response) throws IOException {

		int width = 256*14;
		String excelfont = "微软雅黑";
		HttpSession session = request.getSession();    
        session.setAttribute("state", null);
        if(widths==null){  
            widths = new int[headers.length];   
            for(int i=0;i<headers.length;i++){  
                widths[i]=width;  
            }  
        }
        
        if(ds_format==null){  
            ds_format = new int[headers.length];  
            for(int i=0;i<headers.length;i++){  
                ds_format[i]=1;  
            }  
        } 
      //设置文件名 
        String fileName = "";  
        if(!StringUtils.isEmpty(excelName)){  
            fileName = excelName;  
        } 
      //创建一个工作薄  
        XSSFWorkbook wb = new XSSFWorkbook();  
        //创建一个sheet  
        XSSFSheet  sheet = wb.createSheet(StringUtils.isEmpty(sheetName)?sheetName:"excel");  
        //创建表头，如果没有跳过  
        int headerrow = 0;  
        if(headers!=null){  
            XSSFRow  row = sheet.createRow(headerrow);  
            //表头样式  
            XSSFCellStyle style = wb.createCellStyle();    
            XSSFFont font = wb.createFont();  
            //font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);  
            font.setFontName(excelfont);  
            font.setFontHeightInPoints((short) 11);  
            style.setFont(font);    
             for (int i = 0; i < headers.length; i++) {    
                sheet.setColumnWidth((short)i,(short)widths[i]);   
                XSSFCell cell = row.createCell(i);    
                cell.setCellValue(headers[i]);    
                cell.setCellStyle(style);    
            }    
            headerrow++;  
        }  
        //表格主体  解析list  
        if(list != null){  
            List styleList = new ArrayList();  
              
            for (int i = 0; i <headers.length; i++) {  //列数  
                XSSFCellStyle style = wb.createCellStyle();    
                XSSFFont font = wb.createFont();  
                font.setFontName(excelfont);  
                font.setFontHeightInPoints((short) 10);  
                style.setFont(font);   

            }  
            for (int i = 0; i < list.size() ; i++) {  //行数  
                XSSFRow  row = sheet.createRow(headerrow);  
               // Map map = list.get(i); 
               XSSFCell cell = row.createCell(0);
               cell.setCellValue(list.get(i).getEmpName());
               XSSFCell cell1 = row.createCell(1);
               cell1.setCellValue(list.get(i).getGender());
               XSSFCell cell2 = row.createCell(2);
               cell2.setCellValue(list.get(i).getEmail());
               XSSFCell cell3 = row.createCell(3);
               cell3.setCellValue((Integer.valueOf(list.get(i).getdId()))); 
                headerrow++;  
            }  
        }  
         
        fileName=fileName+".xlsx";  
        String filename = "";  
        try{  
           filename =encodeChineseDownloadFileName(request,fileName);  
        }catch(Exception e){  
            e.printStackTrace();  
        }     
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //XSSFSheet sheet = workbook.getSheetAt(0)
        byte[] content = os.toByteArray();
        InputStream is = new ByteArrayInputStream(content);
        // 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="+filename);
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try {
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (final IOException e) {
            throw e;
        } finally {
            if (bis != null)
                bis.close();
            if (bos != null)
                bos.close();
        }
        //return null;
	}
	private static String encodeChineseDownloadFileName(HttpServletRequest request, String pFileName) throws IOException {
		String filename = null;      
        String agent = request.getHeader("USER-AGENT");      
        if (null != agent){      
            if (-1 != agent.indexOf("Firefox")) {//Firefox      
                filename = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(pFileName.getBytes("UTF-8"))))+ "?=";      
            }else if (-1 != agent.indexOf("Chrome")) {//Chrome      
                filename = new String(pFileName.getBytes(), "ISO8859-1");      
            } else {//IE7+      
                filename = java.net.URLEncoder.encode(pFileName, "UTF-8");      
                filename = filename.replace("+", "%20");  
            }      
        } else {      
            filename = pFileName;      
        }      
        return filename; 
	}  
}

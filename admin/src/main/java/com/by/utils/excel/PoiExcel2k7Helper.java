package com.by.utils.excel;
import java.io.FileInputStream;  
import java.util.ArrayList;  
import java.util.Iterator;  
  
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;  
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  
  
/** 
 * Excel 2007+
 * @author  carl zhou 
 * @date    2013-4-11 
 * @note    PoiExcel2k7Helper 
 */  
public class PoiExcel2k7Helper extends PoiExcelHelper {  
	 /** 获取 sheet 列表 */  
    public ArrayList<String> getSheetList(String filePath) {  
        ArrayList<String> sheetList = new ArrayList<String>(0);  
        try {  
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(filePath));  
            Iterator<XSSFSheet> iterator = wb.iterator();  
            while (iterator.hasNext()) {  
                sheetList.add(iterator.next().getSheetName());  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return sheetList;  
    }  
  
    /** 读取Excel指定sheet的行、列 */  
    public ArrayList<ArrayList<String>> readExcel(String filePath, int sheetIndex, String rows, String columns) {  
        ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();  
        try {  
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(filePath));  
            XSSFSheet sheet = wb.getSheetAt(sheetIndex);  
              
            dataList = readExcel(sheet, rows, getColumnNumber(sheet, columns));  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return dataList;  
    }  
      
    /** 读取Excel指定sheet的行、多列 */    
    public ArrayList<ArrayList<String>> readExcel(String filePath, int sheetIndex, String rows, int[] cols) {  
        ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();  
        try {  
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(filePath));  
            XSSFSheet sheet = wb.getSheetAt(sheetIndex);  
              
            dataList = readExcel(sheet, rows, cols);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return dataList;  
    }  
    
    /** 读取Excel指定连续sheet的行、多列 */  
    public ArrayList<ArrayList<String>> readExcel(String filePath, int sheetStart, int sheetEnd, String rows, int[] cols) {  
        ArrayList<ArrayList<String>> dataList = new ArrayList<ArrayList<String>> ();  
        try {  
        	XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(filePath)); 
            for(int i = sheetStart; i <= sheetEnd; i++) {
            	XSSFSheet sheet = wb.getSheetAt(i); 
            	ArrayList<ArrayList<String>> sheetList = new ArrayList<ArrayList<String>> ();
            	sheetList = readExcel(sheet, rows, cols); 
            	dataList.addAll(sheetList);
            }
              
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return dataList;  
    } 
}  

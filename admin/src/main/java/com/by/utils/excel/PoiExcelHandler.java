package com.by.utils.excel;
import java.util.ArrayList;
import java.util.List;

/** 
 * Excel POI Handler for Excel 2003,2007
 * @author  carl zhou
 * @date    2013-04-11
 * @note    PoiHandler 
 */ 

public class PoiExcelHandler {
	
	private static PoiExcelHandler instance = null;
	
	private PoiExcelHandler() {
	}
	
	public static PoiExcelHandler newInstance() {
		if(instance == null) {
			PoiExcelHandler instance = new PoiExcelHandler();
			return instance;
		} else {
			return instance;
		}
	}

	// 获取所有sheet 
    // getSheetList("c:/test.xlsx");
	public static void getSheetList(String filePath) {
		PoiExcelHelper helper = getPoiExcelHelper(filePath);

		
		ArrayList<String> sheets = helper.getSheetList(filePath);

		printList(filePath, sheets);
	}
	
	// 指定读取某个sheet， 默认从0开始
    // readExcel("c:/test.xls", 0);
    public static void readExcel(String filePath, int sheetIndex) {  
        PoiExcelHelper helper = getPoiExcelHelper(filePath);  
          
        ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex);  
          
        printBody(dataList);  
    }  
      
    //指定读取某个sheet,指定行
    // readExcel("c:/test.xlsx", 1, "2,4-7,10-"); 
    public static void readExcel(String filePath, int sheetIndex, String rows) {  
        PoiExcelHelper helper = getPoiExcelHelper(filePath);  
          
       
        ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex, rows);  
          

        printBody(dataList);  
    }  
      
    //指定读取某个sheet,指定列
    // readExcel("c:/test.xls", 2, new String[] {"a","b","g","h","i","j"});
    /*public static void readExcel(String filePath, int sheetIndex, String[] columns) {  
        PoiExcelHelper helper = getPoiExcelHelper(filePath);  
          

        ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex, columns);  
          

        printHeader(columns);  
          

        printBody(dataList);  
    }  */
    
  //指定读取某个sheet,指定列
    // readExcel("c:/test.xls", 2, new String[] {"a","b","g","h","i","j"});
    public static List<ArrayList<String>> readExcel(String filePath, int sheetIndex, String[] columns) {  
        PoiExcelHelper helper = getPoiExcelHelper(filePath);  
          

        ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex, columns);  
          

        return dataList;
    }  
      

    //指定读取某个sheet,指定行和列
    // readExcel("c:/test.xlsx", 3, "2,4-7,10-", new String[] {"a","b","g","h","i","j"});  
    public static void readExcel(String filePath, int sheetIndex, String rows, String[] columns) {  
        PoiExcelHelper helper = getPoiExcelHelper(filePath);  
          
        ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex, rows, columns);  
          
        printHeader(columns);  
        
        printBody(dataList);  
    }
	
	private static PoiExcelHelper getPoiExcelHelper(String filePath) {
		PoiExcelHelper helper;
		if (filePath.indexOf(".xlsx") != -1) {
			helper = new PoiExcel2k7Helper();
		} else {
			helper = new PoiExcel2k3Helper();
		}
		return helper;
	}

	private static void printList(String filePath, ArrayList<String> sheets) {
		System.out.println();
		for (String sheet : sheets) {
			System.out.println(filePath + " ==> " + sheet);
		}
	}
	
    private static void printHeader(String[] columns) {  
        System.out.println();  
        for(String column : columns) {  
            System.out.print("\t\t" + column.toUpperCase());  
        }  
    }  
  
    private static void printBody(ArrayList<ArrayList<String>> dataList) {  
        int index = 0;  
        for(ArrayList<String> data : dataList) {  
            index ++;  
            System.out.println();  
            System.out.print(index);  
            for(String v : data) {  
                System.out.print("\t\t" + v);  
            }  
        }  
    }  
    
//    public static String getXMLContent(String filePath, int sheetIndex) {
//    	 PoiExcelHelper helper = getPoiExcelHelper(filePath);
//
//         ArrayList<ArrayList<String>> dataList = helper.readExcel(filePath, sheetIndex);
//
//         String xml = Excel2XmlUtil.getXMLContent(dataList, null);
//         return xml;
//    }
    
//    public static Object getDataLine(String filePath, int sheetIndex , Class clazz) {
//    	String xml = getXMLContent(filePath, sheetIndex);
//    	
//    	Object instance = clazz.newInstance();
//    	
//    	instance = (clazz.getName()) Xml2BeanUtil.convertXmlContentToBean(xml,clazz);
//    	
//    	return instance;
//    }
    
//    public static void main(String[] args) {
//    	String xml = getXMLContent("C:\\Users\\Carl\\Desktop\\ImportSupplier.xlsx", 0);
//    	System.out.println(xml);
//	}
}

package com.yuhui.core.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.OfficeXmlFileException;
import org.apache.poi.ss.usermodel.BuiltinFormats;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * @author 肖长江
 * excel处理工具类，暂只有读取方法
 */
public class ExcelUtils {

	/** 读取时默认头部名称前缀*/
	public static final String DEF_COLUMN_PIX = "COLUMN_";
	/** 默认工作薄页位置*/
	public static final int DEF_SHEET_INDEX = 0;
	/** 默认头部所在行位置*/
	public static final int DEF_HEAD_INDEX = 0;
	/** 默认读取行位置*/
	public static final int DEF_START_ROW_INDEX = 1;
	/** 默认读取列位置*/
	public static final int DEF_START_CELL_INDEX = 0;
	/** 生成excel默认列数*/
	public static final int DEF_COLUMN_WIDTH = 15;
	
	/** 单个sheet最多行数*/
	public static final int maxRow = 65000;
	/** 单个sheet最多列数*/
	public static final int maxCol = 256;
	
	/** excel版本：2007之前的版本*/
	public static final String EXCEL_VERSION_HSSF = "HSSFWorkbook";
	/** excel版本：2007之后的版本*/
	public static final String EXCEL_VERSION_XSSF = "XSSFWorkbook";
	/** excel默认版本为2007之后的版本*/
	public static final String DEF_EXCEL_VERSION = EXCEL_VERSION_XSSF;
	
	/** sheet名称默认前缀*/
	public static final String DEF_SHEET_PIX = "工作薄 ";
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 解析excel文件内容到数据集合;默认读取第一个工作薄，头部为第一行，从第二行第一列开始读取
	 * @param excelFile excel文件
	 * @return 返回解析后的数据集合
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public static List<Map<String,Object>> readExcel(File excelFile) throws FileNotFoundException, IOException{
		return readExcel(excelFile, DEF_SHEET_INDEX, DEF_START_ROW_INDEX, DEF_START_CELL_INDEX, DEF_HEAD_INDEX);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 解析excel文件内容到数据集合;默认读取第一个工作薄，头部为第一行，从第一列开始读取
	 * @param excelFile excel文件
	 * @param startRowIndex 开始读取数据行位置
	 * @return 返回解析后的数据集合
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public static List<Map<String,Object>> readExcel(File excelFile,int startRowIndex) throws FileNotFoundException, IOException{
		return readExcel(excelFile, DEF_SHEET_INDEX, startRowIndex, DEF_START_CELL_INDEX, DEF_HEAD_INDEX);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 解析excel文件内容到数据集合;默认读取第一个工作薄，从第一列开始读取
	 * @param excelFile excel文件
	 * @param startRowIndex 开始读取数据行位置
	 * @param headRowIndex 头部行位置
	 * @return 返回解析后的数据集合
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public static List<Map<String,Object>> readExcel(File excelFile,int startRowIndex,int headRowIndex) throws FileNotFoundException, IOException{
		return readExcel(excelFile, DEF_SHEET_INDEX, startRowIndex, DEF_START_CELL_INDEX, headRowIndex);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 解析excel文件内容到数据集合
	 * @param excelFile excel文件
	 * @param sheetIndex 读取工作薄页号
	 * @param startRowIndex 开始读取数据行位置
	 * @param startCellIndex 开始读取列位置
	 * @param headRowIndex 头部行位置
	 * @return 返回解析后的数据集合
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public static List<Map<String,Object>> readExcel(File excelFile,int sheetIndex,int startRowIndex,int startCellIndex,int headRowIndex) throws FileNotFoundException, IOException{
		List<Map<String,Object>> datas = new ArrayList<Map<String,Object>>();
		Workbook workbook = null;
		try {				
			workbook = new HSSFWorkbook(new FileInputStream(excelFile));
		}catch (OfficeXmlFileException e1) {
			workbook = new XSSFWorkbook(new FileInputStream(excelFile));
		}
		if(workbook != null){
			Sheet sheet = workbook.getSheetAt(sheetIndex);
			int count=sheet.getPhysicalNumberOfRows();
			List<String> heads = null;
			if(headRowIndex < DEF_HEAD_INDEX){
				Row headrow=sheet.getRow(startRowIndex);
				heads = readHeadColumn(headrow, startCellIndex, true);
			}else{
				Row headrow=sheet.getRow(headRowIndex);
				heads = readHeadColumn(headrow, startCellIndex, false);
			}
			if(count > startRowIndex){
				for(int i=startRowIndex; i<count; i++){
					Row dataRow=sheet.getRow(i);
					Map<String, Object> data = readDataRow(dataRow, startCellIndex, heads);
					if(data != null) datas.add(data);
				}
			}
		}
		return datas;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 将一行数据转换为map集合
	 * @param dataRow 数据行对象
	 * @param startCellIndex 列开始读取位置
	 * @param heads 列名集合，将作为map的key
	 * @return 返回数据行转换后的map集合
	 */
	public static Map<String, Object> readDataRow(Row dataRow,int startCellIndex,List<String> heads){
		Map<String, Object> dataMap = new HashMap<String, Object>();
		if(dataRow != null && heads != null){
			int cells=dataRow.getLastCellNum();
			if(cells > startCellIndex){
				short s = (short)startCellIndex;
				int k = 0;
				for(short i=s; i< cells; i++){
					Cell cell = dataRow.getCell(i);
					Object value = getCellValue(cell);
					dataMap.put(heads.get(k), value);
					k++;
				}
			}
		}
		return dataMap;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 读取头部列名到集合
	 * @param headrow 头部行对象
	 * @param startCellIndex 开始读取列位置
	 * @param isdefColumnFix 是否默认列名前缀
	 * @return 返回头部列名集合
	 */
	public static List<String> readHeadColumn(Row headrow,int startCellIndex,boolean isdefColumnFix){
		List<String> heads = new ArrayList<String>();
		if(headrow != null){
			int cells=headrow.getLastCellNum();
			if(cells > startCellIndex){
				if(isdefColumnFix){
					for(int i=startCellIndex; i<= cells; i++){
						heads.add(DEF_COLUMN_PIX + i);
					}
				}else{
					short s = (short)startCellIndex;
					for(short i=s; i< cells; i++){
						Cell cell = headrow.getCell(i);
						Object value = getCellValue(cell);
						if(value != null) heads.add(value.toString());
					}
				}
			}
		}
		return heads;
	}

	/**
	 * @author 肖长江
	 * @date 2015-6-17
	 * @todo TODO 读取单元格的值
	 * @param cell 单元格
	 * @return 返回单元格的值
	 */
	public static Object getCellValue(Cell cell){
		String temp = null;
		if(cell == null) return null;
		DecimalFormat df = new DecimalFormat("#");
		switch (cell.getCellType()) {
			case Cell.CELL_TYPE_STRING:
				temp = cell.getRichStringCellValue().getString().trim();
				break;
			case Cell.CELL_TYPE_NUMERIC:  
				temp = df.format(cell.getNumericCellValue()).toString();   
				break;   
			case Cell.CELL_TYPE_BOOLEAN:   
				temp = String.valueOf(cell.getBooleanCellValue()).trim();   
				break;   
			case Cell.CELL_TYPE_FORMULA:   
				temp = cell.getCellFormula();   
				break;   
			default:   
				temp = "";
		}
		return temp;
	}
	
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 生成excel头部
	 * @param workBook 工作薄
	 * @param sheet 要写的页
	 * @param headers 头部内容数组
	 * @param RowIndex 头部写入行位置
	 * @param ColIndex 头部写入列位置
	 * @throws Exception
	 */
	public static void createExcelHeader(Workbook workBook,Sheet sheet,String [] headers,int RowIndex,int ColIndex) throws Exception{
		sheet.setDefaultColumnWidth(DEF_COLUMN_WIDTH);
		Row row = sheet.createRow(RowIndex);
		Font font=workBook.createFont();
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		CellStyle cellStyle=workBook.createCellStyle();
		cellStyle.setFont(font);
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setWrapText(true);
		Cell cell = null;
		if(headers != null){
			for(int i = 0;i<headers.length;i++){
				cell = row.createCell(ColIndex+i);
				cell.setCellType(Cell.CELL_TYPE_STRING);
				cell.setCellValue(headers[i]);
				cell.setCellStyle(cellStyle);
			}
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件,默认为2007之前的版本
	 * @param excelFile excel文件
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void createExcel(File excelFile,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		createExcel(excelFile, null, null, null, listMap, columns);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件
	 * @param excelFile excel文件
	 * @param excelVersion excel版本，this.EXCEL_VERSION_XSSF为2007之后的版本，EXCEL_VERSION_HSSF为2007之前的版本
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void createExcel(File excelFile,String excelVersion,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		createExcel(excelFile, null, excelVersion, null, listMap, columns);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件，头部内容默认为columns内容了
	 * @param excelFile excel文件
	 * @param sheetName 工作薄名称
	 * @param excelVersion excel版本，this.EXCEL_VERSION_XSSF为2007之后的版本，EXCEL_VERSION_HSSF为2007之前的版本
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void createExcel(File excelFile,String sheetName,String excelVersion,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		createExcel(excelFile, sheetName, excelVersion, null, listMap, columns);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件,默认为2007之前的版本
	 * @param output 输出流
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void writeExcel(OutputStream output,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		writeExcel(output, null, null, null, listMap, columns);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件
	 * @param output 输出流
	 * @param excelVersion excel版本，this.EXCEL_VERSION_XSSF为2007之后的版本，EXCEL_VERSION_HSSF为2007之前的版本
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void writeExcel(OutputStream output,String excelVersion,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		writeExcel(output, null, excelVersion, null, listMap, columns);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-24
	 * @todo TODO 将excel直接写入输出流
	 * @param output 输出流
	 * @param sheetName 工作薄名称
	 * @param excelVersion excel版本，this.EXCEL_VERSION_XSSF为2007之后的版本，EXCEL_VERSION_HSSF为2007之前的版本
	 * @param headers 头部数据数组,如果为null,则将columns作为头部数据
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void writeExcel(OutputStream output,String sheetName,String excelVersion,String [] headers,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		Workbook workBook = null;
		if(excelVersion == null || "".equals(excelVersion)) excelVersion = DEF_EXCEL_VERSION;
		if(EXCEL_VERSION_HSSF.equals(excelVersion)){
			workBook = new HSSFWorkbook();
		} else if(EXCEL_VERSION_XSSF.equals(excelVersion)){
			workBook = new XSSFWorkbook();
		} else{			
			workBook = new XSSFWorkbook();
		}
		if(listMap != null){
			if(sheetName == null || "".equals(sheetName)) sheetName = DEF_SHEET_PIX;
			int sheetCount = listMap.size()/maxRow + 1;
			for(int i= 0; i< sheetCount; i++){
				Sheet sheet = workBook.createSheet(i > 0 ?sheetName + i:sheetName);
				if(headers == null) headers = columns;
				createExcelHeader(workBook, sheet, headers, DEF_HEAD_INDEX, DEF_START_CELL_INDEX);
				insertSheetBySubMap(workBook, sheet, listMap, columns, i*maxRow, (i+1)*maxRow);
			}
		}
		if(workBook != null){
			workBook.write(output);
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 根据map数据生成excel文件
	 * @param excelFile excel文件
	 * @param sheetName 工作薄名称
	 * @param excelVersion excel版本，this.EXCEL_VERSION_XSSF为2007之后的版本，EXCEL_VERSION_HSSF为2007之前的版本
	 * @param headers 头部数据数组,如果为null,则将columns作为头部数据
	 * @param listMap 内容数据集合
	 * @param columns 要写入的列名键数组，对应listMap中map的key
	 * @throws Exception
	 */
	public static void createExcel(File excelFile,String sheetName,String excelVersion,String [] headers,List<Map<String, Object>> listMap,String [] columns) throws Exception{
		FileOutputStream output = new FileOutputStream(excelFile);
		writeExcel(output, sheetName, excelVersion, headers, listMap, columns);
		output.close();
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 生成excel单个sheet内容，默认从第二行第一列开始写入
	 * @param workBook 工作薄
	 * @param sheet 要写入的页
	 * @param listMap 要写入的数据集合
	 * @param columns 要写入的列名键数组，对应listMap中的key
	 * @param startListIndex 数据集合开始位置
	 * @param endListIndex 数据集合结束位置(不包括该值所在位置)
	 * @throws Exception
	 */
	public static void insertSheetBySubMap(Workbook workBook,Sheet sheet,List<Map<String, Object>> listMap,String [] columns,int startListIndex,int endListIndex) throws Exception{ 
		insertSheetDataBySubMap(workBook, sheet, listMap, columns, DEF_START_ROW_INDEX, DEF_START_CELL_INDEX, startListIndex, endListIndex);
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 生成excel单个sheet内容
	 * @param workBook 工作薄
	 * @param sheet 要写入的页
	 * @param listMap 要写入的数据集合
	 * @param columns 要写入的列名键数组，对应listMap中的key
	 * @param startRowIndex 开始写入行位置
	 * @param StartColIndex 开始写入列位置
	 * @param startListIndex 数据集合开始位置
	 * @param endListIndex 数据集合结束位置(不包括该值所在位置)
	 * @throws Exception
	 */
	public static void insertSheetDataBySubMap(Workbook workBook,Sheet sheet,List<Map<String, Object>> listMap,String [] columns,int startRowIndex,int StartColIndex,int startListIndex,int endListIndex) throws Exception{
		if(listMap != null && listMap.size() > startListIndex){
			List<Map<String, Object>> dataMaps = null;
			if(listMap.size() <= endListIndex){
				dataMaps = listMap.subList(startListIndex,listMap.size());
			}else{				
				dataMaps = listMap.subList(startListIndex, endListIndex);
			}
			insertSheetDataByMap(workBook, sheet, dataMaps, columns, startRowIndex, StartColIndex);
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-23
	 * @todo TODO 生成excel单个sheet内容
	 * @param workBook 工作薄
	 * @param sheet 要写入的页
	 * @param listMap 要写入的数据集合
	 * @param columns 要写入的列名键数组，对应listMap中的key
	 * @param startRowIndex 开始写入行位置
	 * @param StartColIndex 开始写入列位置
	 * @throws Exception
	 */
	public static void insertSheetDataByMap(Workbook workBook,Sheet sheet,List<Map<String, Object>> listMap,String [] columns,int startRowIndex,int StartColIndex) throws Exception{
		CellStyle cellStyle1 = workBook.createCellStyle();
		cellStyle1.setDataFormat(Short.valueOf(BuiltinFormats.getBuiltinFormat("0.00%")+""));//百分比格式
		CellStyle cellStyle2 = workBook.createCellStyle();
		cellStyle2.setDataFormat(Short.valueOf(BuiltinFormats.getBuiltinFormat("0.00%")+""));//两位小数格式
		Object column=null;
		 String regex="^[0-9]+\\.{1}[0-9]*$";
		if(listMap != null){
			for(int i =0;i<listMap.size();i++){
				if(startRowIndex + i > maxRow) return;
				Row row = sheet.createRow(startRowIndex + i);
				Map<String, Object> content = listMap.get(i);
				
				for(int j = 0;j<columns.length;j++){
					if(StartColIndex + j >= maxCol) break;
					Cell cell = row.createCell(StartColIndex + j);
				    column= content.get(columns[j]);
				    if(null!=column){
				    	if(column.toString().matches(regex)){
					    	cell.setCellValue(Double.parseDouble(column.toString()));
					    	cell.setCellStyle(cellStyle2);
					    }else{
						    cell.setCellValue(column==null?"":column.toString());
					    }
				    }else{
				    	 cell.setCellValue(column==null?"":column.toString());
				    }
				}
			}
		}
	}
	
	
	
}

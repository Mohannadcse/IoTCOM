package genInputForIoTSAN;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.javatuples.Quartet;

public class GenerateInputConfig {
	public static void writeToExcell(String path, String appName, List<Quartet<String, String, String, String>> deviceCap, List<Quartet<String, String, String, List<String>>>userCap ) throws EncryptedDocumentException, InvalidFormatException, FileNotFoundException, IOException{
		//String fileName = path + removeWhiteSpaces(appName) + ".xlsx";
		String fileName = path + "inputConfig.xlsx";
		File file = null;
		FileOutputStream outPutStream = null;
		file = new File(fileName);
		XSSFWorkbook  workBook = null;
		
		if (file.exists()) {
			workBook = (XSSFWorkbook) WorkbookFactory.create(new FileInputStream(file));
        } else {
        	workBook = new XSSFWorkbook();
        }

		XSSFSheet sheet = workBook.createSheet(removeWhiteSpaces(appName));
		int currentRow = 0;
		for(Quartet<String, String, String, String> dev : deviceCap) {
			XSSFRow row =  sheet.createRow(currentRow++);
			row.createCell(0).setCellValue(dev.getValue0());
			//row.createCell(1).setCellValue(toString(setting.configValues));
		}
		
		for(Quartet<String, String, String, List<String>> usr : userCap) {
			XSSFRow row =  sheet.createRow(currentRow++);
			row.createCell(0).setCellValue(usr.getValue0());
			//row.createCell(1).setCellValue(toString(setting.configValues));
		}

		try {
			outPutStream = new FileOutputStream(fileName);
			workBook.write(outPutStream);
			workBook.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (outPutStream != null) {
				try {
					outPutStream.flush();
					outPutStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private static String removeWhiteSpaces(String str)
	{
		StringBuilder sb = new StringBuilder();

		for(int i = 0; i < str.length(); i++)
		{
			if(str.charAt(i) != ' ' && str.charAt(i) != '/')
			{
				sb.append(str.charAt(i));
			}
		}
		return sb.toString();
	}
}

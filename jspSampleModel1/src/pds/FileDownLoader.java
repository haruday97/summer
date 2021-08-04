package pds;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownLoader extends HttpServlet {
	
	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		mConfig = config;	// 업로드한 경로를 취득하기 위해서
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	//	System.out.println("FileDownLoader doGet");
		
		String newfilename = req.getParameter("newfilename");
		int seq = Integer.parseInt( req.getParameter("seq") );
		
		// download 카운터 증가
		PdsDao dao = PdsDao.getInstance();
		String filename = dao.getPds(seq).getFilename();
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		// path(경로)
		// tomcat(server)
		String filepath = mConfig.getServletContext().getRealPath("/upload");
		
		// 폴더
	//	String filepath = "d:\\tmp";
		
		filepath = filepath + "\\" + newfilename;
		System.out.println(filepath);
		
		File f = new File(filepath);	
		
		// 크롬 브라우저의 설정(한글명 파일 깨짐)
		String fileNameOrg = new String(filename.getBytes("UTF-8"),"ISO-8859-1");
		
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			resp.setHeader("Content-Length", "" + f.length());
			resp.setHeader("Pragma", "no-cache;"); 
			resp.setHeader("Expires", "-1;");		
		
			// 파일 생성, 기입
			BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
			
			byte buffer[] = new byte[BUFFER_SIZE];
			int read = 0;
			
			while((read = fileInput.read(buffer)) != -1) {
				out.write(buffer, 0, read);		// 실제 다운로드 부분			
			}		
			fileInput.close();
			out.flush();		
		
	}	
}






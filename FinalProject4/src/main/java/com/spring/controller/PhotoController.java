package com.spring.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.common.FileManager;


@Controller
public class PhotoController {

	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// === #162. 스마트에디터. 드래그앤드롭을 사용한 다중사진 파일업로드 === //
	@RequestMapping(value="/image/multiplePhotoUpload.action", method= {RequestMethod.POST}) 	// 파일업로드는 온리 POST 방식만 사용한다.
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {

		/*
			1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
			>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
			우리는 WAS 의 webapp/resources/photo_upload라는 폴더로 지정해준다.
		 */

		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "photo_upload";
		/*
			File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다. 
			운영체제가  Windows 이라면 File.separator 는 "\" 이고,
			운영체제가 UNIX, Linux 이라면 File.separator 는 "/" 이다.
		 */

		// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
		System.out.println("~~~~ 확인용 path => "+path);
		// ~~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload (실제경로)
		// C:\springworkspace\Board\src\main\webapp\resources\photo_upload 는 절대경로가 아니다.(프로젝트내에서 우클릭으로 확인하는 경로)


		// 자바에서는 폴더로 파일이고, 파일도 파일이다.
		// dir 은 directory 로 폴더이다. 
		File dir = new File(path);
		if(!dir.exists()) {	// 폴더가 존재하지 않으면
			dir.mkdirs();	// 폴더를 만들어라.(mkdir: 상위디렉토리 존재하지 않을 경우 생성불가, mkdirs: 상위디렉토리까지 생성)
		}


		String strURL = "";

		try {
			if(!"OPTIONS".equals(request.getMethod().toUpperCase())) {
				String filename = request.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명

				// System.out.println(">>>> 확인용 filename ==> " + filename); 
				// >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg

				InputStream is = request.getInputStream();
				/*
				          요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
				          혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
				          이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.

	               	  서블릿에서 payload body는 Request.getParameter()가 아니라 
	            	 Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
				 */
				String newFilename = fileManager.doFileUpload(is, filename, path);

				int width = fileManager.getImageWidth(path+File.separator+newFilename);

				if(width > 600)
					width = 600;

				// System.out.println(">>>> 확인용 width ==> " + width);
				// >>>> 확인용 width ==> 600
				// >>>> 확인용 width ==> 121

				String CP = request.getContextPath(); // board

				strURL += "&bNewLine=true&sFileName="; 
				strURL += newFilename;
				strURL += "&sWidth="+width;
				strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
			}

			/// 웹브라우저상에 사진 이미지를 쓰기 ///
			PrintWriter out = response.getWriter();
			out.print(strURL);


		} catch(Exception e){
			e.printStackTrace();
		}

	} // end of public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response)------------------


	
}

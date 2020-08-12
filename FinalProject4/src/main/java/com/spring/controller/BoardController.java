package com.spring.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.common.MyUtil;
import com.spring.model.FaqVO;
import com.spring.model.NoticeVO;
import com.spring.service.InterBoardService;

@Controller
public class BoardController {
	
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private InterBoardService service;


	// ===== #150. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired	// Type 에 따라 알아서 스프링컨테이너가 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// 고객센터 페이지로 이동
	@RequestMapping(value = "/qna.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String qna() {
		
		return "qna/qna.tiles1";
	}
	
	// FAQ 
	@ResponseBody
	@RequestMapping(value = "/faq.action", produces="text/plain;charset=UTF-8")
//	@RequestMapping(value = "/faq.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String qna(HttpServletRequest request) {
		
		String category = request.getParameter("category");
		String searchWord = request.getParameter("searchWord");
		
		System.out.println(category +"category");
		System.out.println(searchWord +"searchWord");
		
	// 	if(category == "0") {
		if(category.equals("0")) {
			category = "";
		}
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = ""; 
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("category", category);
		paraMap.put("searchWord", searchWord);
		
		
		List<FaqVO> faqList = service.faqList(paraMap);
		
		JSONArray jsonArr = new JSONArray();

		for(FaqVO faqvo : faqList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("category", faqvo.getFaq_cate_name());
			jsonObj.put("fk_userid", faqvo.getFk_userid());
			jsonObj.put("content", faqvo.getContent());
			jsonObj.put("subject", faqvo.getSubject());
			jsonObj.put("status", faqvo.getStatus());
			jsonObj.put("regDate", faqvo.getRegDate());


			jsonArr.put(jsonObj);
		}

		
		return jsonArr.toString();
		
		
	}
	
	
	// 고객센터 페이지로 이동
	@RequestMapping(value = "/noticeMain.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String noticeMain(HttpServletRequest request) {
		/*
		int totalCount = service.getTotalNoticeCount(paraMap);
		
		int sizePerPage = 10;
		int totalPage = (int) Math.ceil((double)totalCount / sizePerPage);

		request.setAttribute("totalPage", totalPage);
		System.out.println(totalPage +":totalPage");*/
		
		return "notice/notice.tiles1";
	}
	
	// 공지사항 페이지로 이동
	@ResponseBody
	@RequestMapping(value="/notice.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
//	public ModelAndView notice(HttpServletRequest request, ModelAndView mav) {
	public String notice(HttpServletRequest request) {
		
		List<NoticeVO> noticeList = null; 

		// == #112. 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 == //
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("page");
	//	String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		System.out.println("page : "+str_currentShowPageNo);
		System.out.println("searchWord : "+searchWord);
		
		// 검색어가 없을 때는(null) 검색어를 ""로 변환
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);


		int totalCount = 0; 		// 총 게시물 건수(totalCount)
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수 (select 태그로 값을 선택할 수도 있지만, 이번에는 무조건 10개로 고정한다.)
		int currentShowPageNo = 1;	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다. (아무것도 주지 않으면 1페이지로 고정이다.)
		int totalPage = 0;			// 총 페이지수(웹브라우저 상에 보여줄 총 페이지 개수, 페이지바)
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호


		// 먼저 총 게시물 건수(totalCount) 를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을 때로 나뉘어진다.
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalNoticeCount(paraMap);
		//	System.out.println("~~~~~ 확인용 totalCount : "+totalCount);

		totalPage = (int) Math.ceil((double)totalCount / sizePerPage);


		// str_currentShowPageNo 가 없다면 초기화면을 보여준다.
		if(str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면 
			currentShowPageNo = 1;
			// 즉, 초기화면인 /list.action 은 /list.action?currentShowPageNo=1 로 하겠다는 말이다.
		}
		// str_currentShowPageNo 가 있다면(페이지바에서 넘어온 값이 있다면), currentShowPageNo 는 str_currentShowPageNo 를 int 로 바꾼 값으로 한다.
		else {
			// list.action?searchType=subject&searchWord=&currentShowPageNo=abcdef 와 같이 
			// currentShowPageNo 에 숫자형태가 아닌 문자열이 올 경우 1페이지를 보여준다.
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

				if(currentShowPageNo <= 0 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}

			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		/*
		     currentShowPageNo      startRno     endRno
		    --------------------------------------------
		         1 page        ===>    1           10
		         2 page        ===>    11          20
		         3 page        ===>    21          30
		         4 page        ===>    31          40
		         ......                ...         ...
		 */

		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 


		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));


		// == 페이징 처리한 글목록 보여주기(검색이 있든지, 검색이 없든지 모두 다 포함한 것) == //
		noticeList = service.noticeListWithPaging(paraMap);
		
	//	if(!"".equals(searchWord)) {
	//		mav.addObject("paraMap", paraMap);
	//	}


		// === #119. 페이지바 만들기 === //
		String pageBar = "<ul style='list-style: none;'>";

		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		/*
				1  2  3  4  5  6  7  8  9  10   다음	-- 1개 블럭
			이전   11 12 13 14 15 16 17 18 19 20   다음	-- 1개 블럭
			이전   21 22 23
		 */

		int loop = 1;
		/* 
			loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		 */

		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

		String url = "list.action";
		// list.action?searchType=subject&searchWord=정화&currentShowPageNo=1


	//	mav.addObject("totalCount", totalCount);

		// === #121. 페이징 처리되어진 후 특정글제목을 클릭하여 상세내용을 본 이후
		// 			  사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		// 			  현재 페이지 주소를 뷰단으로 넘겨준다.
	//	String gobackURL = MyUtil.getCurrentURL(request);

		//	System.out.println("~~~~~ 확인용 gobackURL : " + gobackURL);
	//	mav.addObject("gobackURL", gobackURL);


		//////////////////////////////////////////////////////////////
		//
		// === #69. 글조회수(readCount)증가 (DML문 update)는
		//          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		//          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		//          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.

	//	HttpSession session = request.getSession();
	//	session.setAttribute("readCountPermission", "yes"); // 조회수증가권한의 값을 yes 로 세션에 저장한다.

		/*
		   session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
		   session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
		      반드시 웹브라우저에서 주소창에 "/list.action" 이라고 입력해야만 얻어올 수 있다. 
		 */

		//	session.setAttribute("gobackURL", gobackURL);


		//////////////////////////////////////////////////////////////

	//	mav.addObject("noticeList", noticeList);
	//	mav.setViewName("notice/notice_exam.tiles1");

	//	return mav;
		
		request.setAttribute("totalPage", totalPage);
		System.out.println(totalPage +":totalPage");
		
		JSONArray jsonArr = new JSONArray();

		for(NoticeVO notivo : noticeList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("notice_id", notivo.getNotice_id());
			jsonObj.put("category", notivo.getNo_cate_name());
			jsonObj.put("fk_userid", notivo.getFk_userid());
			jsonObj.put("ticketopenday", notivo.getTicketopenday());
			jsonObj.put("subject", notivo.getSubject());
			jsonObj.put("readCount", notivo.getReadCount());
			jsonObj.put("status", notivo.getStatus());
			jsonObj.put("regDate", notivo.getRegDate());
			jsonObj.put("fileName", notivo.getFileName());
			jsonObj.put("totalPage", totalPage);
			jsonObj.put("page", str_currentShowPageNo);

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();
	}
	
	
}

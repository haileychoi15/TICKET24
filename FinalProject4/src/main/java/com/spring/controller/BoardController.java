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
	
	@Autowired
	private InterBoardService service;

	@Autowired
	private FileManager fileManager;
	
	// 고객센터 페이지로 이동
	@RequestMapping(value = "/qna.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String qna() {
		
		return "qna/qna.tiles1";
	}
	
	// FAQ 
	@ResponseBody
	@RequestMapping(value = "/faq.action", produces="text/plain;charset=UTF-8")
	public String qna(HttpServletRequest request) {
		
		String category = request.getParameter("category");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("page");
		
		System.out.println(category +"category");
		System.out.println(searchWord +"searchWord");
		System.out.println(str_currentShowPageNo +"page");
		
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
		
		int sizePerPage = 5;
		
		int totalFaqCount = service.getTotalFaqCount(paraMap);
		
		int totalPage = (int) Math.ceil((double)totalFaqCount / sizePerPage);
		
		int currentShowPageNo = 1;	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다.	
		int startRno = 0;			
		int endRno = 0;				

		// str_currentShowPageNo 가 없다면 초기화면을 보여준다.
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

				if(currentShowPageNo <= 0 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}

			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 


		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		
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
			jsonObj.put("totalCount", totalFaqCount);
			jsonObj.put("totalPage", totalPage);
			jsonObj.put("page", str_currentShowPageNo);

		//	jsonObj.put("regDate", faqvo.getRegDate());
			
			jsonArr.put(jsonObj);
		}

		
		return jsonArr.toString();
		
		
	}
	
	
	// 고객센터 페이지로 이동
	@RequestMapping(value = "/noticeMain.action", produces="text/plain;charset=UTF-8")
	public ModelAndView noticeMain(HttpServletRequest request, ModelAndView mav) {
		
		String page = request.getParameter("page");
		/*
		int totalCount = service.getTotalNoticeCount(paraMap);
		
		int sizePerPage = 10;
		int totalPage = (int) Math.ceil((double)totalCount / sizePerPage);

		request.setAttribute("totalPage", totalPage);
		System.out.println(totalPage +":totalPage");*/
		
	//	return "notice/notice.tiles1";
		mav.addObject("page", page);
		mav.setViewName("notice/notice.tiles1");
		return mav;
	}
	
	// 공지사항 페이지로 이동
	@ResponseBody
	@RequestMapping(value="/notice.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
//	public ModelAndView notice(HttpServletRequest request, ModelAndView mav) {
	public String notice(HttpServletRequest request) {
		
		List<NoticeVO> noticeList = null; 

		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("page");
		String category = request.getParameter("category");
	//	System.out.println("page : "+str_currentShowPageNo);
	//	System.out.println("searchWord : "+searchWord);
		
		// 검색어가 없을 때는(null) 검색어를 ""로 변환
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		String order = "";
		switch (category) {
		case "1":
			order = "regDate";
			break;
		case "2":
			order = "ticketopenday";
			break;
		case "3":
			order = "readCount";
			break;
		default:
			break;
		}

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("order", order);


		int totalCount = 0; 		// 총 게시물 건수(totalCount)
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 1;	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다.
		int totalPage = 0;			
		int startRno = 0;			
		int endRno = 0;				

		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalNoticeCount(paraMap);
		
		totalPage = (int) Math.ceil((double)totalCount / sizePerPage);

		// str_currentShowPageNo 가 없다면 초기화면을 보여준다.
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

				if(currentShowPageNo <= 0 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}

			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 


		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

		// == 공지사항목록 보여주기 == //
		noticeList = service.noticeListWithPaging(paraMap);

		// === 페이지바 만들기 === //
		String pageBar = "<ul style='list-style: none;'>";

		int blockSize = 10;

		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

	//	mav.addObject("totalCount", totalCount);

	//	String gobackURL = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~~~ 확인용 gobackURL : " + gobackURL);
	//	mav.addObject("gobackURL", gobackURL);

		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes"); // 조회수증가권한의 값을 yes 로 세션에 저장한다.

		/*
		   session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
		   session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
		      반드시 웹브라우저에서 주소창에 "/list.action" 이라고 입력해야만 얻어올 수 있다. 
		 */

	//	session.setAttribute("gobackURL", gobackURL);

		request.setAttribute("totalPage", totalPage);
	//	System.out.println(totalPage +":totalPage");
		
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
			jsonObj.put("totalCount", totalCount);
			jsonObj.put("totalPage", totalPage);
			jsonObj.put("page", str_currentShowPageNo);

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();
	}
	
	
	// 공지사항 글 1개 보기 페이지로 이동
	@RequestMapping(value = "/noticeView.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public ModelAndView noticeView(ModelAndView mav, HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
	//	String gobackURL = request.getParameter("gobackURL");
	//	mav.addObject("gobackURL", gobackURL);
		
		NoticeVO notivo = null;
		
		HttpSession session = request.getSession();
	
		/*
		// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
		if("yes".equals(session.getAttribute("readCountPermission"))) {
			notivo = service.getNoticeView(seq, userid); 
			// 글 조회수 증가와 함께 글 1개를 조회를 해주는 것
			// 서비스단에서는 글 내용을 select 하는 것과 조회수를 update 하는 것이 동시에 일어나야 한다.

			session.removeAttribute("readCountPermission"); 
			// session 에 저장된 readCountPermission 을 삭제한다.
		}
		else {
			// 웹브라우저에서 새로고침(F5) 을 클릭한 경우이다.
			notivo = service.getNoticeViewWithNoAddCount(seq); 
			// 글 조회수 증가는 없고 단순히 글 1개 조회만을 해주는 것이다. 
		}
		*/
		
		notivo = service.getNoticeViewWithNoAddCount(seq); 
		
		if(notivo == null) {
			// 존재하지 않는 글번호의 글내용을 조회하려는 경우
			String msg = "존재하지 않는 글번호입니다.";
			String loc = "javascript:history.back()";

			mav.addObject("msg", msg);
			mav.addObject("loc", loc);

			mav.setViewName("msg");

		}
		else {
		//	String gobackURL = (String) session.getAttribute("gobackURL");
		//	System.out.println("gobackURL : "+gobackURL);
		//	mav.addObject("gobackURL", gobackURL);
			mav.addObject("notivo", notivo); // 글 1개 boardvo 를 뷰단으로 넘겨준다. 
			mav.setViewName("notice/noticeView.tiles1");
		//	mav.addObject("gobackURL", gobackURL);
		}

		return mav;
	}
	
	
	// qna 글쓰기
	@ResponseBody
	@RequestMapping(value = "/qnaAddClick.action", produces="text/plain;charset=UTF-8")
	public String qnaAddClick(HttpServletRequest request) {
		
		return "안녕하세요, 안안안안".toString(); 
		
	//	mav.setViewName("notice/notice.tiles1");
	//	return mav;
	}
		
	
	// Qna 문의 등록하기
	@RequestMapping(value = "/qnaAdd.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaAdd(HttpServletRequest request, ModelAndView mav) {
		
		String category = request.getParameter("qna-category");
		String product = request.getParameter("qna-product");
		String subject = request.getParameter("qna-title");
		String content = request.getParameter("qna-content");
		String fk_userid = request.getParameter("fk_userid");
		String name = request.getParameter("name");
		String fk_seq = request.getParameter("fk_seq");
		
		
		System.out.println("category : "+category);
		System.out.println("product : "+product);
		System.out.println("subject : "+subject);
		System.out.println("content : "+content);
		System.out.println("fk_userid : "+fk_userid);
		System.out.println("name : "+name);
		System.out.println("fk_seq : "+fk_seq);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("category", category);
		paraMap.put("product", product);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("name", name);
		paraMap.put("fk_seq", fk_seq);
		
		int n = service.qnaAdd(paraMap);
		
		String loc = "javascript:history.back()";

		mav.addObject("loc", loc);

		mav.setViewName("msg");
		
		return mav; 
		
	}
	
	
	
}

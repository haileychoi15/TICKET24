package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.common.MyUtil;
import com.spring.model.FaqVO;
import com.spring.model.MemberVO;
import com.spring.model.NoticeVO;
import com.spring.model.ProdVO;
import com.spring.model.QnaVO;
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
		
	//	System.out.println(category +"category");
	//	System.out.println(searchWord +"searchWord");
	//	System.out.println(str_currentShowPageNo +"page");
		
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
	
	
	// 공지사항 페이지로 이동
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
	
	// 공지사항 목록가져오기
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
		session.setAttribute("readNoticeCountPermission", "yes"); // 조회수증가권한의 값을 yes 로 세션에 저장한다.

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
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		String userid = null; // 로그인을 하면 loginuser 가 있지만, 로그인을 하지않으면 loginuser 는 null 이다.
		if(loginuser != null) {
			userid = loginuser.getUserid();
		}
		
		// 위의 글목록보기 #69. 에서 session.setAttribute("readNoticeCountPermission", "yes"); 해두었다.
		if("yes".equals(session.getAttribute("readNoticeCountPermission"))) {
			notivo = service.getNoticeView(seq, userid); 
			// 글 조회수 증가와 함께 글 1개를 조회를 해주는 것
			// 서비스단에서는 글 내용을 select 하는 것과 조회수를 update 하는 것이 동시에 일어나야 한다.

			session.removeAttribute("readNoticeCountPermission"); 
			// session 에 저장된 readCountPermission 을 삭제한다.
		}
		else {
			// 웹브라우저에서 새로고침(F5) 을 클릭한 경우이다.
			notivo = service.getNoticeViewWithNoAddCount(seq); 
			// 글 조회수 증가는 없고 단순히 글 1개 조회만을 해주는 것이다. 
		}
		
		
	//	notivo = service.getNoticeViewWithNoAddCount(seq); 
		
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
		//	System.out.println(notivo.getContent()+" : content");
		//	mav.addObject("gobackURL", gobackURL);
		}

		return mav;
	}
	
	
	// qna 글쓰기
	@ResponseBody
	@RequestMapping(value = "/qnaAddClick.action", produces="text/plain;charset=UTF-8")
	public String qnaAddClick(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
	//	int idx = loginuser.getIdx();
		String userid = loginuser.getUserid();
		
		// 로그인한 회원의 예매공연목록과 예매공연코드 가져오기
		List<HashMap<String, String>> reserveTitleList = service.reserveTitleList(userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(reserveTitleList != null) {
			for (HashMap<String, String> reserveTitle : reserveTitleList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("prod_title", reserveTitle.get("prod_title"));
				jsonObj.put("prod_id", reserveTitle.get("prod_id"));
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString(); 
	//	return "안녕하세요, 안안안안".toString(); 
		
	//	mav.setViewName("notice/notice.tiles1");
	//	return mav;
	}
		
	
	// Qna 문의 등록하기
	@RequestMapping(value = "/qnaAdd.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaAdd(HttpServletRequest request, ModelAndView mav) {
		
		String category = request.getParameter("qna-category");
		String fk_rev_id = request.getParameter("qna-product");
		String subject = request.getParameter("qna-title");
		String content = request.getParameter("qna-content");
		String fk_userid = request.getParameter("fk_userid");
		String name = request.getParameter("name");
		String fk_seq = request.getParameter("fk_seq");
		
		/*
		System.out.println("category : "+category);
		System.out.println("fk_rev_id : "+fk_rev_id);
		System.out.println("subject : "+subject);
		System.out.println("content : "+content);
		System.out.println("fk_userid : "+fk_userid);
		System.out.println("name : "+name);
		System.out.println("fk_seq : "+fk_seq);*/
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("category", category);
		paraMap.put("fk_rev_id", fk_rev_id);
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
	
	
	// QNA 게시판으로 이동
	@RequestMapping(value = "/qnaListMain.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public ModelAndView qnaListMain(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		if(loginuser == null) {
			String msg = "접근권한이 없습니다.";
			String loc = "javascript:history.back()";

			mav.addObject("msg", msg);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		else {
			if("admin".equals(loginuser.getUserid())) {
				mav.setViewName("qna/qnaList.tiles1");
			}
			else {
				String msg = "접근권한이 없습니다.";
				String loc = "javascript:history.back()";
	
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
	
				mav.setViewName("msg");
			}
		}
		return mav;
	}
	

	// QNA 게시판으로 이동
	@ResponseBody
	@RequestMapping(value="/qnaList.action", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String qnaList(HttpServletRequest request) {

		List<QnaVO> qnaList = null;

		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("page");
		String category = request.getParameter("category");
	//	System.out.println("page : "+str_currentShowPageNo);
	//	System.out.println("searchWord : "+searchWord);
		
	//	if(category == "0") {
		if(category.equals("0")) {
			category = "";
		}
		
		// 검색어가 없을 때는(null) 검색어를 ""로 변환
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		/*
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
		}*/

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("category", category);
	//	paraMap.put("order", order);

		
		int totalCount = 0; 		// 총 게시물 건수(totalCount)
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 1;	// 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다.
		int totalPage = 0;			
		int startRno = 0;			
		int endRno = 0;				

		// 총 qna 건수(totalCount)
		totalCount = service.getTotalQnaCount(paraMap);
		
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

		// == qna 글목록 보여주기 == //
		qnaList = service.qnaList(paraMap); 


		int blockSize = 10;

		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;

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

		for(QnaVO qna : qnaList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("qna_id", qna.getQna_id());
			jsonObj.put("name", qna.getName());
			jsonObj.put("category_id", qna.getCategory());
			jsonObj.put("category", qna.getQna_cate_name());
			jsonObj.put("fk_userid", qna.getFk_userid());
			
			jsonObj.put("subject", qna.getSubject());
			jsonObj.put("content", qna.getContent());
			jsonObj.put("readCount", qna.getReadCount());
			jsonObj.put("status", qna.getStatus());
			jsonObj.put("regDate", qna.getRegDate());
			
			jsonObj.put("secret", qna.getSecret());
			jsonObj.put("adminread", qna.getAdminread());
			jsonObj.put("adminans", qna.getAdminans());
			jsonObj.put("groupno", qna.getGroupno());
			jsonObj.put("fk_seq", qna.getFk_seq());
			jsonObj.put("depthno", qna.getDepthno());
			jsonObj.put("fk_rev_id", qna.getFk_rev_id());
			jsonObj.put("prod_id", qna.getProd_id());
			jsonObj.put("rev_email", qna.getRev_email());
			jsonObj.put("prod_img", qna.getProd_img());
			jsonObj.put("prod_title", qna.getProd_title());
			
			jsonObj.put("totalCount", totalCount);
			jsonObj.put("totalPage", totalPage);
			jsonObj.put("page", str_currentShowPageNo);

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();
	}
	
	
	
	// 문의사항 글 1개 보기 페이지로 이동
	@RequestMapping(value = "/qnaView.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public ModelAndView qnaView(ModelAndView mav, HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
	//	String gobackURL = request.getParameter("gobackURL");
	//	mav.addObject("gobackURL", gobackURL);
		
		QnaVO qnavo = null;
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		String userid = null; // 로그인을 하면 loginuser 가 있지만, 로그인을 하지않으면 loginuser 는 null 이다.
		if(loginuser != null) {
			userid = loginuser.getUserid();
		}
	
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
		
		qnavo = service.getQnaViewWithNoAddCount(seq, userid); 
		
		if(qnavo == null) {
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
			mav.addObject("qnavo", qnavo); // 글 1개 boardvo 를 뷰단으로 넘겨준다. 
			mav.setViewName("qna/qnaView.tiles1");
		//	mav.addObject("gobackURL", gobackURL);
		}

		return mav;
	}
	
	
	// Qna 답변 글쓰기 페이지로 이동
	@RequestMapping(value = "/qnaAddAdmin.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaAddAdmin(HttpServletRequest request, ModelAndView mav, QnaVO qvo) {
		
		String fk_seq = request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		String category = request.getParameter("category");
		
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		mav.addObject("category", category);
		
		mav.setViewName("qna/qnaAddAdmin.tiles1");
		
		return mav; 
	}
	
	// Qna 답변 등록하기
	@RequestMapping(value = "/qnaAddAdminEnd.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public ModelAndView qnaAddAdminEnd(HttpServletRequest request, ModelAndView mav, QnaVO qvo) {
		
		int n = service.qnaAddAdmin(qvo); // Qna 답변 등록하기
		
		String loc = request.getContextPath()+"/qnaListMain.action";

		String msg = "";
		
		if(n==1) {
			msg = "답변이 등록되었습니다.";
		}
		else {
			msg = "답변등록에 실패했습니다.";
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("msg");
		
		return mav; 
	}
	
	
	// 공지글쓰기 페이지로 이동
	@RequestMapping(value = "/noticeAdd.action", produces="text/plain;charset=UTF-8")
	public ModelAndView noticeAdd(HttpServletRequest request, ModelAndView mav) {
		
		mav.setViewName("notice/noticeAdd.tiles1");
		
		return mav; 
	}
	
	// 공지글 등록하기
	@RequestMapping(value = "/noticeAddEnd.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String noticeAddEnd(MultipartHttpServletRequest mrequest, ModelAndView mav, NoticeVO notivo) {		
		
		
		// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지 아니면 파일첨부가 안된 것인지 구분을 지어주어야 한다. === 
		// === !!! 첨부파일이 있는지 없는지 알아오기 시작 !!! === //
		MultipartFile attach = notivo.getAttach();
		
		if( !attach.isEmpty() ) {
			// 첨부파일이 있는 경우라면
			
			/*
				1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
				>>> 파일이 업로드 되어질 특정 경로(폴더) 지정해주기
					우리는  WAS 의 webapp/resources/files 라는 폴더로 지정해준다.
				FileManager 의 path 가 그 경로이다.
			*/
			
			// WAS 의 webapp 의 절대경로를 알아와야 한다.
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			String path = root + "resources" + File.separator + "files" ;

			// 절대경로는 C:\springworkspace\Board\src\main\webapp\resources 이 아니라
			// C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources 이다. 
			
			/*
				2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일올리기
			*/
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용되는 용도
			
			long fileSize = 0; // 파일크기를 읽어오기 위한 용도
			
			try {
				bytes = attach.getBytes();

				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path); // 파일올리기를 해주는 것이다. 
				
				System.out.println(">>>> 확인용 newFileName ==> "+newFileName);
				
				/*
					3. NoticeVO notivo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
				*/
				
				notivo.setFileName(newFileName);
				
				notivo.setOrgFilename(attach.getOriginalFilename()); 
				
				fileSize = attach.getSize();
				notivo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		// 첨부파일이 없다면 그냥 원래대로 진행하면 된다. 
		// === !!! 첨부파일이 있는지 없는지 알아오기 끝 !!! === //
		
		// System.out.println(notivo.getProd_id() +":prod_id");
		
		int n = 0;
		
		if( attach.isEmpty() ) {
			// 첨부파일이 없는 경우라면
			n = service.noticeAdd(notivo); // Qna 답변 등록하기
		}
		else {
			// 첨부파일이 있는 경우라면
			// myBatis 에서 if 를 사용해도 되지만, 뜯어 고치기 귀찮다면 새로 만드는 방법도 있다.
			n = service.noticeAdd_withFile(notivo); // Qna 답변 등록하기(첨부파일 O)
		}
		
		return "notice/notice.tiles1";
		
		/*
		String loc = request.getContextPath()+"/noticeMain.action";

		String msg = "";
		
		if(n==1) {
			msg = "공지글이 등록되었습니다.";
		}
		else {
			msg = "공지등록에 실패했습니다.";
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("msg");
		
		return mav; 
		*/
	}
	
	
	// ===== #159. 첨부파일 다운로드 받기 =====
	@RequestMapping(value="/download.action") 
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq"); 
		// 첨부파일이 있는 글번호
		
		NoticeVO vo = service.getNoticeViewWithNoAddCount(seq); 
		
		String fileName = vo.getFileName(); 
		
		String orgFilename = vo.getOrgFilename(); 
		
		// 첨부파일이 저장되어 있는 
		// WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
		// 이 경로는 우리가 파일첨부를 위해서
		//    /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
		// WAS 의 webapp 의 절대경로를 알아와야 한다. 
		HttpSession session = request.getSession();
		
		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"files";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
		
		// **** 다운로드 하기 **** //
		// 다운로드가 실패할 경우 메시지를 띄워주기 위해서
		// boolean 타입 변수 flag 를 선언한다.
		boolean flag = false;
		
		flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
		// 다운로드가 성공이면 true 를 반납해주고,
		// 다운로드가 실패이면 false 를 반납해준다.
		
		if(!flag) {
			// 다운로드가 실패할 경우 메시지를 띄워준다.
			
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter writer = null;
			
			try {
				writer = response.getWriter();
				// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
			} catch (IOException e) {
				
			}
			
			writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.')</script>");       
			
		}
		 
	} // end of void download(HttpServletRequest req, HttpServletResponse res)---------

	
	// Qna 답변 수정하기 페이지로 이동
	@RequestMapping(value = "/qnaEditAdmin.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaEditAdmin(HttpServletRequest request, ModelAndView mav) {
		
		// 글 수정해야할 글번호 가져오기
		// url 에 담아온 seq 를 request.getParameter 로 받는다.
		String seq = request.getParameter("seq");

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userid = loginuser.getUserid();

		if(loginuser != null && loginuser.getUserid().equals("admin")) {
			// 글 수정해야할 글 1개 내용 가져오기
			// 글 조회수(readCount) 증가 없이 그냥 글 1개만 가져오는 것
			QnaVO qvo = service.getQnaViewWithNoAddCount(seq, userid); 

			mav.addObject("qvo", qvo);
			mav.setViewName("qna/qnaEditAdmin.tiles1");
		}
		else {
			String msg = "다른사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";

			mav.addObject("msg", msg);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		return mav; 
	}
	
	// Qna 답변 수정하기
	@RequestMapping(value = "/qnaEditAdminEnd.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaEditAdminEnd(HttpServletRequest request, ModelAndView mav, QnaVO qvo) {
		
		int n = service.qnaEditAdmin(qvo); // Qna 답변 수정하기
		
		String loc = request.getContextPath()+"/qnaListMain.action";
		String msg = "";
		
		if(n==1) {
			msg = "답변이 수정되었습니다.";
		}
		else {
			msg = "답변수정에 실패했습니다.";
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("msg");
		
		return mav; 
	}
	
	
	// Qna 답변 삭제하기
	@RequestMapping(value = "/qnaDelAdmin.action", produces="text/plain;charset=UTF-8")
	public ModelAndView qnaDelAdmin(HttpServletRequest request, ModelAndView mav) {
		
		String qna_id = request.getParameter("seq");

		int n = service.qnaDelAdmin(qna_id); // Qna 답변 삭제하기
		
		String loc = request.getContextPath()+"/qnaListMain.action";
		String msg = "";
		
		if(n==1) {
			msg = "답변이 삭제되었습니다.";
		}
		else {
			msg = "답변삭제에 실패했습니다.";
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("msg");
		
		return mav; 
	}
	
	
	// 공지수정하기 페이지로 이동
	@RequestMapping(value = "/noticeEdit.action", produces="text/plain;charset=UTF-8")
	public ModelAndView noticeEdit(HttpServletRequest request, ModelAndView mav) {
		
		// 글 수정해야할 글번호 가져오기
		String seq = request.getParameter("seq");

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userid = loginuser.getUserid();

		// 글 수정해야할 글 1개 내용 가져오기
		// 글 조회수(readCount) 증가 없이 그냥 글 1개만 가져오는 것
		NoticeVO notivo = service.getNoticeViewWithNoAddCount(seq); 

		if(loginuser != null && loginuser.getUserid().equals("admin")) {
			mav.addObject("notivo", notivo);
			mav.setViewName("notice/noticeEdit.tiles1");
		}
		else {
			String msg = "공지수정은 관리자만 가능합니다.";
			String loc = "javascript:history.back()";

			mav.addObject("msg", msg);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}
		
		
		return mav; 
	}
	
	
	
	// 공지 수정하기
	@RequestMapping(value = "/noticeEditEnd.action", produces="text/plain;charset=UTF-8")
	public ModelAndView noticeEditEnd(HttpServletRequest request, ModelAndView mav, NoticeVO notivo) {
		
		int n = service.noticeEdit(notivo); // 공지 수정하기
		
		String loc = request.getContextPath()+"/noticeMain.action";
		String msg = "";
		
		if(n==1) {
			msg = "공지글이 수정되었습니다.";
		}
		else {
			msg = "공지글 수정에 실패했습니다.";
		}
		
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);

		mav.setViewName("msg");
		
		return mav; 
	}
	
	
	// 공지 삭제하기
	@RequestMapping(value = "/noticeDel.action", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	public ModelAndView noticeDel(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

		String loc =  "";
		String msg = "";
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
			
			String notice_id = request.getParameter("seq");
			
			int n = service.noticeDel(notice_id); // 공지 삭제하기
			
			loc = request.getContextPath()+"/noticeMain.action";
			msg = "";
			
			if(n==1) {
				msg = "공지글이 삭제되었습니다.";
			}
			else {
				msg = "공지글 삭제에 실패했습니다.";
			}
			
		}
		else {
			msg = "접근권한이 없습니다.";
			loc = "javascript:history.back()";

		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);

		mav.setViewName("msg");
		
		return mav; 
	}
	
	
	// 공연명으로 티켓오픈일자 검색 
	@RequestMapping(value = "/ticketopenSearch.action", produces="text/plain;charset=UTF-8")
	public ModelAndView ticketopenSearch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		
		String prod_title = request.getParameter("prod_title");
		
		// 공연명으로 티켓오픈일자 검색 
		List<ProdVO> ticketList = service.ticketopenSearchList(prod_title);
		
		mav.addObject("ticketList", ticketList);
		mav.setViewName("popup/ticketopen.notiles");
		
		return mav;
		
	}

	
}

package com.spring.finalproject4.aop;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.common.MyUtil;
import com.spring.service.InterMemberService;

@Aspect
@Component
public class FinalProject4AOP {
	
//	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )")
//	public void requiredLogin() {}
//	
//	@Before("requiredLogin()")
//	public void requiredLogin(JoinPoint joinPoint) {
//		
//		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
//		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[0];
//		
//		HttpSession session = request.getSession();
//		
//		if(session.getAttribute("loginuser") == null ) {
//			String msg = "먼저 로그인을 해야 합니다.";
//			String loc = request.getContextPath() + "/login.action";
//			request.setAttribute("msg", msg);
//			request.setAttribute("loc", loc);
//			
//			String url = MyUtil.getCurrentURL(request);
//			
//			if(url.endsWith("?null")) {
//				url = url.substring(0, url.indexOf("?"));
//			}
//			
//			session.setAttribute("gobackURL", url);
//			
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
//			try {
//				dispatcher.forward(request, response);
//			} catch (ServletException | IOException e) {
//				e.printStackTrace();
//			}
//		}
//		
//	}
	
	
	// ===== Before Advice 만들기 ===== //
	
	// == Pointcut 을 생성한다. == 
	//	  Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )")
	public void requiredLogin() { }
	
	// == Before Advice(공통관심사, 보조업무) 를 구현한다. 
	@Before("requiredLogin()")
	public void loginChk(JoinPoint joinPoint) { // 로그인 유무를 검사하는 메소드 작성하기
		
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		// 로그인 유무를 확인하기 위해서는 request 를 통해 session 을 얻어와야 한다.
		
		// args 는 파라미터들을 말한다. 즉, 포인트컷 되어진 주업무 메소드의 파라미터들을 말한다.
		// joinPoint.getArgs()[0]; 이렇게 주업무의 메소드의 첫번째 파라미터를 가져올 때 return type 이 Object 이므로 원래의 타입으로 형변환 해주어야 한다. 
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];	 // 주업무의 메소드의 첫번째 파라미터를 얻어오는 것이다.
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; // 주업무의 메소드의 두번째 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		
		// 로그인을 안했다면
		if(session.getAttribute("loginuser") == null) {
			String msg = "먼저 로그인 하세요~~";
			String loc = request.getContextPath()+"/login.action";
			
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업만들기 <<< //
			// === 현재 페이지의 주소(URL) 알아오기 ===
			String url = MyUtil.getCurrentURL(request);
		//	System.out.println("~~~ 확인용 현재페이지 URL : "+url);
		//	~~~ 확인용 현재페이지 URL : add.action?null
			
			// "문자열".endsWith("찾고자하는문자열")
			// 찾고자하는문자열로 끝나면 true
			// 찾고자하는문자열로 끝나지 않으면 false
			if(url.endsWith("?null")) {
				url = url.substring(0, url.indexOf("?"));
				// 0번째부터 물음표가 나오는 인덱스값 앞까지 자른다.
			}
			System.out.println("~~~ 확인용 현재페이지 URL : "+url);
		//	~~~ 확인용 현재페이지 URL : add.action
			
			// 세션에 url 정보를 저장한다. 
			session.setAttribute("gobackURL", url);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			} 
			
			// 뷰단 페이지로 request 와 reponse 를 보낸다. (request 영역의 저장된 것 까지)
			// 그런데 컨트롤러가 아닌데 뷰단페이지를 쓰고 싶어서 dispatcher 를 사용하고,
			// dispatcher 에 request 영역에 저장된 걸 보내고 싶을 땐, dispatcher.forward(request, response) 를 사용하는데
			// dispatcher.forward 를 사용하려면 request 와 reponse 는 필수이다. 
			// 따라서 주업무에는 reponse 파라미터가 필요하지 않지만, 보조업무에서 dispatcher 를 쓰기 위하여 
			// request 와 더불어 reponse 를 주업무의 파라미터로 사용해야 한다. 
			
			
		}
		
		// 여기는 AOP 이지, 컨트롤러가 아니다. 
		// 컨트롤러 일 때만 뷰단 페이지가 어디인지 쓸 수가 있다.
		// 그런데 컨트롤러가 아니지만 해당 뷰단 페이지로 보내고 싶으므로 dispatcher 를 사용한다. 
		
	}
	
	
	// ===== After Advice 만들기 ===== //
	
	@Autowired
	InterMemberService service; // service 로 보내기 위해 사용한다. 
	
	/*
		주업무(<예: 글쓰기, 글수정, 댓글쓰기 등등>)를 실행하기 앞서서
		이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
		주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는 
		관심클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를
		생성하여 동작하도록 만들겠다.
	*/
	
	// == Pointcut 을 생성한다. == 
	//	  Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring..*Controller.pointPlus_*(..) )")
	public void pointPlus() {}
	
	// == After Advice(공통관심사, 보조업무) 를 구현한다. 
	@SuppressWarnings("unchecked") // 앞으로는 노란줄 경고 표시를 하지말라는 뜻이다.
	@After("pointPlus()")
	public void userPointPlus(JoinPoint joinPoint) {
		// JoinPoint joinPoint 는 포인트컷 되어진 주업무의 메소드이다. 
		
		HashMap<String, String> paraMap = (HashMap<String, String>) joinPoint.getArgs()[0];
		// 주업무의 메소드의 파라미터의 첫번째를 paraMap 으로 만들고,
		// paraMap 에 포인트가 몇점인지, 그리고 어떤것에 대한 것인지의 정보를 담아와서
		// 서비스단에 보내게 될 것이다. 
		
		service.pointPlus(paraMap); // ### 추가 ### // 포인트추가
	}
	
	
}

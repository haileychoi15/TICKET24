package com.spring.finalproject4.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.common.MyUtil;

@Aspect
@Component
public class FinalProject4AOP {
	
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )")
	public void requiredLogin() {}
	
	@Before("requiredLogin()")
	public void requiredLogin(JoinPoint joinPoint) {
		
		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0];
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[0];
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null ) {
			String msg = "먼저 로그인을 해야 합니다.";
			String loc = request.getContextPath() + "/login.action";
			request.setAttribute("msg", msg);
			request.setAttribute("loc", loc);
			
			String url = MyUtil.getCurrentURL(request);
			
			if(url.endsWith("?null")) {
				url = url.substring(0, url.indexOf("?"));
			}
			
			session.setAttribute("gobackURL", url);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		
	}
}

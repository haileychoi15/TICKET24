package com.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.model.MemberVO;
import com.spring.service.InterMemberService;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private InterMemberService service;
	
    // preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
       
    	HttpSession session = request.getSession();

    	MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
        
    	Cookie yes24Cookie = WebUtils.getCookie(request, "yes24Cookie");
    	
    	if(yes24Cookie == null) {
        	
    		yes24Cookie = new Cookie("yes24Cookie", session.getId());
    		yes24Cookie.setPath("/");
    		yes24Cookie.setMaxAge(60*60*24*7); // 7일
    		response.addCookie(yes24Cookie);
    		
    		return true;
    	}
    	
    	
        if ( loginuser == null ){
        	
        	Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        	
        	if(yes24Cookie != null && loginCookie == null) {
                // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
                // 따라서true로하면 컨트롤러 uri로 가게 됨.
                return true;
        	}
        	// yes24Cookie != null && 
        	if(yes24Cookie != null &&  loginCookie != null) {
        		String sessionId = loginCookie.getValue();
        		
        		System.out.println("sessionId : " + sessionId);
        		
        		MemberVO mvo = service.checkUserWithSessionKey(sessionId);

        		if(mvo != null) {
        			session.setAttribute("loginuser", mvo);
        			return true;
        		}
        		
        	}
        	
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            response.sendRedirect("/finalproject4/login.action");
            return false; // 더이상 컨트롤러 요청으로 가지 않도록false로 반환함
        }
         	

        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서true로하면 컨트롤러 uri로 가게 됨.
        return true;
 

    }
 
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }


	
}

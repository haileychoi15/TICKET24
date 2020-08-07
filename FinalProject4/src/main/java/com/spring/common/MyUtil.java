package com.spring.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드)를 작성해주는 메소드 생성 *** // 
	public static String replaceParameter(String param) {
		String result = param;
		
		if(param != null) {
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			// result = result.replaceAll("&", "&amp;");
	        // result = result.replaceAll("\"", "&quot;");
		}
	    
		return result;
	   }
	   
	public static String getCurrentURL(HttpServletRequest request) {
		// *** ? 다음의 데이터까지 포함한 URL 주소를 알아오는 메소드 생성 *** //
		String currentURL =  request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/shop/mallHome.up
		String queryString = request.getQueryString();
		// pnum=3
		currentURL += "?"+queryString;
		
		String ctxPath = request.getContextPath();
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		currentURL = currentURL.substring(beginIndex+1);
		
		return currentURL;
	}
	   
}

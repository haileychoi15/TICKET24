package com.spring.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator  extends Authenticator  {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		// Gmail 인 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("guzi951010","skdla95!"); // 아이디, 비밀번호
		
	}
	
	
}

package com.spring.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.stereotype.Component;

@Component	// bean 으로 올라가 있어야만, DI로 사용가능하므로 @Component 로 bean 으로 올린다. 
public class MySMTPAuthenticator extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		// Gmail 인 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("kimsksk93","qwer1234$");
		
	}
	
}

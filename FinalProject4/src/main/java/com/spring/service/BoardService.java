package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.mail.GoogleMail;
import com.spring.model.FaqVO;
import com.spring.model.InterBoardDAO;
import com.spring.model.NoticeVO;

@Service
public class BoardService implements InterBoardService {

	// === #34. 의존객체 주입하기(DI: Dependency Injection) === 
	@Autowired
	private InterBoardDAO dao;
	// @Autowired 는 이러한 타입의 객체가 root-context.xml 에 bean 으로 이미 올라가 있어야 한다.
	// 그런데 @Component 을 써주면 이러한 객체가 root-context.xml 에 따로 bean 으로 올려줄 필요 없이
	// 첫글자를 소문자로 바꾼채로 객체가 bean 으로 올라가도록 한다. 
	// 그런데 @Repository 만 적어주면 @Component 가 자동적으로 포함되어 있고, DAO 로써, 객체로 올라간다.
	// @Component 를 사용하면 객체로 올라가지만, DAO 로 올라가는 것은 아니다.
	// 그리고 @Service 만 적어주어도 @Component 가 자동적으로 포함되어 있고, Service 로써, 객체로 올라간다.

	
	// Type (SqlSessionTemplate 와 같은) 에 따라 spring 컨테이너가 알아서 root-context.xml 에 생성된 
	// org.mybatis.spring.SqlSessionTemplate 의 Bean 을 dao 에 주입시켜준다. 
	// 그러므로 dao 은 null 이 아니다.

	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스(파라미터가 있는 생성자) 의존객체 주입하기 (DI: Dependency Injection) === //
	@Autowired
	private AES256 aes;
	// @Autowired 를 쓰면 해당 타입의 객체가 bean 으로 이미 올라가 있는 것을 사용한다. 
	
	
	@Autowired	// 의존객체로 사용하기 위해 @Autowired 를 통해 DI 선언한다.
	private GoogleMail mail;

	
	// FAQ 리스트(검색어 있음)
	@Override
	public List<FaqVO> faqList(HashMap<String, String> paraMap) {
		List<FaqVO> faqList = dao.faqList(paraMap);
		return faqList;
	}


	// 총 공지글 개수
	@Override
	public int getTotalNoticeCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalNoticeCount(paraMap);
		return n;
	}

	// 페이징처리한 공지글 리스트
	@Override
	public List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.noticeListWithPaging(paraMap);
		return noticeList;
	}
	
}

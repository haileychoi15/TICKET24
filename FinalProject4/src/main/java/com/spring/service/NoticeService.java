package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.mail.GoogleMail;
import com.spring.model.InterNoticeDAO;

@Service
public class NoticeService implements InterNoticeService {

	@Autowired
	private InterNoticeDAO dao;
	
	@Autowired
	private AES256 aes;
	
	@Autowired
	private GoogleMail mail;

	
}

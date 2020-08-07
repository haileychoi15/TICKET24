package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterPayDAO;

@Service
public class PayService implements InterPayService {

	@Autowired
	private InterPayDAO dao;
	
}

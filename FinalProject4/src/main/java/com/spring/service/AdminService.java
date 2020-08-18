package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterAdminDAO;

@Service
public class AdminService implements InterAdminService {

	@Autowired
	private InterAdminDAO dao;
	
}

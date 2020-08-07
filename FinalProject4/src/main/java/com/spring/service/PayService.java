package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.model.InterPayDAO;
import com.spring.model.ShowVO;

@Service
public class PayService implements InterPayService {

	@Autowired
	private InterPayDAO dao;

	// 예매 시 필요한 공연정보 가져오기
	@Override
	public ShowVO getShowRsvInfo(String showNum) {
		ShowVO showvo = dao.getShowRsvInfo(showNum);
		return showvo;
	}
	
}

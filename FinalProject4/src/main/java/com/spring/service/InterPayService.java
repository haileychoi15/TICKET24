package com.spring.service;

import java.util.List;

import com.spring.model.ShowVO;

public interface InterPayService {

	// 예매 시 필요한 공연 정보
	ShowVO getShowRsvInfo(String showNum);

}

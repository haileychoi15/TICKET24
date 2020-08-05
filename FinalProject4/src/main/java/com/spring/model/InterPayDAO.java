package com.spring.model;

import java.util.List;

public interface InterPayDAO {

	// 예매 시 필요한 공연정보 가져오기
	ShowVO getShowRsvInfo(String showNum);

}

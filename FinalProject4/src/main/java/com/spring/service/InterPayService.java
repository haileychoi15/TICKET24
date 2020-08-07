package com.spring.service;

import java.util.HashMap;

public interface InterPayService {

	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	HashMap<String, String> getShowRsvInfo(String showNum);

}

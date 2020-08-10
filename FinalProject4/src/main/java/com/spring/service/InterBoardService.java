package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.FaqVO;

public interface InterBoardService {

	List<FaqVO> faqList(HashMap<String, String> paraMap);

}

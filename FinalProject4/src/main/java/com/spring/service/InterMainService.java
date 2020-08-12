package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.ProdVO;

public interface InterMainService {

	int getTotalProdCount(HashMap<String, String> paraMap);

	List<ProdVO> prodList(HashMap<String, String> paraMap);

}

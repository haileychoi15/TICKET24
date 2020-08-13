package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterMainDAO {

	int getTotalProdCount(HashMap<String, String> paraMap);
	
	List<ProdVO> prodList(HashMap<String, String> paraMap);

}

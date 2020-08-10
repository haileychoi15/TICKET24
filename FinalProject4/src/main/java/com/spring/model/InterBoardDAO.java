package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterBoardDAO {

	List<HashMap<String, String>> faqList(HashMap<String, String> paraMap);

}

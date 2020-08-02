package com.spring.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository  
public class PayDAO implements InterPayDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
}

package com.spring.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAO implements InterQnaDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
}

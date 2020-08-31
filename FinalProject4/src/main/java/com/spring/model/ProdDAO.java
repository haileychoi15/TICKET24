package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProdDAO implements InterProdDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 상품 상세페이지로 이동
	@Override
	public ProdVO prodDetail(String seq) {
		ProdVO pvo = sqlsession.selectOne("finalproject4.prodDetail", seq);
		return pvo;
	}

	// 상품의 좌석종류정보
	@Override
	public List<HashMap<String, String>> seattypeList(String seq) {
		List<HashMap<String, String>> seattypeList = sqlsession.selectList("finalproject4.seattypeList", seq);
		return seattypeList;
	}

	// 상품의 날짜정보 
	@Override
	public List<HashMap<String, String>> dateList(String seq) {
		 List<HashMap<String, String>> dateList = sqlsession.selectList("finalproject4.dateList", seq);
		return dateList;
	}

	// 선택한 달력의 데이터와 같은 회차정보 불러오기
	@Override
	public List<HashMap<String, String>> showDateList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> showDateList = sqlsession.selectList("finalproject4.showDateList", paraMap);
		return showDateList;
	}

	// 관심상품 등록하기
	@Override
	public int likeProd(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("finalproject4.likeProd", paraMap);
		return n;
	}

	// 관심상품 해제하기
	@Override
	public int dislikeProd(HashMap<String, String> paraMap) {
		int n = sqlsession.delete("finalproject4.dislikeProd", paraMap);
		return n;
	}
	
	// 해당상품의 관심상품 등록수 
	@Override
	public int likeProdCnt(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.likeProdCnt", paraMap);
		return n;
	}
	
	// 같은 아이디의 같은 관심상품이 존재하는지 확인
	@Override
	public int existlike(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.existlike", paraMap);
		return n;
	}

	@Override
	public List<HashMap<String, String>> viewInfoList(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<HashMap<String, String>> remainSeatList(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}

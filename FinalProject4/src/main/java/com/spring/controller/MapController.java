package com.spring.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.model.MemberVO;
import com.spring.service.InterMapService;

@Controller
public class MapController {
	
	@Autowired
	private InterMapService service;
	
	
	// 지도 페이지로 이동
	@RequestMapping(value = "/mapMain.action", produces="text/plain;charset=UTF-8", method = RequestMethod.GET)
	public String mapMain() {
		
		return "prod/map.tiles1";
	}
		
	
	
	// 해당상품의 지도정보 불러오기 페이지로 이동
	@ResponseBody
	@RequestMapping(value = "/mapInfo.action", produces="text/plain;charset=UTF-8")
	public String mapInfo(HttpServletRequest request) {
		
		String prod_id = request.getParameter("prod_id");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("prod_id", prod_id);
		
		/*// 해당상품의 지도정보 불러오기
		List<HashMap<String, String>> mapInfoList = service.mapInfoList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(mapInfoList != null) {
			for (HashMap<String, String> reserveTitle : mapInfoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("prod_id", reserveTitle.get("prod_id"));
				jsonObj.put("map_id", reserveTitle.get("map_id"));
				jsonObj.put("map_name", reserveTitle.get("map_name"));
				jsonObj.put("map_address", reserveTitle.get("map_address"));
				jsonObj.put("local", reserveTitle.get("local"));
				jsonObj.put("map_lng", reserveTitle.get("map_lng"));
				jsonObj.put("map_lat", reserveTitle.get("map_lat"));
				jsonObj.put("map_url", reserveTitle.get("map_url"));
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString(); */
		
		// 해당상품의 지도정보 불러오기
		HashMap<String, String> mapInfo = service.mapInfo(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		if(mapInfo != null) {
			jsonObj.put("prod_id", mapInfo.get("prod_id"));
			jsonObj.put("map_id", mapInfo.get("map_id"));
			jsonObj.put("map_name", mapInfo.get("map_name"));
			jsonObj.put("map_address", mapInfo.get("map_address"));
			jsonObj.put("local", mapInfo.get("local"));
			jsonObj.put("map_lng", mapInfo.get("map_lng"));
			jsonObj.put("map_lat", mapInfo.get("map_lat"));
			jsonObj.put("map_url", mapInfo.get("map_url"));
		}
		
		return jsonObj.toString();
		
	}
	
	
}

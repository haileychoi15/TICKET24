package com.spring.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.ProdVO;
import com.spring.service.InterMainService;

@Component
@Controller
public class MainController {
	
	@Autowired
	private InterMainService service;
	
	// == YES24 메인페이지 == //
	@RequestMapping(value="/yes24.action")
	public ModelAndView index(HttpServletRequest request, ModelAndView mav) {

		String category = request.getParameter("category");
		List<ProdVO> prodList = service.getProdList(category);
		
		if(category == null) {
			
		}
		else {
			switch (category) {
			case "1":
				
				break;
			case "2":
				break;
			case "3":
				break;
			case "4":
				break;
			case "5":
				break;
			case "6":
				break;
			}
		}
		
		mav.addObject("prodList", prodList);
		mav.setViewName("main/main.tiles1");
		return mav;
	}
	
	   
   @RequestMapping(value="/prodMain.action")
   public ModelAndView final_prodMain(ModelAndView mav, HttpServletRequest request) {
      
      List<ProdVO> prodList = null; 

      String searchWord = request.getParameter("searchWord");
      String str_currentShowPageNo = request.getParameter("currentShowPageNo");

      // 검색어가 없을 때는(null) 검색어를 ""로 변환
      if(searchWord == null || searchWord.trim().isEmpty()) {
         searchWord = "";
      }

      HashMap<String, String> paraMap = new HashMap<>();
      paraMap.put("searchWord", searchWord);

      int totalProdCount = 0;    // 총 공연 수(totalProdCount)
      int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 건수 (select 태그로 값을 선택할 수도 있지만, 이번에는 무조건 10개로 고정한다.)
      int currentShowPageNo = 1;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다. (아무것도 주지 않으면 1페이지로 고정이다.)
      int totalPage = 0;         // 총 페이지수(웹브라우저 상에 보여줄 총 페이지 개수, 페이지바)
      int startRno = 0;         // 시작 행번호
      int endRno = 0;            // 끝 행번호

      // 총 공연 수(totalProdCount)는 검색조건이 있을 때와 없을 때로 나뉘어진다.
      // 총 공연 수(totalProdCount)
      totalProdCount = service.getTotalProdCount(paraMap);

      totalPage = (int) Math.ceil((double)totalProdCount / sizePerPage);


      // str_currentShowPageNo 가 없다면 초기화면을 보여준다.
      if(str_currentShowPageNo == null) {
         currentShowPageNo = 1;
      }
      else {
         try {
            currentShowPageNo = Integer.parseInt(str_currentShowPageNo);

            if(currentShowPageNo <= 0 || currentShowPageNo > totalPage) {
               currentShowPageNo = 1;
            }

         } catch (NumberFormatException e) {
            currentShowPageNo = 1;
         }
      }

      /*
           currentShowPageNo      startRno     endRno
          --------------------------------------------
               1 page        ===>    1           10
               2 page        ===>    11          20
               3 page        ===>    21          30
               4 page        ===>    31          40
               ......                ...         ...
       */

      startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
      endRno = startRno + sizePerPage - 1; 


      paraMap.put("startRno", String.valueOf(startRno));
      paraMap.put("endRno", String.valueOf(endRno));


      // == 페이징 처리한 공연목록 보여주기 == //
      prodList = service.prodList(paraMap);
      
      if(!"".equals(searchWord)) {
         mav.addObject("paraMap", paraMap);
      }

      // === #119. 페이지바 만들기 === //
      String pageBar = "<ul style='list-style: none;'>";

      int blockSize = 10;
      // blockSize 는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
      /*
            1  2  3  4  5  6  7  8  9  10   다음   -- 1개 블럭
         이전   11 12 13 14 15 16 17 18 19 20   다음   -- 1개 블럭
         이전   21 22 23
       */

      int loop = 1;
      /* 
         loop 는 1 부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
       */

      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
      
      
      String url = "prodMain.action";

      // === [이전] 만들기 === //
      if(pageNo != 1) { // 맨 처음이 아니라면 [이전]을 보인다. 
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'><i class='fas fa-angle-double-left'></i></a></li>";
      }
      else {
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><i class='fas fa-angle-double-left'></i></a></li>";
      }

      if(currentShowPageNo == 1) {
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo=1'><i class='fas fa-angle-left'></i></a></li>";
      }
      else{
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(currentShowPageNo-1)+"'><i class='fas fa-angle-left'></i></a></li>";
      }

      // 10 개를 넘거나 총 페이지보다 커지면 탈출
      while( !(loop > blockSize || pageNo > totalPage) ) {

         /*
         1  2  3  4  5  6  7  8  9  10
          11 12 13 14 15 16 17 18 19 20
          21 22 23 
          */

         // 현재페이지에서는 링크를 안건다. 
         if(pageNo == currentShowPageNo) {
            pageBar += "<li style='display:inline-block; width:30px; border:solid 1px gray; color:black; padding:2px 4px;'>"+pageNo+"</li>";
         }
         else {
            pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
         }

         loop++;
         pageNo++;
      }

      if(currentShowPageNo >= totalPage) {
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'><i class='fas fa-angle-right'></i></a></li>";
      }
      else{
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(currentShowPageNo+1)+"'><i class='fas fa-angle-right'></i></a></li>";
      }

      // === [다음] 만들기 === //
      if( !(pageNo > totalPage) ) { // 맨 마지막으로 빠져나온게 아니라면 [다음]을 보인다.
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'><i class='fas fa-angle-double-right'></i></a></li>";
      }
      else {
         pageBar += "<li style='display:inline-block; width:30px;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'><i class='fas fa-angle-double-right'></i></a></li>";
      }

      pageBar += "</ul>";


      mav.addObject("pageBar", pageBar);
      mav.addObject("totalProdCount", totalProdCount);


      mav.addObject("prodList", prodList);
      mav.setViewName("final/prodMain.notiles");

      return mav;

   }

}

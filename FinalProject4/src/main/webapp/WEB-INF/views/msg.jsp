<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <script type="text/javascript">
 
 	if(${msg != null}) {
 		alert("${msg}");
 	}
 	
 	if(${loc != null}) {
 		location.href="${loc}";
 	}
 
 	self.close(); // 팝업창이 있으면 팝업창 닫기
	opener.location.reload(true); // 부모창 새로고침
	
 	
</script>
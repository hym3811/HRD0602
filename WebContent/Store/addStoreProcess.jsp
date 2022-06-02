<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String storecode=request.getParameter("storecode");
	String storename=request.getParameter("storename");
	String productcode=request.getParameter("productcode");
	String qty=request.getParameter("qty");
	try{
		sql="insert into store0602 values(?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, storecode);
		pstmt.setString(2, storename);
		pstmt.setString(3, productcode);
		pstmt.setString(4, qty);
		pstmt.executeUpdate();
%>
<script>
alert("매장 정보 등록 성공");
location.href="addStore.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
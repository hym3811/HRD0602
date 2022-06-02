<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String productcode=request.getParameter("productcode");
	String productname=request.getParameter("productname");
	String storecode=request.getParameter("storecode");
	String unitprice=request.getParameter("unitprice");
	String stockqty=request.getParameter("stockqty");
	try{
		sql="insert into product0602 values(?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productcode);
		pstmt.setString(2, productname);
		pstmt.setString(3, storecode);
		pstmt.setString(4, unitprice);
		pstmt.setString(5, stockqty);
		pstmt.executeUpdate();
%>
<script>
alert("상품 테이블 등록 성공");
location.href="addProduct.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
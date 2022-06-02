<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../DBConn.jsp" %>
<%
	String inoutdate=request.getParameter("inoutdate");
	String storecode=request.getParameter("storecode");
	String productcode=request.getParameter("productcode");
	String gubun=request.getParameter("gubun");
	String saleqty=request.getParameter("saleqty");
	System.out.println("inoutdate: "+inoutdate);
	System.out.println("storecode: "+storecode);
	System.out.println("productcode: "+productcode);
	System.out.println("gubun: "+gubun);
	System.out.println("saleqty: "+saleqty);
	try{
		sql="select * from inout0602 where inoutdate=? and storecode=? and productcode=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, inoutdate);
		pstmt.setString(2, storecode);
		pstmt.setString(3, productcode);
		rs=pstmt.executeQuery();
		if(rs.next()){
			System.out.println("체크");
			sql="update inout0602 set gubun=?,saleqty=? where inoutdate=? and storecode=? and productcode=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gubun);
			pstmt.setString(2, saleqty);
			pstmt.setString(3, inoutdate);
			pstmt.setString(4, storecode);
			pstmt.setString(5, productcode);
			pstmt.executeUpdate();
%>
<script>
alert("입출고 정보 수정 성공");
location.href="selectInOutSeparation.jsp";
</script>
<%
		}else{
			sql="insert into inout0602 values(?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, inoutdate);
			pstmt.setString(2, storecode);
			pstmt.setString(3, productcode);
			pstmt.setString(4, gubun);
			pstmt.setString(5, saleqty);
			pstmt.executeUpdate();
%>
<script>
alert("입출고 정보 등록 성공");
location.href="selectInOutSeparation.jsp";
</script>
<%
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
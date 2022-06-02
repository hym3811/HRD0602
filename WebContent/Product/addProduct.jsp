<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function search(){
	document.form.action="addProduct.jsp";
	document.form.submit();
}
function check(){
	var doc=document.form;
	if(doc.productname.value==""){
		alert("[상품명]\n상품명을 입력하세요.");
		doc.productname.focus();
	}else if(doc.storecode.value==""){
		alert("[매장코드]\n매장코드를 입력하세요.");
		doc.storecode.focus();
	}else if(doc.storename.value==""){
		alert("[매장코드]\n매장코드를 입력해 매장명을 조회하세요.");
		doc.storecode.focus();
	}else if(doc.unitprice.value==""){
		alert("[단가]\n단가를 입력하세요.");
		doc.unitprice.focus();
	}else if(doc.unitprice.value<0){
		alert("[단가]\n단가는 양수로 입력하세요.");
		doc.unitprice.focus();
	}else if(doc.stockqty.value=""||doc.stockqty.value==0){
		alert("[재고수량]\n재고수량을 입력하세요.");
		doc.stockqty.focus();
	}else if(doc.stockqty.value<0){
		alert("[재고수량]\n재고수량은 양수로 입력하세요.");
		doc.stockqty.focus();
	}else{
		doc.action="addProductProcess.jsp";
		doc.submit();
	}
}
</script>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<h3 style="font-size:2em; text-align:center;">상품 등록 화면</h3>
		<hr>
		<table border=1>
		<%
			Integer productcode=0;
			String storecode=null;
			String productname=null;
			String unitprice=null;
			String stockqty=null;
			if(request.getParameter("stockqty")!=null){
				stockqty=request.getParameter("stockqty");
			}else{
				stockqty="";
			}
			if(request.getParameter("unitprice")!=null){
				unitprice=request.getParameter("unitprice");
			}else{
				unitprice="";
			}
			if(request.getParameter("productname")!=null){
				productname=request.getParameter("productname");
			}else{
				productname="";
			}
			if(request.getParameter("storecode")!=null){
				storecode=request.getParameter("storecode");
			}else{
				storecode="";
			}
			String storename=null;
			try{
				sql="select max(productcode) from product0602";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()){
					productcode=rs.getInt(1)+1;
				}
				if(storecode!=""){
					sql="select storename from store0602 where storecode=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, storecode);
					rs=pstmt.executeQuery();
					if(rs.next()){
						storename=rs.getString(1);
					}else{
		%>
		<script>alert("잘못된 매장코드입니다.")</script>
		<%
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
			<tr>
				<th>상품 코드(자동생성)</th>
				<td><input type=number name=productcode readonly value="<%=productcode%>"></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><input type=text name=productname value="<%=productname%>"></td>
			</tr>
			<tr>
				<th>매장코드</th>
				<td><input type=number name=storecode onchange=search() value="<%=storecode%>"></td>
			</tr>
			<tr>
				<th>매장명</th>
				<td><input type=text name=storename readonly value="<%=storename==null ? "" : storename%>"></td>
			</tr>
			<tr>
				<th>단가</th>
				<td><input type=number name=unitprice value="<%=unitprice%>"></td>
			</tr>
			<tr>
				<th>재고수량</th>
				<td><input type=number name=stockqty value="<%=stockqty%>"></td>
			</tr>
			<tr>
				<td colspan=2>
					<input type=button value="등록" onclick=check()>
					<input type=button value="취소" onclick=reset()>
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
</html>
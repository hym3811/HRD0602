<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function search(){
	document.form.action="addStore.jsp";
	document.form.submit();
}
function check(){
	var doc=document.form;
	if(doc.storename.value==""){
		alert("[매장명]\n매장명을 입력하세요.");
		doc.storename.focus();
	}else if(doc.productcode.value==""){
		alert("[상품코드]\n상품코드를 입력하세요.");
		doc.productcode.focus();
	}else if(doc.productname.value==""){
		alert("[상품명]\n상품코드를 입력해 매장명을 조회하세요.");
		doc.productcode.focus();
	}else if(doc.qty.value==""){
		alert("[수량]\n단가를 입력하세요.");
		doc.qty.focus();
	}else if(doc.qty.value<0){
		alert("[수량]\n단가는 양수로 입력하세요.");
		doc.qty.focus();
	}else{
		doc.action="addStoreProcess.jsp";
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
		<h3 style="font-size:2em; text-align:center;">매장 등록 화면</h3>
		<hr>
		<table border=1>
		<%
			Integer storecode=0;
			String storename=request.getParameter("storename");
			String productcode=request.getParameter("productcode");
			String productname=request.getParameter("productname");
			String qty=request.getParameter("qty");
			try{
				sql="select hrd0602.nextval from dual";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()){
					storecode=rs.getInt(1);
				}
				sql="select productname from product0602 where productcode=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, productcode);
				rs=pstmt.executeQuery();
				if(productname!=null){
				if(rs.next()){
					productname=rs.getString(1);
				}else{
		%>
		<script>
		alert("잘못된 상품코드입니다.");
		</script>
		<%
				}
				}
				sql="select * from store0602 where storecode=? and productcode=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, storecode);
				pstmt.setString(2, productcode);
				rs=pstmt.executeQuery();
				if(rs.next()){
					storecode=null;
					productcode=null;
		%>
		<script>
		alert("[중복]\n해당 매장코드와 상품코드로 매장정보를 등록할 수 없습니다.");
		</script>
		<%
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
			<tr>
				<th>매장 코드(자동생성)</th>
				<td><input type=number name=storecode readonly value="<%=storecode==null ? "" : storecode%>"></td>
			</tr>
			<tr>
				<th>매장명</th>
				<td><input type=text name=storename value="<%=storename==null ? "" : storename%>"></td>
			</tr>
			<tr>
				<th>상품코드</th>
				<td><input type=number name=productcode onchange=search() value="<%=productcode==null ? "" : productcode%>"></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><input type=text name=productname readonly value="<%=productname==null ? "" : productname%>"></td>
			</tr>
			<tr>
				<th>수량</th>
				<td><input type=number name=qty value="<%=qty==null ? "" : qty%>"></td>
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
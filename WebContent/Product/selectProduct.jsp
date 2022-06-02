<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function add(){
	location.href="addProduct.jsp";
}
</script>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<br>
	<h3>상품 정보 목록</h3>
	<%
		Integer number=0;
		Integer no=0;
		try{
			sql="select count(productcode) from product0602";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<pre>총 <%=number %>개의 상품정보가 있습니다.</pre>
	<hr>
	<table border=1>
		<tr>
			<th>No</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>매장코드</th>
			<th>매장명</th>
			<th>단가</th>
			<th>수량</th>
			<th>관리</th>
		</tr>
	<%
		try{
			DecimalFormat fo=new DecimalFormat("###,###");
			sql="select a.productcode,a.productname,b.storecode,b.storename,a.unitprice,a.stockqty from product0602 a join store0602 b on a.storecode=b.storecode order by a.productcode";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				String productcode=rs.getString(1);
				String productname=rs.getString(2);
				String storecode=rs.getString(3);
				String storename=rs.getString(4);
				Integer unitprice=rs.getInt(5);
				String stockqty=rs.getString(6);
				no++;
	%>
		<tr>
			<td><%=no %></td>
			<td><%=productcode %></td>
			<td><%=productname %></td>
			<td><%=storecode %></td>
			<td><%=storename %></td>
			<td><%=fo.format(unitprice) %></td>
			<td><%=stockqty %></td>
			<td><a href=#>삭제</a></td>
		</tr>
	<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	</table>
	<table style="margin:0 auto;">
		<tr>
			<td>
				<input type=button value="상품 정보 추가" onclick=add()>
			</td>
		</tr>
	</table>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
</html>
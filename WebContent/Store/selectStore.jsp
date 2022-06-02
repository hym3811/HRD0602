<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function add(){
	location.href="addStore.jsp";
}
</script>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<br>
	<h3>상품/매장 정보 목록</h3>
	<%
		Integer number=0;
		Integer no=0;
		try{
			sql="select count(storecode) from store0602";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				number=rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
	<pre>총 <%=number %>개의 매장정보가 있습니다.</pre>
	<hr>
	<table border=1>
		<tr>
			<th>No</th>
			<th>매장코드</th>
			<th>매장명</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>상품수량</th>
			<th>관리</th>
		</tr>
	<%
		try{
			DecimalFormat fo=new DecimalFormat("###,###");
			sql="select a.storecode,a.storename,b.productcode,b.productname,a.qty from store0602 a join product0602 b on a.productcode=b.productcode order by a.storecode";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				String storecode=rs.getString(1);
				String storename=rs.getString(2);
				String productcode=rs.getString(3);
				String productname=rs.getString(4);
				Integer qty=rs.getInt(5);
				no++;
	%>
		<tr>
			<td><%=no %></td>
			<td><%=storecode %></td>
			<td><%=storename %></td>
			<td><%=productcode %></td>
			<td><%=productname %></td>
			<td><%=qty %></td>
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
				<input type=button value="매장정보 추가" onclick=add()>
			</td>
		</tr>
	</table>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
</html>
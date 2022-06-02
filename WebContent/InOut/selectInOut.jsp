<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function add(){
	location.href="addInOut.jsp";
}
</script>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<br>
	<h3>입/출고 정보 목록</h3>
	<hr>
	<table border=1>
		<tr>
			<th>No</th>
			<th>입출고일자</th>
			<th>매장코드</th>
			<th>매장명</th>
			<th>상품코드</th>
			<th>상품명</th>
			<th>입출고 구분</th>
			<th>수량</th>
		</tr>
	<%
		try{
			Integer no=0;
			sql="select a.inoutdate,a.storecode,b.storename,a.productcode,c.productname,a.gubun,a.saleqty from inout0602 a join store0602 b on a.storecode=b.storecode join product0602 c on a.productcode=c.productcode order by inoutdate";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				java.util.Date inoutdate=rs.getDate(1);
				String storecode=rs.getString(2);
				String storename=rs.getString(3);
				String productcode=rs.getString(4);
				String productname=rs.getString(5);
				Integer g=rs.getInt(6);
				String gubun=null;
				switch(g){
				case 1:
					gubun="입고";
					break;
				case 2:
					gubun="출고";
					break;
				}
				Integer saleqty=rs.getInt(7);
				no++;
	%>
		<tr>
			<td><%=no %></td>
			<td><%=inoutdate %></td>
			<td><%=storecode %></td>
			<td><%=storename %></td>
			<td><%=productcode %></td>
			<td><%=productname %></td>
			<td><%=gubun %></td>
			<td><%=saleqty %></td>
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
				<input type=button value="입출고 정보 추가" onclick=add()>
			</td>
		</tr>
	</table>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
</html>
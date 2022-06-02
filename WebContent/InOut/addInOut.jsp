<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function search(){
	if(document.form.inoutdate.value!=""){
		if(document.form.inoutdate.value.length!=8){
			alert("[입출고일자]\n입출고일자는 숫자8자리로 입력하세요.\n예)20220602");
			doc.inoutdate.focus();
		}
	}
	document.form.action="addInOut.jsp";
	document.form.submit();
}
function check(){
	var doc=document.form;
	var rdo=document.getElementsByName("gubun");
	var chk=0;
	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){
			chk++;
		}
	}
	if(doc.inoutdate.value==""){
		alert("[입출고일자]\n입출고일자를 입력하세요.");
		doc.inoutdate.focus();
	}else if(doc.inoutdate.value.length!=8){
		alert("[입출고일자]\n입출고일자는 숫자8자리로 입력하세요.\n예)20220602");
		doc.inoutdate.focus();
	}else if(doc.storecode.value==""){
		alert("[매장코드]\n매장코드를 입력하세요.");
		doc.storecode.focus();
	}else if(doc.storecode.value.length!=3){
		alert("[매장코드]\n매장코드는 숫자3자리입니다.");
		doc.storecode.focus();
	}else if(doc.productcode.value==""){
		alert("[상품코드]\n상품코드를 입려갛세요.");
		doc.productcode.focus();
	}else if(doc.productcode.value.length!=6){
		alert("[상품코드]\n상품코드는 숫자6자리입니다.");
		doc.productcode.focus();
	}else if(chk==0){
		alert("[입출고구분]\n입출고구분을 체크하세요.");
		doc.gubun.focus();
	}else if(doc.saleqty.value==""||doc.saleqty.value==0){
		alert("[입출고수량]\n입출고수량을 입력하세요.");
		doc.saleqty.focus();
	}else{
		doc.action="addInOutProcess.jsp";
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
	<br>
	<h3>입출고 정보 등록</h3>
	<br>
	<table border=1>
	<%
		String inoutdate=request.getParameter("inoutdate");
		String storecode=request.getParameter("storecode");
		String storename=null;
		String productcode=request.getParameter("productcode");
		String productname=null;
		Integer unitprice=0;
		String gubun=null;
		if(request.getParameter("gubun")!=null){
			gubun=request.getParameter("gubun");
		}else{
			gubun="";
		}
		String qty=request.getParameter("saleqty");
		Integer saleqty=null;
		if(qty!=null&&qty!=""){
			saleqty=Integer.parseInt(qty);
		}
		Integer sale=null;
		if(qty!=null&&qty!=""){
			sale=Integer.parseInt(request.getParameter("saleqty"));
		}
		Integer total=0;
		if(inoutdate!=null&&storecode!=null&&productcode!=null){
			try{
				sql="select b.storename,c.productname,c.unitprice,a.gubun,a.saleqty from inout0602 a join store0602 b on a.storecode=b.storecode join product0602 c on a.productcode=c.productcode where a.inoutdate=? and a.storecode=? and a.productcode=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, inoutdate);
				pstmt.setString(2, storecode);
				pstmt.setString(3, productcode);
				rs=pstmt.executeQuery();
				if(rs.next()){
					storename=rs.getString(1);
					productname=rs.getString(2);
					System.out.println(storename);
					System.out.println(productname);
					unitprice=rs.getInt(3);
					gubun=rs.getString(4);
					saleqty=rs.getInt(5);
					total=unitprice*saleqty;
	%>
	<script>
	alert("데이터 조회 성공")
	</script>
	<%
					if(sale!=saleqty&&qty!=null&&qty!=""){
						saleqty=sale;
					}
				}else{
					sql="select storename from store0602 where storecode=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, storecode);
					rs=pstmt.executeQuery();
					if(rs.next()){
						storename=rs.getString(1);
					}else{
						if(storecode!=null&&storecode!=""){
	%>
	<script>
	alert("잘못된 매장코드입니다.");
	</script>
	<%
						}
						storecode=null;
					}
					sql="select productname,unitprice from product0602 where productcode=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, productcode);
					rs=pstmt.executeQuery();
					if(rs.next()){
						productname=rs.getString(1);
						unitprice=rs.getInt(2);
						if(saleqty!=0&&saleqty!=null){
							total=unitprice*saleqty;
						}
						}else{
							if(productcode!=null&&productcode!=""){
	%>
	<script>
	alert("잘못된 상품코드입니다.");
	</script>
	<%
							}
							productcode=null;
							saleqty=null;
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
		<tr>
			<th>입출고일자</th>
			<td colspan=3><input type=text name=inoutdate value="<%=inoutdate==null ? "" : inoutdate%>" onchange=search()></td>
		</tr>
		<tr>
			<th>매장코드</th>
			<td><input type=number name=storecode value="<%=storecode==null ? "" : storecode%>" onchange=search()></td>
			<th>매장명</th>
			<td><input type=text name=storename value="<%=storename==null ? "" : storename%>" readonly></td>
		</tr>
		<tr>
			<th>상품코드</th>
			<td><input type=number name=productcode value="<%=productcode==null ? "" : productcode%>" onchange=search()></td>
			<th>상품명</th>
			<td><input type=text name=productname value="<%=productname==null ? "" : productname%>" readonly></td>
		</tr>
		<tr>
			<th>입출고구분</th>
			<td colspan=3>
				<input type=radio name=gubun value="1" <%=gubun.equals("1") ? "checked" : "" %>>입고
				<input type=radio name=gubun value="2" <%=gubun.equals("2") ? "checked" : "" %>>출고
			</td>
		</tr>
		<tr>
			<th>입출고 수량</th>
			<td><input type=number name=saleqty value="<%=saleqty==null ? "" : saleqty%>" onchange=search()></td>
			<th>입출고 금액</th>
			<td><input type=number name=total value="<%=total==0 ? "" : total%>"></td>
		</tr>
		<tr>
			<td colspan=4>
				<input type=button value="목록" onclick=select()>
				<input type=button value="저장" onclick=check()>
			</td>
		</tr>
	</table>
</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
</html>
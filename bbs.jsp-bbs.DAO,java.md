# bbs.jsp

```jsp
<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<tread>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</tread>
			<tbody>
			<%
				bbsDAO bbsDAO = new bbsDAO();
				ArrayList<bbs> list = bbsDAO.getList(pageNumber);
				for(int i=0; i < list.size(); i++) {
			%>
				<tr>
					<td><%= list.get(i).getBbsID() %></td>
					<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></a></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			if(pageNumber != 1){
		%>
			<a href ="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
		<%
			} if(bbsDAO.nextPage(pageNumber +1)) {
		%>
			<a href ="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
		<%
			}
		%>
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	</div>
</div>
```

**table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"**
table-striped는 bootstrap class의 일종으로 홀수 짝수를 나눠 색상이 변경되게 하는 table이다

**thead** 는 테이블의 가장 윗줄 칼럼들의 제목
**tr** 은 테이블의 한 줄 (즉 한 행)
```jsp
<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
```
href=write.jsp를 통해 버튼을 클릭했을때 write.jsp로 넘어가도록 설정
**btn-primary**는 파란색으로 구성된 버튼을 뜻함(bootstrap)
**pull-right**는 오른쪽 정력이다 하지만 bootstrap4 버전 부터는 **float-right**로 변경되었다.

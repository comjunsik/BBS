# bbs.jsp
게시판 메인 화면 디자인
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

---

# write.jsp
게시판 글쓰기 부분

```jsp
<div class="container">
      <div class="row">
         <form method="post" action="writeAction.jsp"><!-- action 바꿔야함 -->
            <table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td><input type="text" class="form-control" placeholder="글 제목" name="" maxlength="50"></td>
                  </tr>
                  <tr>
                     <td><textarea class="form-control" placeholder="글 내용" name="" maxlength="2048" style="height: 350px;"></textarea></td>
                  </tr>
               </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
         </form>
      </div>
   </div>
```
```jsp
<input type="text" class="form-control" placeholder="글 제목" name="" maxlength="50"></td>
```
**class="form-control"**
![form_control1](https://user-images.githubusercontent.com/41488792/46293804-71073500-c5cf-11e8-91f0-f5f7ba720adb.PNG)

![form_control2](https://user-images.githubusercontent.com/41488792/46293922-9dbb4c80-c5cf-11e8-8b39-1c7b6bc28506.PNG)

**input** 을 통해 writeAction.jsp로 입력 내용이 넘어가도록 하게 한다
**textArea** 상대적으로 긴 문자열을 입력할때 사용한다.

```jsp
<form method="post" action="index.jsp">
<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
         </form>
```
>**type="submit"** 은 폼의 전송 기능을 담당한다.
type="reset" 폼 작성 내용을 초기화하는데 사용한다.
type="button" 흔히 자바스크립트를 이용한 기능 구현에 많이 사용한다.
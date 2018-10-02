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
>**type="submit"** 은 폼의 전송 기능을 담당한다.<br>
type="reset" 폼 작성 내용을 초기화하는데 사용한다.<br>
type="button" 흔히 자바스크립트를 이용한 기능 구현에 많이 사용한다.

---
# bbsDAO.java
게시판 데이터 접근 객체
```java
public String getDate() {
		String SQL = "SELECT NOW()";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
```
실시간 시간정보를 받아노는 함수
**String SQL = "SELECT NOW()";** 
실시간 시간정보를 받아오는 mysql 문장
**PreparedStatement pstmt = conn.prepareStatement(SQL);**
 pstmt를 전역 객체로 선언하게 되면 여러 함수 안에서 충돌이 일어날 수 있기 때문에 각각의 함수 안에서 선언 해주도록 한다.
**rs = pstmt.executeQuery();** mysql문을 실행 했을때 나오는 결과를 가져오도록 한다.

```java
public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
```
**String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";**
bbsID를 desc로 내림차순으로 정렬하여 가장 마지막에 생성된 bbsID를 가져오도록 한다.
```java 
if (rs.next()) {
	return rs.getInt(1)+1;
}
return 1;
```
만약에 다음이 있으면 즉 다른 bbsID가 생성 되었다면 그값에 +1을 하여 그 다음 게시물 ID라고 저장해준다.
만약 다음이 없다면 처음 이기 때문에 return 1을 해준다.

```java
public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //게시물 id 또는 번호
			pstmt.setString(2, bbsTitle); //글 제목
			pstmt.setString(3, userID); 
			pstmt.setString(4, getDate()); //작성 시간
			pstmt.setString(5, bbsContent); //작성 내용
			pstmt.setInt(6,1);  //available=1 로 값을 주어 삭제되지 않은 게시물이라는 것을 표시
			
	
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
```
String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";
다섯개의 칼럼에 전부 데이터가 들어가도록 sql문을 작성
**pstmt.setInt(1, getNext());**
첫번째 칼럼에는 bbsID가 들어가므로 getNext()함수의 결과값을 인자로 넣어준다.
return -1;
INSERT문 같은 경우는 성공적으로 수행 했을때 0이상의 값을 반환한다.

---

# writeAction.jsp
게시글 작성 기능
```jsp
<%@ page import="bbs.bbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UtF-8"); %>
<jsp:useBean id="bbs" class="bbs.bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
```
자바빈즈를 이용해 bbs 인스턴스 생성
**class="bbs.bbs"**
bbs패키지의 bbs.java파일
**name="bbs"**
name은 id와 같게

```jsp
if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		
		else{
		bbsDAO bbsDAO = new bbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기 실패.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	}
```
**if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null )**
만약 제목가 내용을 입력 안했을경우...
```jsp
else{
	bbsDAO bbsDAO = new bbsDAO();
		int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
```
bbsDAO에 대한 객체 생성해 write()함수를 호출 한다.
파라미터 값으로는 자바빈즈로 생성해준 인스턴스 bbs를 통해 bbs.java에 들어있는 정보를 가져와 넘겨준다.



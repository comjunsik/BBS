# bbsDAO.java

게시물 수정
```java
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3,bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
```
**String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";**
해당 bbsID의 제목과 내용을 update하라.
```java
pstmt.setString(1, bbsTitle);
pstmt.setString(2, bbsContent);
pstmt.setInt(3,bbsID);
```
setString과 setInt를 통하여 sql문장의 해당 "?"에 값을 삽입하여 준다.
**pstmt.executeUpdate();**
삽입, 삭제, 수정의 경우 executeUpdate()를 해준다. 반환값은 실행된 레코드 수로 int형이다.
예를 들어 두개의 레코드를 수정하게 되면 return 값은 int 2 이다.

---

# update.jsp
게시물 수정 페이지

```jsp
bbs bbs = new bbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
```
**bbs bbs = new bbsDAO().getBbs(bbsID);**
매개변수로 넘어온 bbsID를 통해 게시물에 대한 모든 정보를 bbs 인스턴스에 저장한다.

```jsp
<div class="container">
	<div class="row">
		<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글수정 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent()%></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary pull-right" value="수정">
		</form>
		
	</div>
</div>
```
```jsp
<td><input type="text" class="form-control" placeholder="글제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
```
**value="<%= bbs.getBbsTitle() %>"**
bbs.getBbsTitle()를 함으로써 자신이 이전에 썻던 게시물 제목을 보여준다.
bbs.getBbsContent()도 마찬가지.

---
```jsp
if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else {
		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") ||request.getParameter("bbsTitle").equals("") ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		
		else{
		bbsDAO bbsDAO = new bbsDAO();
		int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글수정 실패.')");
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
```jsp
if (!userID.equals(bbs.getUserID())) {
}else {
	if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") ||request.getParameter("bbsTitle").equals("") ){
        }else{
		bbsDAO bbsDAO = new bbsDAO();
		int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
		if (result == -1){
        }
```
권한이 있는 사용자(작성자)일 경우
**request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null**
을 통해 파라미터로 넘어온 bbsTitle와 bbsContent를 비교해 준다.

**GET과 POST의 차이점**
![get post](https://user-images.githubusercontent.com/41488792/46366310-ae45f280-c6b5-11e8-8d71-03257515584c.PNG)
[출처:https://blog.outsider.ne.kr/312]

**엄청난 착각을 하고 있었다!!**
update.jsp에서는 bbsID를 GET방식으로 전송하고
bbsTitle과 bbsContent는 POST방식으로 전송을 한다.

그래서 나는
```jsp
int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
```
이부분에서 POST로 전송 했으니 당연히 자바빈즈로 받아 bbs.java의 인스턴스로 bbs.getBbsTitle()로 해야 하는 줄 알았는데
from을 이용해 POST로 전송한 데이터도 request.getParameter()를 통해 받을수 있던 것이다!
그래서 update.jsp에서 수정한 제목부분과 내용부분을 매개변수로 받아 bbsDAO.update()메서드의 파라미터로 넘겨 주는 것.

그럼 왜 자바빈즈를 사용하는 것일까ㅠ?
![default](https://user-images.githubusercontent.com/41488792/46367022-8e173300-c6b7-11e8-918b-05b9574ec9c4.PNG)
[출처:http://egloos.zum.com/shoutrock/v/3570675]

로직의 분리와, 재사용성 때문이다..

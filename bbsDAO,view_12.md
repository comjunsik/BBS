# bbsDAO.java
글내용 불러오는 함수

```java
public bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
```

public bbs getBbs(int bbsID)
반환값을 bbs 객체로, 파라미터를 bbsID로 받아온다.

```java
String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
```
bbsID에 따라 해당 게시물의 모든 정보를 반환받는다.
**pstmt.setInt(1, bbsID);**
setInt를 통해 sql문의 '?'에 게시물 번호(아이디)를 넣어준다.
**return bbs;**
bbs에 대한 정보를 리턴 해준다. 만약 해당 bbsID가 없을 시 null을 반환하여 준다.

---
# view.jsp
게시판 내용 출력

```jsp
<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글.')");
		script.println("history.back()");
		script.println("</script>");
	}
	bbs bbs = new bbsDAO().getBbs(bbsID);
	%>
```

bbsID 넘겨받기
```jsp
if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
```
매개변수로 넘어온 bbsID가 존재한다면 int형으로 변환하여 bbsID에 저장

>**중요**
**bbs bbs = new bbsDAO().getBbs(bbsID);**
매개변수로 넘어온 bbsID를 이용하여 bbsDAO().getBbs()메서드를 호출하여 해당 게시물에 대한 모든 정보를 bbs 인스턴스에 넣어준다!!


수정, 삭제 버튼
```jsp
<a href="bbs.jsp" class="btn btn-primary">목록</a>
		<%
			if(userID != null && userID.equals(bbs.getUserID())) {
		%>
			<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
		<%
			}
		%>
```
```jsp
if(userID != null && userID.equals(bbs.getUserID())) 
```
만약 userID가 글을 작성한 사람과 동일하다면,
```jsp
<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
```
GET방식으로 bbsID(userID)를 넘겨주며 페이지 이동하여 update.jsp와 deleteAction.jsp에서 bbsID를 이용하여 bbsDAO().getBbs(bbsID) 메스드를 호출한다.
이에따라 해당 게시물에 대한 모든 정보를 바다올 수 있게 된다.

```jsp
<tr>
	<td>내용</td>
	<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;")%>
    </td>
</tr>
```
>.replaceAll()메서드를 통해 특수문자들을 html상의 문법으로 대체해서 화면상에 보여지도록 한다.
" " ->&nbsp
"<" ->&lt
">" ->&gt
"\n" -><br&gt;

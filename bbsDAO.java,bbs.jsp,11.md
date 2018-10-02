# bbsDAO.java


**게시물 List 반환 함수**
```java
public ArrayList<bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<bbs> list = new ArrayList<bbs>();
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				bbs bbs = new bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	
	}
```

>**ArrayList**
Java 언어에서는 순차 리스트를 구현한 ArrayList 클래스를 제공하고 있습니다. ArrayList는 내부 저장소가 배열처럼 연속적인 메모리 형태입니다. 그리고 저장소의 크기를 변화할 수 있다는 특징이 있습니다.(가변 크기)

ArrayList를 반환값으로 가지는 메서드를 생성하여 List를 가져오도록 한다

**String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";**

WHERE BBSid <? 를 통하여 **특정 값** 보다 작은 것들ㅇ르 가져 오도록 한다 또한
AND bbsAvailable =1 을 통해 bbsAvailable 값이 1인 즉, 삭제 되지 않은 게시물만 가져오도록 명령문을 설정 해준다.
또한 ORDER BY bbsID DESC를 통해 bbsID로 내림차순한 결과에서 data를 가져오도록 한다.
LIMT 10을 통해 date를 10개씩 가져온다.

**ArrayList(bbs) list = new ArrayList(bbs)();**
bbs.java 클래스의 ArrayList 인스턴스를 생성

![statement](https://user-images.githubusercontent.com/41488792/46348219-382b9680-c689-11e8-9495-54224f257643.PNG)


**pstmt.setInt(1, getNext() - (pageNumber -1)x10);**

PreparedStatement.setInt() 넘겨 주는 인자 값이 int형일때 사용 만약 String 타입이면 setStrng()을 사용하면 된다.<br>
.setInt(위치, 값)
위치에는 해당하는 sql문의 '?'의 위치를 나타낸다.
현재 사용하는 sql 문에서는 첫번째'?'에 '값'을 삽입하겠다는 뜻이다.
**getNext() - (pageNumber -1)x10**
한페이지에 보여주는 게시물의 숫자가 10개만 보여지도록 하기위해서
예를 들어 11개의 게시물이 있다면 1페이지에는 1번 게시물 하나만 존재하고
2번 게시물에는 2~11까지의 게시물이 존재
-->비효율적이니 바꿔주는게 좋을 듯


**rs = pstmt.executeQuery();**
SELECT 문을 사용했기 때문에 .executeQuery() 사용 반환 값은 ResultSet이다.

SELECT * FROM 했기 때문에 BBS 테이블의 모든 칼럼 값을 반환받아 오기 때문에 모든 칼럼에 대한 값을 넣어 준다.

**list.add(bbs);**
ArrayList.add() 메서드를 사용하여 bbs 인스턴스를 list에 넣어주도록 한다. add를 통해 게시물 정보가 배열에 차례로 쌓이게 된다.


**페이징 처리 함수**
```java
public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1";
		try { 
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		
	}
```

return true;
다음 페이지가 존재한다면 true리턴
return false;
다음 페이지가 없다면 즉 1페이지만 있다면 false 리턴

---
# bbs.jsp

```jsp
<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber =1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
```
웹 환경은 http 프로토콜 위에서 통작한다.
클라이언트가 http 요청을 보낼 때, 파라미터(parameter)를 함께 끼워 보낼 수 있는데, 이때 해당 요청의 파라미터 값을 얻기 위해 사용하는 것이
request.getParamter() 메서드이다.

넘어온 파라미터 값이 있다면,
pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
의 Integer.parseInt()를 통해
넘어온 파라미터 값을 int 타입으로 변환 하여 준다.

**게시판 게시물 보여주기, 이전, 다음페이지 버튼**
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
					<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
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
```jsp
<%
				bbsDAO bbsDAO = new bbsDAO();
				ArrayList<bbs> list = bbsDAO.getList(pageNumber);
				for(int i=0; i < list.size(); i++) {
			%>
```
bbsDAO.java에 대한 인스턴스 생성후 .getList(pageNumber) 메서드 함수 호출하여 게시판 내용에 대한 ArrayList 값을 받아 온다.
list.size()를 통하여 ArrayList에 들어가있는 정보 만큼 반복하여 화면에 뿌려주도록 한다.
.getList()메서드의 반환형이 ArrayList(bbs)이고 반환값이 bbs.java클래스의 객체 정보가 들어있는 list이기 때문에 bbs.java 클래스 객체에 대한 정보를 가져올 수 있다.

```jsp
<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle()%></a></td>
```
제목을 클릭 했을때 href="view.jsp"를 통해 view.jsp로 이동하게 된다.
또한 이동시 **GET 방식**으로 bbsID에 대한 정보를 넘겨준다.

```jsp
<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
```
날짜에 대한 정보는 .substring()메서드를 사용함으로써 보기 좋게 잘라서 보여준다.
index 0_11이 년-월-일
      11~_3이 시
      14_16이 분

```jsp
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
```
```jsp
if(bbsDAO.nextPage(pageNumber +1)) {
		%>
			<a href ="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
		<%
			}
		%>
```
만약 다음 페이지가 있다면
즉, bbsDAO.nextPage()메서드를 이용하여 다음페이지가 있다는 것을 알 시(파라미터로 pageNumber+1을 하여 다음 페이지가 있는지를 확인)
**GET 방식**으로 
href ="bbs.jsp?pageNumber=<%=pageNumber +1%>
pageNumber에 1을 더한 값을 넘겨준다

**btn-success**
초록색 버튼
**btn-arraw**
화살표 버튼

```jsp
<head>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
		}
</style>
</head>
```
style type="text/css"를 통해 css를 통해 현재 페이지 에서만 작동한느 css를 성정해 준다.

**a,** 모든 a 태그들에 대하여
>a:link 방문 전 링크 상태
a:visited 방문 후 링크 상태
a:hover 마우스 오버했을 때 링크 상태
a:active 클릭했을 때 링크 상태

text-decoration: none; 밑줄 없애준다.

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
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

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style>
gray{
	color:gray;
}
red{
	color:red;
}

.jb-th-1{
	width: 70px;
}


@media (min-width: 400px) {
  .container {
    width: 400px;
  }
}

/*사실 이 블럭은 없어도 된다*/
@media (min-width: 550px) {
  .container {
    width: 500px;
  }
}

@media (min-width: 700px) {
  .container {
    width: 650px;
  }
}

@media (min-width: 850px) {
  .container {
    width: 700px;
  }
}
</style>

<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
					
			</ul>
			<ul class="nav navbar-nav navbar-right">
        		 <li class="dropdown">
         		  <a href="#" class="dropdown-toggle" 
          			  data-toggle="dropdown" role="button" aria-haspopup="true" 
           			  aria-expanded="false">접속하기 <span class="caret"></span></a>
      		<ul class="dropdown-menu">
      		        <li class="active"><a href="login.jsp">로그인</a></li>
             		<li><a href="join.jsp">회원가입</a></li>
            </ul>    
         		</li>
       		</ul>

		</div>
	</nav>
	<%int x=10; %>
<div class="container">
	<div class="jumbotron" style="padding-top: 30px;">
		<div class="row">
			<p style="margin-left:40px"><h4><나의 졸업 현황></h4></p>
			
				<table class="table table-bordered">
					  <thead>
					    <tr>
					      <th class="jb-th-1"scope="col">#  </th>
					      <th scope="col">1학기</th>
					      <th scope="col">2학기</th>				      
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">1학년</th>
					      <td><gray>C프로그래밍I, C프로그래밍실습I, 공업수학I, 과정지도1</gray></td>
					      <td><gray>C프로그래밍II, C프로그래밍실습II, 공업수학II, 과정지도2</gray></td>
					    </tr>
					    <tr>
					      <th scope="row">2학년</th>
					      <td><red>자료구조</red><gray>, C++프로그래밍, 논리회로설계, 데이터통신, 과정지도3</gray></td>
					      <td><gray>윈도우즈프로그래밍, 신호및시스템, 컴퓨터구조, 컴퓨터네트워크, 과정지도4</gray></td>
					    </tr>
					    <tr>
					      <th scope="row">3학년</th>
					      <td><gray>컴퓨터그래픽스, 과정지도5</gray></td>
					      <td><red>운영체제, 과정지도</red></td>
					    </tr>
					    <tr>
					      <th scope="row">4학년</th>
					      <td><red>게임프로그래밍프로젝트, 네트워크시스템프로젝트, 졸업지도1</red></td>
					      <td><red>컴퓨터그래픽스프로젝트, 멀티미디어프로젝트, 졸업지도2</red></td>
					    </tr>
					  </tbody>
				</table>
			
			
			<div class="col-lg-4 ml-5">
			<p style="margin-left:5px">교양</p>
			<div class="progress">
  			<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+Integer.toString(x)+"%");%>>
  				20%
  			</div>
			</div></div>

			<div class="col-lg-4 pt-5">
			<p style="margin-left:5px">전공</p>
			<div class="progress">
	  		<div class="progress-bar progress-bar-warning progress-bar-striped active" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
	  			40%
	  		</div>
			</div></div>
			
			<div class="col-lg-4" >
			<p style="margin-left:5px">졸업 현황</p>
			<div class="progress">
  			<div class="progress-bar progress-bar-dangers progress-bar-striped active" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
  				60%
  			</div>
			</div></div>
		</div>
	</div>
</div>


</body>
</html>
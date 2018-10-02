# custom.css
```css
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(http://fonts.googleapis.com/earlyaccess/hanna.css);
* {
	font-family : 'Nanum Gothic' ;	
}
h1 {
	font-family : 'Hanna';
}
```
구글어피스에서 제공하는 나눔고딕과 한나체 적용
![fontfamily](https://user-images.githubusercontent.com/41488792/46370741-6a58ea80-c6c1-11e8-810c-f917956ea3e0.PNG)

![fontfamily2](https://user-images.githubusercontent.com/41488792/46370760-79d83380-c6c1-11e8-9347-6cb4d15c69d8.PNG)

# main.jsp

```jsp
<head>
<link rel="stylesheet" href = "css/custom.css">
</head>
```
stylesheet 참조 문구를 head안에 넣어준다


<br>
<br>

```jsp
<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousle-inner">
				<div class="item active">
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chhevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chhevron-right"></span>
			</a>
		</div>
	</div>
```
class="carousel"은
부트스트랩에서 제공하는 회전목마와 같이 순환하는 슬라이드 쇼(이미지 또는 텍스트 슬라이드)를 구성하는 컴포넌트.

&lt;ol> 이란
![ol](https://user-images.githubusercontent.com/41488792/46371349-13541500-c6c3-11e8-92bd-82f9b541d627.PNG)

```jsp
<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
```
class="active"를 통해 처음 실행되는 사진임을 알린다
data-slide-to="0"
이것은 index
data-target는 id랑 동일해야 한다.

```jsp
<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
```
class="left carouse-control" 왼쪽으로 이동 
data-slide="prev"이전으로
glyphicon-chevron-left
&lt; 아이콘
http://bootstrapk.com/components/
부트스트랩 아이콘 class들과 그림

**span과 div**
&lt;span>은 **문자열**을 원하는 부분만 선택해서 시각적 효과를 줄 수 있다.
![span1](https://user-images.githubusercontent.com/41488792/46372640-b2c6d700-c6c6-11e8-8c2c-22e9e92004fd.PNG)
<br>
![span2](https://user-images.githubusercontent.com/41488792/46372664-c2deb680-c6c6-11e8-9cab-043aaa39504f.PNG)
<br>
<br>
&lt;div>는 **하나 이상의 요소(태그)**를 묶어서 스타일을 지정할 때 사용합니다.<br>
![div1](https://user-images.githubusercontent.com/41488792/46372800-1cdf7c00-c6c7-11e8-8b23-0e1e34963953.PNG)
![div2](https://user-images.githubusercontent.com/41488792/46372825-2963d480-c6c7-11e8-8e25-53a0940c42f2.PNG)
[출처:http://aboooks.tistory.com/63?category=516604]

끗!

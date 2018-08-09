<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- bootstrap css&meta  -->
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link rel="stylesheet" href="src/bootstrap/css/bootstrap.css">
<!-- css -->
<link rel="stylesheet" href="src/css/myCarouselCss.css">
<link rel="stylesheet" href="src/css/teamCss.css">

<!-- script  -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<title>miniProject</title>
</head>
<body>
	<jsp:include page="topNav.jsp" flush="false"/>
	<div style="margin-top: -20px;"></div>
	
	
<!-- Carousel 부분 -->
<div id="myCarousel" class="carousel slide" data-interval="false">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="item active">
      <img src="https://static.pexels.com/photos/21787/pexels-photo.jpg" style="width:100%" class="img-responsive">
      <div class="container">
        <div class="caraous-title text-center">
            <div class="col-md-12">
                <span>Refresh your LIFE</span>
                    <h1><span>TRAVEL</span> GO ON A TRIP</h1>
                    <h3>Stay with Locals and Meet Travelers</h3>
                    <a class="btn btn-lg btn-primary site-btn" href="#">Learn More</a>
                    <a class="btn btn-lg btn-primary site-btn2" href="#">Learn More</a>
               
                
            </div>
        
        </div>
      </div>
    </div>
    <div class="item">
      <img src="https://images.pexels.com/photos/458917/pexels-photo-458917.jpeg?w=940&h=650&auto=compress&cs=tinysrgb" class="img-responsive">
      <div class="container">
        <div class="caraous-title text-center">
            <div class="col-md-12">
                <span>Refresh your LIFE</span>
                    <h1><span>TRAVEL</span> GO ON A TRIP</h1>
                    <h3>Stay with Locals and Meet Travelers</h3>
                    <a class="btn btn-lg btn-primary site-btn" href="#">Learn More</a>
                    <a class="btn btn-lg btn-primary site-btn2" href="#">Learn More</a>
               
                
            </div>
        
        </div>
      </div>
    </div>
    <div class="item">
      <img src="https://images.pexels.com/photos/130879/pexels-photo-130879.jpeg?w=940&h=650&auto=compress&cs=tinysrgb" class="img-responsive">
      <div class="container">
        <div class="caraous-title text-center">
            <div class="col-md-12">
                <span>Refresh your LIFE</span>
                    <h1><span>TRAVEL</span> TRAVEL CHANGES EVERYTHING</h1>
                    <h3>Stay with Locals and Meet Travelers</h3>
                    <a class="btn btn-lg btn-primary site-btn" href="#">Learn More</a>
                    <a class="btn btn-lg btn-primary site-btn2" href="#">Learn More</a>
               
                
            </div>
        
        </div>
      </div>
    </div>
  </div>
  <!-- Controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="icon-prev"></span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="icon-next"></span>
  </a>  
</div>



<div class="container">

      <div class="blog-header">
        <h1 class="blog-title">Our Team</h1>
        <p class="lead blog-description">The BitCamp 501 - UI/UX기반의 자바개발자 양성과정</p>
      </div>

      	<div class="row">
		<div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/men1.png">
		    <div class="team-content">    
		        <h3>이종현</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		 
		    </div>
		</div>
	</div>
	    <div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/men4.png">
		    <div class="team-content">    
		        <h3>신범근</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		    
		    </div>
		</div>
	</div>
	    <div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/girl3.png" style="width: 360px; height: 360px;">
		    <div class="team-content">    
		        <h3>조혜진</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		    
		    </div>
		</div>
	</div>
	    
</div>

<div class="row">
		<div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/men6.png">
		    <div class="team-content">    
		        <h3>홍진원</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		 
		    </div>
		</div>
	</div>
	    <div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/girl1.png">
		    <div class="team-content">    
		        <h3>성채빈</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		    
		    </div>
		</div>
	</div>
	    <div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/men5.png" style="width: 360px; height: 360px;">
		    <div class="team-content">    
		        <h3>송현수</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		    
		    </div>
		</div>
	</div>
	    
</div>

<div class="row">
		<div class="col-md-4 team-box">
		    <div class="team-img thumbnail">
		        <img src="src/img/men3.png">
		    <div class="team-content">    
		        <h3>이영제</h3>
		        <div class="border-team"></div>
		        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis egestas rhoncus. Donec facilisis fermentum sem, ac viverra ante luctus vel. Donec vel mauris quam.</p>
		 
		    </div>
		</div>
	</div>
	    
</div>


    </div><!-- /.container -->
    
    
    <jsp:include page="footer.jsp" flush="false"/>
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="src/bootstrap/js/bootstrap.js"></script>
</body>
</html>
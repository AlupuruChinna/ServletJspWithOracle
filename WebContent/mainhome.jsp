<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<title>User Home Page</title>

<style>
	header {
    background-color: transparent;
    padding: 20px;
    text-align: center;
    font-size: 35px;
    color: white;
}
article {
    float: left;
    padding: auto;
   // width: auto;
    background-color: inherit;
    height: auto; /* only for demonstration, should be removed */
    margin-left: 29px;
    color: white;
    
}

body {
    font-family: Arial, Helvetica, sans-serif;
    height: 90%;
    width: 100%;
    margin-right: 1cm;
    
}


.cuadro_intro_hover{
        padding: 0px;
		position: relative;
		overflow: hidden;
		height: 200px;
	}
	.cuadro_intro_hover:hover .caption{
		opacity: 1;
		transform: translateY(-150px);
		-webkit-transform:translateY(-150px);
		-moz-transform:translateY(-150px);
		-ms-transform:translateY(-150px);
		-o-transform:translateY(-150px);
	}
	.cuadro_intro_hover img{
		z-index: 4;
	}
	.cuadro_intro_hover .caption{
		position: absolute;
		top:150px;
		-webkit-transition:all 0.3s ease-in-out;
		-moz-transition:all 0.3s ease-in-out;
		-o-transition:all 0.3s ease-in-out;
		-ms-transition:all 0.3s ease-in-out;
		transition:all 0.3s ease-in-out;
		width: 100%;
	}
	.cuadro_intro_hover .blur{
		background-color: rgba(0,0,0,0.7);
		height: 300px;
		z-index: 5;
		position: absolute;
		width: 100%;
	}
	.cuadro_intro_hover .caption-text{
		z-index: 10;
		color: #fff;
		position: absolute;
		height: 300px;
		text-align: center;
		top:-20px;
		width: 100%;
	}
</style>

</head>

<body>

<%session.getAttribute("name");
	System.out.print(session.getAttribute("name"));%>
<div>
<header>
	<iframe name="topframe" src="loginpage.jsp" width="1300" height="200" frameborder="0"  class="frame-area" scrolling="no" >
	</iframe>
</header>
	<article>
		<iframe name="leftframe" src="" width="176" height="420"scrolling="no" frameborder="0">
		
	</iframe>
	</article>
		<iframe name="rightframe" width="82%" height="420" class="frame-area" align="left" scrolling="auto" frameborder="0">
	</iframe>


<hr>

        <footer>
            <div class="row">
                <div class="col-lg-12">
    			<div class="col-lg-3 col-md-6">
                <div class="container">
	
   
    	<div class="col-lg-3">
    				<div class="cuadro_intro_hover " style="background-color:#cccccc;">
						<p style="text-align:center; margin-top:20px;">
							<img src=" " class="img-responsive" alt="Verinon">
						</p>
						<div class="caption">
							<div class="blur"></div>
							<div class="caption-text">
								<h3 style="border-top:2px solid white; border-bottom:2px solid white; padding:10px;">FOLLOW</h3>
								<p>Follow for projects and more information...</p>
								<a class=" btn btn-default" href="#"><span class="glyphicon glyphicon-plus"> INFO</span></a>
							</div>
						</div>
					</div>
				
	    </div>
       <div class="col-lg-3">
    				<div class="cuadro_intro_hover " style="background-color:#cccccc;">
						<p style="text-align:center; margin-top:20px;">
							<img src=" " class="img-responsive" alt="verinon">
						</p>
						<div class="caption">
							<div class="blur"></div>
							<div class="caption-text">
								<h3 style="border-top:2px solid white; border-bottom:2px solid white; padding:10px;">JOIN US</h3>
								<p>Send mail and join with us .....</p>
								<a class=" btn btn-default" href="#"><span class="glyphicon glyphicon-plus"> INFO</span></a>
							</div>
						</div>
					</div>
				
	    </div>
            

            <div class="col-lg-3 col-md-6">
			<h3>Categories:</h3>
                <ul>
				<li><a href=""><i class="fa fa-file"></i> News</a></li>
				<li><a href=""><i class="fa fa-android"></i> Android</a></li>
				<li><a href=""><i class="fa fa-code"></i> C#</a></li>
				<li><a href=""><i class="fa fa-code"></i> Java</a></li>
				<li><a href=""><i class="fa fa-book"></i> Books</a></li>
				<li><a href=""><i class="fa fa-globe"></i> Web</a></li>
				<li><a href=""><i class="fa fa-windows"></i> Windows</a></li>
				</ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h3>Contact:</h3>
				<p>Have a question or feedback? Contact me!</p>
				<p><a href="contactus" title="Contact me!"><i class="fa fa-envelope"></i> Contact</a></p>
            <h3>Follow:</h3>
			
			
<a href="#" id="gh" target="_blank" title="Twitter"><span class="fa-stack fa-lg">
  <i class="fa fa-square-o fa-stack-2x"></i>
  <i class="fa fa-twitter fa-stack-1x"></i>
</span>
Twitter</a>
<a href="#"  target="_blank" title="GitHub"><span class="fa-stack fa-lg">
  <i class="fa fa-square-o fa-stack-2x"></i>
  <i class="fa fa-github fa-stack-1x"></i>
</span>
GitHub</a>

		


		
			
			</div>
			<br/>
            <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/hu_HU/sdk.js#xfbml=1&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like" data-href="" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>

<a href="https://twitter.com/share" class="twitter-share-button" data-url="">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>

<div class="g-plusone" data-annotation="inline" data-width="300" data-href=""></div>

Follow on Google plus for more updates.........
<script type="text/javascript">
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/platform.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
			<br/>
			
				<hr>
                    <p>Copyright © Verinon TechnologySolution | <a href="#">Privacy Policy</a> | <a href="#">Terms of Use</a></p>
					
					
					
        </footer>
</div>
</body>
</html>
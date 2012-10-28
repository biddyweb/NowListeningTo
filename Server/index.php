<?php include('db.php'); ?>

<!DOCTYPE html>
<html>
  <head>
    <title>#NLTApp</title>
    <!-- Bootstrap -->
    <link href="libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Responsive stuff from Bootstrap -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="libs/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        
  </head>
  <body>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="libs/bootstrap/js/bootstrap.min.js"></script>
    
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">#NLTApp</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">Home</a></li>
              <li><a href="#about">About</a></li>
              <li><a href="#contact">Contact</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">
    	<div class="row">
    		<div class="span12">
	    		<table class="table">
	    			<tbody>
	    				<?php
	    					$timelineArray = getTimeline();
	    					
	    					foreach($timelineArray as $item){
		    					$rowString = sprintf("<tr><td><b>%s</b> listened to '%s' by '%s'</td></tr>", $item['username'], $item['song'], $item['artist']);
		    					echo $rowString;
	    					}
	    				?>
	    			</tbody>
		    	</table>
    		</div>
    	</div>
    </div> <!-- /container -->

  </body>
</html>
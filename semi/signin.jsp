<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>GroundBnB</title>

<link href="css/bootstrap.min.css" rel="stylesheet">

<link href="css/signin.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">

<script src="js/ie-emulation-modes-warning.js"></script>

</head>

<body>

	<script>
		window.fbAsyncInit = function() {
			FB.init({
				appId : '1663112637341773',
				status : true,
				cookie : true,
				xfbml : true
			});

			FB.getLoginStatus(function(response) {
				if (response.status === 'connected') {

					FB.api('/me', function(user) {
						if (user) {
							var image = document.getElementById('image');
							image.src = 'http://graph.facebook.com/' + user.id + '/picture';
							var name = document.getElementById('name');
							name.innerHTML = user.name
							var id = document.getElementById('id');
							id.innerHTML = user.id

							console.log(user.id, user.name);

							var URL = "/semiProject01/login/login?name=" + user.name + "&email=" + user.id + "&fb=Y";
							location.replace(URL);
						}
					});

				} else if (response.status === 'not_authorized') {

				} else {

				}
			});

			FB.Event.subscribe('auth.login', function(response) {
				document.location.reload();
				//var URL = "/semiProject01/main?name="+name +"&year=" + year
			});

			FB.Event.subscribe('auth.logout', function(response) {
				document.location.reload();
			});
		};
		(function(d) {
			var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			ref.parentNode.insertBefore(js, ref);
		}(document));
	</script>

	<div class="container">

		<form class="form-signin" action="/semiProject01/login/login" method="post">
			<h2 class="form-signin-heading">Sign in to GroundBnB</h2>
			<label for="inputEmail" class="sr-only">Email address</label> <input type="email" name="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus> <label for="inputPassword" class="sr-only">Password</label> 
			<input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
			<div class="checkbox"></div>
			<button class="btn btn-lg btn-success btn-block" type="submit">Sign in</button>
			<a class="btn btn-lg btn-primary btn-block" href="/semiProject01/signUpForm">Sign up</a>
			<br>
			<div class="fb-login-button" data-max-rows="2" data-size="xlarge" data-show-faces="false" data-auto-logout-link="true"></div>
			<br>
		</form>
		<div align="left" style="display: hidden">
			<img id="image" />
			<div id="name"></div>
			<div id="id"></div>
		</div>

	</div>


	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

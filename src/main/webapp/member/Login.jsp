<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Login</title>
<style>
.title {
            color: #333333;
            margin-bottom: 20px;
            font-size: 4rem;
            font-weight: bold;
            text-align: center; 
        }
</style>
</head>
<body>

<div class="container py-4">
   <jsp:include page="/home.jsp" />

 <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="title">MY MEMORY</h1>
              
      </div>
    </div>
	
	

	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
			%>
  			<form class="form-signin" action="Login_process.jsp" method="post">
  
    			<div class="form-floating mb-3 row">     
      				<input type="text" class="form-control" name='id' id="floatingInput" placeholder="ID" required autofocus>
      				<label for="floatingInput">ID</label>      
    			</div>
    			<div class="form-floating  mb-3 row">     
     	 			<input type="password" class="form-control" name='password' placeholder="Password">
    				 <label for="floatingPassword">Password</label>
			</div>

   
  				
   				<div class="d-flex justify-content-center">
							<a href="./SignUp.jsp" class="btn btn-secondary me-2"
								style="width: 100px;">SIGN UP</a>
							<button class="btn btn-secondary" type="submit"
								style="width: 100px;">LOGIN</button>
						</div>
  			</form>

		</div>
	</div>

		   <jsp:include page="/Brand.jsp" />  
  </div>	
  </body>			
	
</html>
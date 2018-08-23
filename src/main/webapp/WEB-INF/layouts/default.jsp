<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<title><tiles:insertAttribute name="title" /></title>

<!-- Context Root Definition -->
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<c:url var="search" value="/search" />

<!-- Bootstrap -->
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet">
<link href="${contextRoot}/css/recbuddy.css" rel="stylesheet">

<!-- This is only for JavaScript tagging -->
<link href="${contextRoot}/css/jquery.tagit.css" rel="stylesheet">
<script src="${contextRoot}/js/jquery-ui.min.js"></script>
<script src="${contextRoot}/js/tag-it.min.js"></script>


<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->


</head>
<body>
	<nav class="navbar navbar-inverse navbar-static-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${contextRoot}/">Recbuddy</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="active"><a href="${contextRoot}/">Home</a></li>
				<li><a href="${contextRoot}/about">About</a></li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
			
				<sec:authorize access="!isAuthenticated()">
					<li><a href="${contextRoot}/login">Login</a></li>
					<li><a href="${contextRoot}/register">Register</a></li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<li><a href="${contextRoot}/profile">Profile</a></li>
					<li><a href="javascript:$('#logoutForm').submit();">Logout</a></li>
				</sec:authorize>
				
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Status <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${contextRoot}/addstatus">Add Status</a>
							<li><a href="${contextRoot}/viewstatus">View Status Updates</a>
						</ul>
					</li>
				</sec:authorize>
			</ul>
			<form action="${search}" method="post" class="navbar-form navbar-right">
				<input type="hidden" name="${ _csrf.parameterName}" value="${_csrf.token}">
		        <div class="input-group">
		        	<input type="text" class="form-control" name="s" placeholder="Search interests">
		        	<span class="input-group-btn">
		        		<button id="search-button" class="btn btn-success" type="submit">
		        			Find People
		        		</button>
		        	</span>
		        </div>
		    </form>
		</div>
		<!--/.nav-collapse -->
	</div>
	</nav>
	
	<c:url var="logoutLink" value="/logout" />
	<form id="logoutForm" method="post" action="${logoutLink}">
		<input type="hidden" name="${ _csrf.parameterName}" value="${_csrf.token}">
	</form>
	
	<c:if test="${not empty flashMessage}">
		<div class="alert alert-${flashKind} alert-dismissable" id="floating_alert">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  ${flashMessage}
		</div>
	</c:if>
	
	<div class="container">
		<tiles:insertAttribute name="content" />
	</div>

	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="${contextRoot}/js/bootstrap.min.js"></script>
</body>
</html>
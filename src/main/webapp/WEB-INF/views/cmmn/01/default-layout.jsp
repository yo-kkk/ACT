<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
  <meta name="author" content="Creative Tim">
  <title>Argon Dashboard - Free Dashboard for Bootstrap 4</title>
  <!-- Favicon -->
  <link href="${app}/assets/img/brand/favicon.png" rel="icon" type="image/png">
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <!-- Icons -->
  <link href="${app}/assets/vendor/nucleo/css/nucleo.css" rel="stylesheet">
  <link href="${app}/assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
  <!-- Argon CSS -->
  <link type="text/css" href="${app}/assets/css/argon.css?v=1.0.0" rel="stylesheet">
  <!-- Jquery -->
  <script type="text/javascript" src="${app}/webjars/jquery/3.4.1/jquery.js"></script>
  
  <!-- Argon Scripts -->
  <!-- Core -->
  <script src="${app}/assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="${app}/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Optional JS -->
  <script src="${app}/assets/vendor/chart.js/dist/Chart.min.js"></script>
  <script src="${app}/assets/vendor/chart.js/dist/Chart.extension.js"></script>
  <!-- Argon JS -->
  <script src="${app}/assets/js/argon.js?v=1.0.0"></script>
</head>

<body>
	<!-- left side part -->
	<tiles:insertAttribute name="left-menu" />
	
	 <!-- top menu part -->
	<div class="main-content">	
	<tiles:insertAttribute name="top-menu" />
	
	<!-- content header part -->
	<tiles:insertAttribute name="content-header" />
    
	<!-- content part -->
	<tiles:insertAttribute name="content" />
	
	<!-- footer part -->
	<tiles:insertAttribute name="footer" />
     </div>

  
</body>

</html>
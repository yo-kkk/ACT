<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<!-- Page content -->
   <div class="container-fluid mt--7">
  <div class="row">
    <div class="col">
      <div class="card shadow" style="width: 70%; margin-left: 15%; margin-top: 60px;" >
		<div class="card-header border-0" style="height : 560px;" >
     		
     		<div class="container">
  			<div class="row">
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/emp/empList/1/?keyword='">
      			
      			<div style="margin-top: 90px;">
      				<h2>직원 목록</h2>
      				<i class="ni ni-user-run" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/product/1/?keyword='">
      			<div style="margin-top: 90px">
      				<h2>제품 목록</h2>
      				<i class="ni ni-briefcase-24" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/goal/goalList/1/?store=&when='">
      			<div style="margin-top: 90px">
      				<h2>월별 목표/내역</h2>
      				<i class="ni ni-sound-wave" style="size: 200%;"></i>
    			</div>
    		</div>	
  			</div>
  			
  			<div class="row" style="margin-top: 40px;">
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/product/stockAndOrder'">
      			
      			<div style="margin-top: 90px;">
      				<h2>발주하기</h2>
      				<i class="ni ni-cart" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/factory/1/'">
      			<div style="margin-top: 90px">
      				<h2>제조사 관리</h2>
      				<i class="ni ni-istanbul" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/head/events/1/'">
      			<div style="margin-top: 90px">
      				<h2>이벤트 관리</h2>
      				<i class="ni ni-notification-70" style="size: 200%;"></i>
    			</div>
    		</div>	
  			</div>
  			
  			
			</div>
     		
     		
     		
		</div>
	  </div>
	</div>
  </div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<!-- Page content -->
<div class="container-fluid mt--7">
  <div class="row">
    <div class="col">
      <div class="card shadow" style="width: 80%; margin-left: 10%; margin-top: 60px;" >
		<div class="card-header border-0" style="height : 560px;" >
     		
     		<div class="container">
  			<div class="row">
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/emp/empList/1/?keyword='">
      			
      			<div style="margin-top: 90px;">
      				<h2>직원 목록</h2>
      				<i class="ni ni-user-run" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/commute/1/'">
      			<div style="margin-top: 90px">
      				<h2>직원 출퇴근 관리</h2>
      				<i class="ni ni-watch-time" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/stock/1/?keyword='">
      			<div style="margin-top: 90px">
      				<h2>재고확인/발주</h2>
      				<i class="ni ni-box-2" style="size: 200%;"></i>
    			</div>
    		</div>
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/order/1/?keyword='">
      			
      			<div style="margin-top: 90px;">
      				<h2>발주 내역</h2>
      				<i class="ni ni-delivery-fast" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    			
  			</div>
  			
  			<div class="row" style="margin-top: 40px;">
  			
  			<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/daily_total/1/?when='">
      			<div style="margin-top: 90px">
      				<h2>일 매출 조회</h2>
      				<i class="ni ni-time-alarm" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/transact_list/1/?when='">
      			
      			<div style="margin-top: 90px;">
      				<h2>거래 내역 조회</h2>
      				<i class="ni ni-sound-wave" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/salary/pastSalaryList/1/?when='">
      			<div style="margin-top: 90px">
      				<h2>월급 내역 조회</h2>
      				<i class="ni ni-satisfied" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 240px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/store/eventList/1/'">
      			<div style="margin-top: 90px">
      				<h2>이벤트 조회</h2>
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
    
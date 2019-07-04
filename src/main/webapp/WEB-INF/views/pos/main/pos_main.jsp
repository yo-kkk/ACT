<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<!-- Page content -->
<div class="container-fluid mt--7">
  <div class="row">
    <div class="col">
      <div class="card shadow" style="width: 80%; margin-left: 10%; margin-top: 60px;" >
		<div class="card-header border-0" style="height : 360px;" >
     		
     		<div class="container">
  			<div class="row">
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 320px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/pos/transact/'">
      			
      			<div style="margin-top: 120px;">
      				<h2>거래</h2>
      				<i class="ni ni-shop" style="size: 200%;"></i>
    			</div>
    			
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 320px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/pos/refund/1/'">
      			<div style="margin-top: 120px">
      				<h2>거래내역(환불)</h2>
      				<i class="ni ni-chart-bar-32" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 320px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/pos/stock/1/?keyword='">
      			<div style="margin-top: 120px">
      				<h2>재고조회</h2>
      				<i class="ni ni-ungroup" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		<div class="col-sm" style="text-align: center; border: 0.5px solid; height: 320px; margin-right: 20px; cursor:pointer" onclick="location.href ='${app}/pos/closing/1/'">
      			<div style="margin-top: 120px">
      				<h2>오늘 결산하기</h2>
      				<i class="ni ni-time-alarm" style="size: 200%;"></i>
    			</div>
    		</div>
    		
    		
  			</div>
			</div>
     		
     		
     		
		</div>
	  </div>
	</div>
  </div>
</div>
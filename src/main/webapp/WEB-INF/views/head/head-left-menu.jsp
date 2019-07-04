<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

 <nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
    <div class="container-fluid">
      <!-- Toggler -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- Brand -->
      <a class="navbar-brand" href="${app}/Intro/">
      	<img src="${app}/assets/img/brand/logo.png" />
      </a>
      <!-- User -->
      <ul class="nav align-items-center d-md-none">
        <li class="nav-item dropdown">
          <a class="nav-link nav-link-icon" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="ni ni-bell-55"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right" aria-labelledby="navbar-default_dropdown_1">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <div class="media align-items-center">
              <span class="avatar avatar-sm rounded-circle">
                <img alt="Image placeholder" src="${app}/assets/img/theme/team-1-800x800.jpg">
              </span>
            </div>
          </a>
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
            <div class=" dropdown-header noti-title">
              <h6 class="text-overflow m-0">Welcome!</h6>
            </div>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-single-02"></i>
              <span>My profile</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-settings-gear-65"></i>
              <span>Settings</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-calendar-grid-58"></i>
              <span>Activity</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-support-16"></i>
              <span>Support</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="#!" class="dropdown-item">
              <i class="ni ni-user-run"></i>
              <span>Logout</span>
            </a>
          </div>
        </li>
      </ul>
      <!-- Collapse -->
      <div class="collapse navbar-collapse" id="sidenav-collapse-main">
        <!-- Collapse header -->
        <div class="navbar-collapse-header d-md-none">
          <div class="row">
            <div class="col-6 collapse-brand">
              <a href="./index.html">
                <img src="${app}/assets/img/brand/blue.png">
              </a>
            </div>
            <div class="col-6 collapse-close">
              <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
                <span></span>
                <span></span>
              </button>
            </div>
          </div>
        </div>
        <!-- Form -->
        <form class="mt-4 mb-3 d-md-none">
          <div class="input-group input-group-rounded input-group-merge">
            <input type="search" class="form-control form-control-rounded form-control-prepended" placeholder="Search" aria-label="Search">
            <div class="input-group-prepend">
              <div class="input-group-text">
                <span class="fa fa-search"></span>
              </div>
            </div>
          </div>
        </form>
        <!-- Navigation -->
       <ul class="navbar-nav">  
	     <li class="nav-item btn-outline-info" id="accordion01" role="tablist" aria-multiselectable="true">
	        <a class="nav-link" data-toggle="collapse" data-parent="#accordion01" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
	             <i class="ni ni-bold-down text-yellow"></i>직원 관리            
	        </a>
		 </li>
		    <div style="margin-left: 25px;" id="collapseOne" class="panel-collapse collapse in " role="tabpanel" aria-labelledby="headingOne">
					  <li class="nav-item btn-outline-info" >
			            <a class="nav-link" href="/act/head/emp/empList/1/?keyword=">
			              <i class="ni ni-single-02 text-yellow"></i>직원 목록
			            </a>
			          </li>
			          <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/emp/empInsert">
			              <i class="ni ni-fat-add text-yellow"></i>직원 등록
			            </a>
			          </li>
			          <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/salary/">
			              <i class="ni ni-money-coins text-yellow"></i>월급 관리
			            </a>
			          </li>
		  	</div>
	    </ul>	
	    <ul class="navbar-nav">  
	     <li class="nav-item btn-outline-info" id="accordion03" role="tablist" aria-multiselectable="true">
	        <a class="nav-link" data-toggle="collapse" data-parent="#accordion03" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
	             <i class="ni ni-bold-down text-blue"></i>제품 관리            
	        </a>
		 </li>
		    <div style="margin-left: 25px;"  id="collapseThree" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
					  <li class="nav-item btn-outline-info">
				         <a class="nav-link" href="/act/head/product/1/?keyword=">
				          <i class="ni ni-tv-2 text-primary"></i>제품 목록
			            </a>
			          </li>               
			          <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/product/productInsert">
			              <i class="ni ni-curved-next text-primary"></i>제품 등록
			            </a>
			          </li>
		  	</div>
	    </ul>             
	    <ul class="navbar-nav">  
	     <li class="nav-item btn-outline-info" id="accordion04" role="tablist" aria-multiselectable="true">
	        <a class="nav-link" data-toggle="collapse" data-parent="#accordion04" href="#collapse4th" aria-expanded="true" aria-controls="collapse4th">
	             <i class="ni ni-bold-down text-green"></i>매출/목표         
	        </a>
		 </li>
		    <div style="margin-left: 25px;" id="collapse4th" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
					  <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/goal/goalList/1/?store=&when=">
			              <i class="ni ni-trophy text-green"></i>월별 목표&매출 내역
			 		 	 </a>
			 		  </li>		   		  
			          <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/goal/montlyGoal">
			              <i class="ni ni-paper-diploma text-green"></i>월 목표 등록
			            </a>
			          </li>
			             <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/daily/1/?store=&when=">
			              <i class="ni ni-calendar-grid-58 text-green"></i>일 매출 관리
			            </a>
			          </li>         
			          <li class="nav-item btn-outline-info">
			            <a class="nav-link" href="/act/head/transact_view/1/?store=&when=">
			              <i class="ni ni-chart-bar-32 text-green"></i>거래 내역 조회
			            </a>
			          </li>
		  	</div>
	    </ul>     
           
     <ul class="navbar-nav">  
     <li class="nav-item btn-outline-info" id="accordion02" role="tablist" aria-multiselectable="true">
        <a class="nav-link" data-toggle="collapse" data-parent="#accordion02" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
             <i class="ni ni-bold-down text-orange"></i>재고/발주/수주            
        </a>
	 </li>
	    <div style="margin-left: 25px;"  id="collapseTwo" class="panel-collapse collapse in " role="tabpanel" aria-labelledby="headingOne">
				 <li class="nav-item btn-outline-info">
		            <a class="nav-link" href="/act/head/product/stockAndOrder">
		              <i class="ni ni-delivery-fast text-orange"></i>제품 발주
		            </a>
		         </li>
	 			 <li class="nav-item btn-outline-info">
		            <a class="nav-link" href="/act/head/order/toFactory/1/?keyword=">
		              <i class="ni ni-istanbul text-orange"></i>본사 → 제조사 발주 LIST
		            </a>
	             </li>
	             <li class="nav-item btn-outline-info">
		            <a class="nav-link" href="/act/head/order/fromStore/1/?keyword=">
		              <i class="ni ni-shop text-orange"></i>본사 ← 지점 수주 LIST
		            </a>
	          	</li>
	  	</div>
	    </ul>
	    
	    <hr class="my-3">
	    
	    <ul class="navbar-nav">
	    <li class="nav-item btn-outline-info">
            <a class="nav-link" href="/act/head/factory/1/">
              <i class="ni ni-building text-info"></i>제조사 관리
            </a>
        </li>
        </ul>
        
        <ul class="navbar-nav">                  
          <li class="nav-item btn-outline-info">
            <a class="nav-link" href="/act/head/events/1/">
              <i class="ni ni-bell-55 text-danger"></i> 이벤트 관리
            </a>
          </li>
        </ul> 

        <!-- Divider -->
        
        <!-- Heading -->        
        <!-- Navigation -->               
      </div>
    </div>
  </nav>
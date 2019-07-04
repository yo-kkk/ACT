<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/emp/commuteInsert/">
              <i class="ni ni-single-02 text-yellow"></i> 직원 등록
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/emp/empList/1/?keyword=">
              <i class="ni ni-single-02 text-yellow"></i> 직원 목록
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/commute/1/">
              <i class="ni ni-bus-front-12 text-primary"></i>직원 출퇴근 관리
            </a>
          </li>

          <li class="nav-item">
            <a class="nav-link" href="${app}/store/stock/1/?keyword=">
              <i class="ni ni-bullet-list-67 text-info"></i> 재고확인 및 발주
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/order/1/?keyword=">
              <i class="ni ni-cart text-danger"></i>발주 내역
            </a>
          </li>
          </ul>
          
          <hr class="my-3">
        
          <ul class="navbar-nav">
          
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/daily_total/1/?when=">
              <i class="ni ni-chart-bar-32 text-success"></i>일 매출 조회
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/transact_list/1/?when=">
              <i class="ni ni-laptop text-info"></i>거래내역 조회
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/salary/">
              <i class="ni ni-money-coins text-default"></i>월급 주기
            </a>
          </li>
         <li class="nav-item">
             <a class="nav-link" href="${app}/store/salary/pastSalaryList/1/?when=">
              <i class="ni ni-money-coins text-default"></i>월급내역 조회
            </a>
          </li>
          
        
        <!-- Divider -->
        
          <li class="nav-item">
            <a class="nav-link" href="${app}/store/eventList/1/">
              <i class="ni ni-bell-55 text-orange"></i> 이벤트 내역 조회
            </a>
          </li>        
        </ul>
        
        <!-- Heading -->
        <!-- Navigation -->
        </ul>
      </div>
    </div>
  </nav>
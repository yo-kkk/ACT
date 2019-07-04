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
            <a class="nav-link" href="${app}/pos/transact/">
              <i class="ni ni-tv-2 text-primary"></i> 구매
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${app}/pos/refund/1/">
              <i class="ni ni-scissors text-orange"></i> 거래내역 (환불)
            </a>
          </li>          
          <li class="nav-item">
            <a class="nav-link" href="${app}/pos/stock/1/?keyword=">
               <i class="ni ni-bullet-list-67 text-success"></i> 재고조회
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${app}/pos/closing/1/">
              <i class="ni ni-key-25 text-pink"></i> 오늘의 결산
            </a>
          </li>
          
        </ul>
        <!-- Divider -->
        
        <!-- Heading -->
        <hr class="my-3">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="${app}/pos/curr_event/">
              <i class="ni ni-bell-55 text-info"></i> 진행중인 이벤트
            </a>
          </li>
        
        </ul>
        
        
        
        
        
        <!-- Navigation -->
        
      </div>
    </div>
  </nav>    
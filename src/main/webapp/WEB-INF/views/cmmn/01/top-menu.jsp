<%@page import="com.project.act.models_dto.EmployeeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% EmployeeDTO empDTO = ( (EmployeeDTO)session.getAttribute("userInfo") );
   String name = empDTO.getName();
   String store_name = empDTO.getStoreDTO().getStore_name();%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysdate"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set> 

 <!-- Top navbar -->
    <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
      <div class="container-fluid">
        <h2 style="color: white; margin-left: 40px; margin-top: 25px; line-height: 40px;">
        	<%=name%> 님 오늘도 잘 부탁드립니다 ! <br/>
        	${sysdate} [<%=store_name%>]
        </h2>       
        <hr>
      </div>
    </nav>
    

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>

<!-- 초기 패스워드는 사원의 생년월일 yyyymmdd 형식 -->
<!-- Page content -->
<div class="container-fluid mt--7" style="max-width: 70%; max-height: 70%;">
      <!-- Table -->
<div class="table-responsive">
 <div class="card shadow">                     
      <div class="card-header border-0" style="height: 100px;">
      	<h1> 사번 번호 : ${employeeDTO.emp_id}</h1>
        <h4 style="color: 5a5a5a;"> ※ 초기 패스워드는 yyyymmdd 형식의 사원의 생년월일입니다</h4>  
      </div>
      <div style="margin-left: 50px; margin-right: 50px; margin-top: 20px; margin-bottom: 30px;">
    <table class="table align-items-center" style="text-align: center; font-weight:bold;">   
    <tbody>
        <tr>
            <th scope="row" style="font-size: 20px;">이름</th>
            <td style="font-size: 20px;" > ${employeeDTO.name}</td>
        </tr>
        <tr>        
            <th scope="row" style="font-size: 20px;">생년월일</th>
            <td style="font-size: 20px;">${employeeDTO.birthday}</td>
        </tr>
        <tr>            
            <th scope="row" style="font-size: 20px;">연락처</th>
            <td style="font-size: 20px;">${employeeDTO.phone}</td>
        </tr>
         <tr>                   
            <th scope="row" style="font-size: 20px;">거주지</th>
            <td style="font-size: 20px;"> ${employeeDTO.address}</td>
         </tr>
         <tr>              
            <th scope="row" style="font-size: 20px;">직급</th>
			<td style="font-size: 20px;">${employeeDTO.positionDTO.name}</td>
         </tr>
         <tr>  
            <th scope="row" style="font-size: 20px;">기본급</th>
            <td style="font-size: 20px;">${employeeDTO.salary}</td>
         </tr>
         <tr>  
            <th scope="row" style="font-size: 20px;">지점명</th>
            <td style="font-size: 20px;"> ${employeeDTO.storeDTO.store_name}</td>
         </tr>
         <tr>
            <th scope="row" style="font-size: 20px;">입사일</th>
            <td style="font-size: 20px;"> ${employeeDTO.hire_date}</td>
        </tr>   
    </tbody>
</table>
</div>
</div>
</div>
</div>

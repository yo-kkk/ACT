<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="app" value="${pageContext.request.contextPath}" />	
<script type="text/javascript">
$(document).ready(function() {
	$('#search_btn').click(function() {
		var when =$('#when').val();
		
		if(!when){
			alert('검색 월을 입력해주세요');
		}else{
			location.href='${app}/store/salary/pastSalaryList/1/?when='+when;
		}
	});
});			
</script>			

<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 120px;">
              <form class="form-inline">
              <h3 class="mb-0">${store_name} 월급 내역</h3>
               </form>
              
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  <div class="input-group-prepend">
              <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
          	  </div>
          	  	<input type="month" class="form-control"  id="when" required />
          	  </div>
			  
			  <button type="button" id="search_btn" class="btn btn-success btn-sm" style="margin-left: 10px; margin-bottom: 25px;">검색</button>
			  
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/store/salary/pastSalaryList/1/?when='">
              전체보기
              </button>
              
              
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush">
	<thead class="thead-light">
		<tr>
		<th scope="col">사번</th>
        <th scope="col">사원이름</th>
		<th scope="col">목표 월</th>
		<th scope="col">총 급여</th>
        </tr>
    </thead>
<tbody id="salList">
	<c:forEach items="${list}" var="list">
		<tr>
			<td>${list.empDTO.emp_id}</td>
			<td>${list.empDTO.name}</td>
			<td>${list.bs_month}</td>
			<td>${list.monthly_salary}</td>
		</tr>
	</c:forEach>
                
</tbody>
</table>
</div>

<!-- 페이징 part-->
<div class="card-footer py-4" >

  <nav id="paging_part" aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/salary/pastSalaryList/1/?when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/salary/pastSalaryList/${pageDTO.startBlock-1}/?when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/store/salary/pastSalaryList/${p}/?when=${when}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/store/salary/pastSalaryList/${pageDTO.endBlock+1}/?when=${when}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/store/salary/pastSalaryList/${pageDTO.totalPage}/?when=${when}" tabindex="-1">
          <i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i>
        </a>
      </li>
       
    </ul>
  </nav>
  
</div>
     <!-- 페이징 part end-->
</div>
</div>
</div>    
</div>
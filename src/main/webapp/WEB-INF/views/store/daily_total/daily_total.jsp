<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {

	$('#search_btn').click(function() {
		var year = $('#year').val();
		var month = $('#month').val();
		
		if(!year||!month){
			alert('년/월 일을 지정해주세요.');
		}else{
			location.href='${app}/store/daily_total/1/?when='+year+'-'+month;
		}
	});
	
	$('.title_btn').click(function(){
		var date = $(this).text().replace(/[/]/g,'-');
		location.href='${app}/store/transact_list/1/?when='+date;
		
	})

});
</script>

<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 120px;">
              
              <h3 class="mb-0">${store_name} 일일 매출 조회</h3>
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  
          	  	<select class="form-control" id="year" style="width: 120px;">
					<option disabled selected hidden>년도</option>
					<option value="19">2019년</option>
					<option value="20">2020년</option>
					<option value="21">2021년</option>
					<option value="22">2022년</option>
					<option value="23">2023년</option>
					<option value="24">2024년</option>
				</select>
				
				<select class="form-control" id="month" style="width: 80px;">
					<option disabled selected hidde>월</option>
					<option value="01">1월</option>
					<option value="02">2월</option>
					<option value="03">3월</option>
					<option value="04">4월</option>
					<option value="05">5월</option>
					<option value="06">6월</option>
					<option value="07">7월</option>
					<option value="08">8월</option>
					<option value="09">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
				</select>
          	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  	<span class="btn-inner--text">검색</span>
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/store/daily_total/1/?when='">
              전체보기
              </button>
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">일자</th>
		<th scope="col">마감시각</th>
		<th scope="col">총 수입</th>
		<th scope="col">마감직원</th>
	</tr>
	</thead>
	<tbody>
	
	<c:forEach items="${list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-outline-secondary title_btn">${list.bs_date}</button>
			</td>
			<td>${list.reg_time}</td>
			<td>${list.total_income}</td>
			<td>${list.closing_id}</td>
		</tr>
	</c:forEach>
	
	</tbody>
</table>
</div>


<!-- 페이징 part-->

<div class="card-footer py-4" >
	<div>

</div>

  <!-- paging!!! -->
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/daily_total/1/?when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/daily_total/${pageDTO.startBlock-1}/?when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/store/daily_total/${p}/?when=${when}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/store/daily_total/${pageDTO.endBlock+1}/?when=${when}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/store/daily_total/${pageDTO.totalPage}/?when=${when}" tabindex="-1">
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


<br />
<hr />
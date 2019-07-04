<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {

	$('#search_btn').click(function() {
		var when = $('#when').val();
		
		if(!when){
			alert('검색 월을 입력 해주세요.');
		}else{
			location.href='${app}/head/daily/1/?store=${store_name}&when='+when;
		}
	});
	
	$('.title_btn').click(function(){
		var date = $(this).text().replace(/[/]/g,'-');
		location.href='${app}/head/transact_view/1/?store=${store_name}&when='+date;
		
	})
	
	$('#loc').on('change',function(){
   		var location_code = $('#loc').val();
   		 
   		$.ajax({
   			type : 'POST',
   	    	url  : 'select_store',
   	    	data : {location_code : location_code},
   	    	async : false,
   	    	success : function(data){
   	    		$('#store_select').find('option').each(function(){
   	            	$(this).remove();
   	            });
   	    		
   	    		var select_box = null;
   	    		
   	    		for(let i=0;i<data.length;i++){
   	            	select_box+='<option value="' + data[i] +'">' + data[i] +'</option>';
   	            }
   	    		
   	            $('#store_select').append(select_box);
   	         
   	         	$('#store_select_btn').click(function() {
   	        	 	var store = $('#store_select').val();
   	        	 	location.href='${app}/head/daily/1/?store='+store+'&when=';
   	         	
   	         	});
   	      }
   	    	
   	    }); 
   	});
});
</script>

<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 200px;">
              <form class="form-inline">
                     
              <select id="loc" class="form-control" >
			  	<option disabled selected hidden>지역</option>
			  	<option value="02">서울
			  	<option value="031">경기도
				<option value="033">강원도
				<option value="041">충남
				<option value="043">충북
				<option value="051">부산
				<option value="053">대구
				<option value="054">경남
				<option value="055">경북
				</option>
			  </select>
			  
			  <select id="store_select" class="form-control" style="margin-left: 20px;">
				<option disabled selected hidden>지점</option>		
			  </select>
			         
			  <button type="button" class="btn btn-outline-warning btn-sm" id="store_select_btn" style="margin-left: 20px;">
              지점조회
              </button>
			                
              </form>
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  
          	  	<input type="month" class="form-control"  id="when"/>
          	  	
          	  </div>
			  
			  <button type="button" class="btn btn-outline-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  월별로 검색
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/head/daily/1/?store=&when='">
              전체보기
              </button>
              </form>
              
              
              <h3 class="mb-0">${store_name} 지점 <c:if test="${when!=''}">(${when})</c:if> 일일 매출 조회 </h3>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">일자</th>
		<th scope="col">매장</th>
		<th scope="col">마감시각</th>
		<th scope="col">총 수입</th>
	</tr>
	</thead>
	<tbody>
	
	<c:forEach items="${list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-outline-secondary title_btn">${list.bs_date}</button>
			</td>
			<td>${list.storeDTO.store_name}
			<td>${list.reg_time}</td>
			<td>${list.total_income}</td>
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
        <a class="page-link" href="${app}/head/daily/1/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/daily/${pageDTO.startBlock-1}/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/daily/${p}/?store=${store_name}&when=${when}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/daily/${pageDTO.endBlock+1}/?store=${store_name}&when=${when}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/daily/${pageDTO.totalPage}/?store=${store_name}&when=${when}" tabindex="-1">
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
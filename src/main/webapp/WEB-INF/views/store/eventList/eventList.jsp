<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {
	detail_event();
	
	$('#search_btn').click(function() {
		var keyword = $('#search_box').val();
		var today = new Date();
		
		if(!keyword){
			alert('검색어를 입력해주세요.');
		}else{
			$.ajax({
				type : 'POST',
				url : 'search_event',
				data : {
					keyword : keyword
				},
				async : false,
				success : function(data) {
					let ref ='<tr>';
					ref+='<th>이벤트 이름</th>';
					ref+='<th>제품 코드</th>';
					ref+='<th>정가</th>';
					ref+='<th>할인율</th>';
					ref+='<th>시작 날짜</th>';
					ref+='<th>종료 날짜</th>';
					ref+='<tr>';
				for(let i=0;i<data.length;i++){
					ref+= '<tr>';
					ref+= '<td>'+data[i].event_name;
					if(data[i].productDTO.season_off=='y'){
						ref+=' (진행중)';
					}
					ref+= '</td>';
					ref+= '<td>'+data[i].productDTO.product_code+'</td>';
					ref+= '<td>'+data[i].productDTO.price+'원 </td>';
					ref+= '<td>'+data[i].discount_rate+'% </td>';
					ref+= '<td>'+data[i].start_date +'</td>';
					ref+= '<td>'+data[i].end_date +'</td>';
					ref+= '</tr>';					
				}
				$('#modal_name').text('검색어 : ' + keyword);
				
				$('#modal_start').html(' ');
				$('#modal_end').html(' ');
				
				$('#modal_table').html(ref);
				$('#detail_modal').modal();	
				
				},
				error : function(){
					alert('해당 내역이 존재하지 않습니다.');
				}
				
			});
		}
		
	});
	
	$('#date_btn').click(function() {
		var keyword_date = $('#keyword_date').val();
		
		if(!keyword_date){
			alert('년/월/일을 선택해주세요.');
		}else{
			$.ajax({
				type : 'POST',
				url : 'search_date',
				data : {
					keyword_date : keyword_date
				},
				async : false,
				success : function(data) {
					
					$('#keyword_title').html('===== [${store_name}] '+keyword_date+' 이벤트 조회 결과 =====');
					
					let ref = '<thead>';
						ref+= '<tr>';
						ref+= '	<th scope="col">이벤트 이름</th>';
						ref+= '	<th scope="col">시작 날짜</th>';
						ref+= '	<th scope="col">종료 날짜</th>';
						ref+= '</tr>';
						ref+= '</thead>';
						ref+= '<tbody>';
						for(let i=0;i<data.length;i++){
							ref+= '	<tr>';
							ref+= '		<td>';
							ref+= '			<button type="button" class="btn btn-secondary event_detail" value="'+data[i].event_code+'">'+data[i].event_name+'</button>';
					    	ref+= '        </td>';
							ref+= '		<td>'+ data[i].start_date+'$</td>';
							ref+= '		<td>'+ data[i].end_date+'</td>';
							ref+= '	</tr>';
						}
						ref+= '</tbody>';
						
						$('#paging_div').remove();
						$('#date_btn').remove();
						$('#list_table').html(ref);
						
						detail_event();
						
				}
				
				
			});
		}
		
	});
	
});

function detail_event(){
$('.event_detail').click(function() {
		
		var event_code = $(this).val();
		$.ajax({
			type : 'POST',
			url : 'detail_modal',
			data : {
				event_code : event_code
			},
			async : false,
			success : function(data) {
				var event_name = data[0].event_name;
				var start_date = data[0].start_date;
				var end_date = data[0].end_date;
				
				$('#modal_name').text('이벤트 이름 : ' + event_name);
				$('#modal_start').text('시작 일자 : ' + start_date);
				$('#modal_end').text('종료 일자 : ' + end_date);

				
				let ref ='<tr>';
					ref+='<th>제품코드</th>';
					ref+='<th>할인률</th>';
					ref+='<th>정가</th>';
					ref+='<th>할인가</th>';
					ref+='<tr>';
				for(let i=0;i<data.length;i++){
					ref+= '<tr>';
					ref+= '<td>'+data[i].productDTO.product_code+'</td>';
					ref+= '<td>'+data[i].discount_rate+'% </td>';
					ref+= '<td>'+data[i].productDTO.price+'원 </td>';
					ref+= '<td>'+Number(data[i].productDTO.price)*(100 - Number(data[i].discount_rate))/100+'원 </td>';
					ref+= '</tr>';					
				}
				
				$('#modal_table').html(ref);
				$('#detail_modal').modal();
				
			}
		});
		
	});
}
</script>

<!-- Modal -->
<div class="modal fade" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 960px;">
    <div class="modal-content">
      <div class="modal-header">
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <div style="margin-top: -30px">
      	<h3 id="modal_name" style="margin-left: 20px;"></h3>
      </div>
      
      <table class="table align-items-center table-flush" id="modal_table" style="margin-top: 15px">
	  </table>
	  <div style="margin-top: 20px;">
	  	<h4 id="modal_start" style="margin-left: 20px"></h4>
	  </div>
	  <div style="margin-top: 20px">
	  	<h4 id="modal_end" style="margin-left: 20px"></h4>
	  </div>
	  
      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
        
      </div>
    </div>
  </div>
</div>
	
<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 140px;">
              
              <form class="form-inline" style="margin-top: 10px;">
			  
			  <div class="input-group mb-4" style="margin-right: 10px;">
          	  	<input type="date" class="form-control" placeholder="년/월/일 검색" id="keyword_date">
          	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="date_btn" style="margin-bottom: 25px;">
			  	날짜로 검색
			  </button>
			  <button type="button" class="btn btn-warning btn-sm"style="margin-bottom: 25px;" onclick="location.href='${app}/store/eventList/1/'">
              전체보기
              </button>
              
              <hr style="height: 30px; width: 0px; border-right: 0px; border: 0.4px solid; margin-left: 20px; margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  	<input class="form-control" placeholder="제품코드" type="text" id="search_box" style="height: 70%;">
          	  </div>
              
              <button type="button" class="btn btn-outline-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	제품코드 검색
			  </button>
              
              </form>
              
              <form class="form-inline">
              <h3 class="mb-0">====== [${store_name}] 진행중인 이벤트 ======</h3>
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush table-success" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">이벤트 이름</th>
		<th scope="col">시작 날짜</th>
		<th scope="col">종료 날짜</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${curr_list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-secondary event_detail" value="${list.event_code}">${list.event_name}</button>
            </td>
			<td>${list.start_date}</td>
			<td>${list.end_date}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>

<h3 id="keyword_title" style="margin-left: 30px; margin-top: 80px;">===== [${store_name}] 모든 기간 이벤트 =====</h3>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="list_table" style="margin-top: 15px;">
	<thead>
	<tr>
		<th scope="col">이벤트 이름</th>
		<th scope="col">시작 날짜</th>
		<th scope="col">종료 날짜</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-secondary event_detail" value="${list.event_code}">${list.event_name}</button>
            </td>
			<td>${list.start_date}</td>
			<td>${list.end_date}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>


<!-- 페이징 part-->
<div class="card-footer py-4" id="paging_div">

  <nav id="paging_part" aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/eventList/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/eventList/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/store/eventList/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/store/eventList/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/store/eventList/${pageDTO.totalPage}/" tabindex="-1">
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
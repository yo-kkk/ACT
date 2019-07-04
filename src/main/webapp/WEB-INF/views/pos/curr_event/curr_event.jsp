<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
$(document).ready(function() {
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
	
	$('#search_btn').click(function() {
		var keyword = $('#search_box').val();
		
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
					ref+= '<td>'+data[i].event_name+'</td>';
					ref+= '<td>'+data[i].productDTO.product_code+'</td>';
					ref+= '<td>'+data[i].productDTO.price+'원 </td>';
					ref+= '<td>'+data[i].discount_rate+'% </td>';
					ref+= '<td>'+data[i].start_date +'</td>';
					ref+= '<td>'+data[i].end_date +'</td>';
					ref+= '</tr>';					
				}
				$('#modal_name').text('검색어 : ' + keyword);
				
				$('#modal_start').remove();
				$('#modal_end').remove();
				
				$('#modal_table').html(ref);
				$('#detail_modal').modal();	
				
				},
				error : function(){
					alert('해당 내역이 존재하지 않습니다.');
				}
				
			});
		}
		
	});
	
});
</script>


<!-- Modal -->
<div class="modal fade" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 880px;">
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
            <div class="card-header border-0" style="height : 120px;">
              <form class="form-inline">
              <h3 class="mb-0"> [${store_name}] 진행중인 이벤트 !!!</h3>
              </form>
              
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  <div class="input-group-prepend">
              <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
          	  </div>
          	  	<input class="form-control" placeholder="제품코드" type="text" id="search_box" style="height: 70%;">
        	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  	<span class="btn-inner--text">검색</span>
			  </button>
              
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
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


</div>
</div>
</div>    
</div>
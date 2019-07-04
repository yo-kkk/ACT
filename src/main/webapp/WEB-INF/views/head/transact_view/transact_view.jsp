<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {
	detail_view();
	
	$('#search_btn').click(function() {
		var date = $('#keyword_date').val().substring(2,10);
		
		if(!date){
			alert('년/월 일을 지정해주세요.');
		}else{
			location.href='${app}/head/transact_view/1/?store=${store_name}&when='+date;
		}
	});	
	
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
   	        	 	location.href='${app}/head/transact_view/1/?store='+store+'&when=';
   	         	
   	         	});
   	      }
   	    	
   	    }); 
   	});
	
	$('#search_code_btn').click(function() {
		var keyword = $('#code_box').val();
		
		if(!keyword){
			alert('검색어를 입력하세요.');
		}else{
			$.ajax({
				type : 'POST',
				url : 'search',
				data : {
					keyword : keyword
				},
				async : false,
				success : function(data) {
					let ref = '<thead class="thead-light"><tr>';
					ref+= '<th scope="col">거래 코드</th>';
					ref+= '<th scope="col">지점명</th>';
					ref+= '<th scope="col">총 가격</th>';
					ref+= '<th scope="col">구매 날짜</th>';
					ref+= '<th scope="col">결제 수단</th>';
					ref+= '<th scope="col">환불 여부</th>';
					ref+= '</tr>';
					ref+= '<tr>';
					ref+= '<td>';
					ref+= '<button type="button" class="btn btn-secondary detail_btn">'+data.transaction_code+'</button>';
            		ref+= '</td>';
					ref+= '<td>'+data.storeDTO.store_name+'</td>';
					ref+= '<td>'+data.total_price+'</td>';
					ref+= '<td>'+data.trans_date+'</td>';
					ref+= '<td>'+data.payment+'</td>';
					ref+= '<td>'+data.refund_yn+'</td>';
					ref+= '</tr>';
				         		
				$('#my_table').html(ref);				
				$('#paging_part').hide();
				
				detail_view()
				
				},
				error : function(){
					alert('해당 내역이 존재하지 않습니다.');
				}
				
			});
		}

	});

});

function detail_view(){
	$('.detail_btn').click(function() {
		var transact_code = $(this).text();
		var store_name = $(this).parent().parent().find('td').eq(1).text();
		var total_price = $(this).parent().parent().find('td').eq(2).text();
		var trans_date = $(this).parent().parent().find('td').eq(3).text();
		var payment = $(this).parent().parent().find('td').eq(4).text();

		$.ajax({
			type : 'POST',
			url : 'transact_Detail',
			data : {
				transact_code : transact_code
			},
			async : false,
			success : function(data) {
				$('#modal_total_price').text('총가격 : ' + total_price);
				$('#modal_store_name').text('지점명 : ' + store_name);
				$('#modal_trans_date').text('거래 시각 : ' + trans_date);
				$('#modal-title').text(transact_code+'번 상세 거래내역 ('+payment+')');

				
				let ref = "<tr><th>제품코드</th><th>수량</th>";
				for(let i=0;i<data.length;i++){
					ref+= '<tr>';
					ref+= '<td class="select_productDetail">';
					if(data[i].eventDTO!=null){
						ref+=data[i].productDTO.product_code+' <이벤트가 : ' + Number(data[i].productDTO.price)*(100 - Number(data[i].eventDTO.discount_rate))/100 + '원>';
					}else{
            			ref+= data[i].productDTO.product_code+' <정가 : '+data[i].productDTO.price+'원>';       		
					}     		
            		ref+= '</td>';
					ref+= '<td>'+data[i].quantity+'</td>';
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
  <div class="modal-dialog modal-dialog-centered" style="max-width: 600px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <div style="margin-top: -30px">
      	<h3 id="modal-title" style="margin-left: 20px;"></h3>
      </div>
      
      <table class="table align-items-center table-flush" id="modal_table" style="margin-top: 15px">
	  </table>	  
	  <div>
	  	<h4 id="modal_store_name" style="margin-left: 20px"></h4>
	  </div>	  
	  <div>
	  	<h4 id="modal_total_price" style="margin-left: 20px; margin-top: 20px;"></h4>
	  </div>
	  <div style="margin-top: 20px">
	  	<h5 id="modal_trans_date" style="margin-left: 20px"></h5>
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
              
              <form class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  	<input type="date" class="form-control" placeholder="년/월/일 검색" id="keyword_date">
          	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  	날짜 검색
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/head/transact_view/1/?store=&when='">
              전체보기
              </button>
              
              <hr style="height: 30px; width: 0px; border-right: 0px; border: 0.4px solid; margin-left: 20px; margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  	<input type="text" class="form-control" placeholder="거래코드" id="code_box">
          	  </div>
              
              <button type="button" class="btn btn-outline-success btn-sm"id="search_code_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  거래코드 검색
			  </button>
              
              </form>
              
               <h3 class="mb-0">${store_name} 지점 <c:if test="${when!=''}">(${when})</c:if> 거래내역 조회 </h3>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">거래 코드</th>
		<th scope="col">지점명 </th>
		<th scope="col">총 가격</th>
		<th scope="col">거래 시각</th>
		<th scope="col">결제 수단</th>
		<th scope="col">환불 여부</th>
	</tr>
	</thead>
	<tbody>
	
	<c:forEach items="${list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-secondary detail_btn">${list.transaction_code}</button>
            </td>
			<td>${list.storeDTO.store_name}</td>
			<td>${list.total_price}</td>
			<td>${list.trans_date }</td>
			<td>${list.payment }</td>
			<td>${list.refund_yn}</td>
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
        <a class="page-link" href="${app}/head/transact_view/1/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/transact_view/${pageDTO.startBlock-1}/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/transact_view/${p}/?store=${store_name}&when=${when}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/transact_view/${pageDTO.endBlock+1}/?store=${store_name}&when=${when}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/transact_view/${pageDTO.totalPage}/?store=${store_name}&when=${when}" tabindex="-1">
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
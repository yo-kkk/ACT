<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {
	select_Detail();
	
	$('#search_btn').click(function() {
		var keyword = $('#search_box').val();
		
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
					ref+= '<th scope="col">총 가격</th>';
					ref+= '<th scope="col">구매 날짜</th>';
					ref+= '<th scope="col">결제 수단</th>';
					ref+= '</tr>';
					ref+= '<tr>';
					ref+= '<td>';
					ref+= '<button type="button" class="btn btn-secondary detail_btn">'+data.transaction_code+'</button>';
            		ref+= '</td>';
					ref+= '<td>'+data.total_price+'</td>';
					ref+= '<td>'+data.trans_date+'</td>';
					ref+= '<td>'+data.payment+'</td>';
					ref+= '</tr>';
				         		
				$('#my_table').html(ref);				
				select_Detail();
				$('#paging_part').hide();
				
				},
				error : function(){
					alert('해당 내역이 존재하지 않습니다.');
				}
				
			});
		}

	});

});

function select_Detail(){
	$('.detail_btn').click(function() {
		var transaction_code = $(this).text();
		var total_price = $(this).parent().parent().find('td').eq(1).text();
		var trans_date = $(this).parent().parent().find('td').eq(2).text();
		var payment = $(this).parent().parent().find('td').eq(3).text();

		$.ajax({
			type : 'POST',
			url : 'transact_Detail',
			data : {
				transaction_code : transaction_code
			},
			async : false,
			success : function(data) {
				$('#modal_total_price').text('총가격 : ' + total_price);
				$('#modal_trans_date').text('거래 시각 : ' + trans_date);
				$('#modal-title').text(transaction_code+'번 상세 거래내역 ('+payment+')');

				
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
		
		
		$('#refund_btn').click(function() {
			var refund_confirm = confirm("정말로 환불하시겠습니까?");
			
			if(refund_confirm == true){
				$.ajax({
					type : 'POST',
					url  : 'refund_all',
					data : {transaction_code : transaction_code
							},
					async : false,
					success : function(data){
						alert('환불이 정상적으로 처리 되었습니다.');
						location.href='${app}/pos/refund/1/';
					}
				});
			}			
		});		
	});
}
</script>

<!-- Modal -->
<div class="modal fade" id="detail_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
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
	  	<h4 id="modal_total_price" style="margin-left: 20px"></h4>
	  </div>
	  <div style="margin-top: 20px">
	  	<h5 id="modal_trans_date" style="margin-left: 20px"></h5>
	  </div>
	  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="refund_btn">환불하기</button>
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
              <h3 class="mb-0">${store_name} 매장 거래 (환불)</h3>
              <button type="button" class="btn btn-outline-danger btn-sm" style="margin-left: 20px;" onclick="location.href='${app}/pos/refund/1/list'">환불 내역 조회</button>
              </form>
              
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  <div class="input-group-prepend">
              <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
          	  </div>
          	  	<input class="form-control" placeholder="거래코드" type="text" id="search_box" style="height: 70%;">
        	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  	<span class="btn-inner--text">검색</span>
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/pos/refund/1/'">
              전체보기
              </button>
              
              
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">거래 코드</th>
		<th scope="col">총 가격</th>
		<th scope="col">구매 날짜</th>
		<th scope="col">결제 수단</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="list">
		<tr>
			<td>
				<button type="button" class="btn btn-secondary detail_btn">${list.transaction_code}</button>
            </td>
			<td>${list.total_price}</td>
			<td>${list.trans_date }</td>
			<td>${list.payment }</td>
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
        <a class="page-link" href="${app}/pos/refund/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/refund/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/pos/refund/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/pos/refund/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/refund/${pageDTO.totalPage}/" tabindex="-1">
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {
	$('.detail_btn').click(function() {
		var transact_code = $(this).text();
		var total_price = $(this).parent().parent().find('td').eq(1).text();
		var trans_date = $(this).parent().parent().find('td').eq(2).text();
		var payment = $(this).parent().parent().find('td').eq(3).text();

		$.ajax({
			type : 'POST',
			url : 'transact_Detail',
			data : {
				transact_code : transact_code
			},
			async : false,
			success : function(data) {
				$('#modal_total_price').text('총가격 : ' + total_price);
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
	
	$('#delete_btn').click(function() {
		var delete_confirm = confirm( '오늘 결산내역을 삭제 하시겠습니까? \n(꼭 다시 결산하기를 눌러주세요)' );
		var date_of_day = '${date_of_day}';
		var store_name = '${store_name}';
		
		if(delete_confirm){			
			$.ajax({
				type : 'POST',
				url  : 'delete_closing',
				data : {
					store_name : store_name
				},
				async : false,
				success : function(data){
					alert( date_of_day + ' ' + store_name +' 결산이 삭제되었습니다. \n\n결산하기를 꼭꼭! 다시 눌러주세요!');
					location.reload();
				}
			
			});			
		}
	});
	
	$('#closing_btn').click(function() {
		
		if( $('#my_table tr').length ==1){
			alert('오늘 발생한 거래내역이 없습니다.')
		}else{
			var date_of_day = '${date_of_day}';
			var store_name = '${store_name}';
			
			var closing_confirm = confirm('오늘 매장 하신거죠?? \n\n꼭 마감후에 눌러주세요!!');
			
			if(closing_confirm){
				
				$.ajax({
					type : 'POST',
					url  : 'closing',
					async : false,
					success : function(data){
						alert( date_of_day + ' ' + store_name +' 매장 결산이 완료되었습니다.');
						location.reload();
					},
					error : function(){
						alert('이미 결산 하신거 같으신데요..? 삭제를 먼저 눌러주세요!')
					}
				});
			}
			
			
			
		}
	});
})

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
              <h3 class="mb-0" >${store_name} 매장 결산 페이지</h3>
              
              <form  class="form-inline" style="margin-top: 30px;">
              <h2 class="mb-0" style="margin-right: 20px" >${date_of_day} 거래내역</h2>
              
              <c:if test="${daily_incomeDTO==null}">
              	<button type="button" class="btn btn-outline-success" id="closing_btn">오늘 영업종료(결산)</button>
              </c:if>
              <c:if test="${daily_incomeDTO!=null}">
              	<button type="button" class="btn btn-outline-danger" id="delete_btn">오늘 결산 삭제(재결산)</button>
              </c:if>
              
              </form>

            </div>

<c:if test="${daily_incomeDTO!=null}">
<h1 style="margin-left: 30px; margin-top: 30px;">==============결산 후 거래항목================</h1>                
<div class="table-responsive" style="margin-bottom: 180px;">
<table class="table align-items-center table-flush" id="after_table" style="margin-top: 15px;">
	<thead class="thead-light">
	<tr>
		<th scope="col">거래 코드</th>
		<th scope="col">총 가격</th>
		<th scope="col">거래 시각</th>
		<th scope="col">결제 수단</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${after_list}" var="after_list">
		<tr>
			<td>
				<button type="button" class="btn btn-secondary detail_btn">${after_list.transaction_code}</button>
            </td>
			<td>${after_list.total_price}</td>
			<td>${after_list.trans_date }</td>
			<td>${after_list.payment }</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>            
<h1 style="margin-left: 30px;" >==============이미 결산된 항목!!!================</h1>
<h3 style="margin-left: 30px;" > 오늘의 총 수입 : ${daily_incomeDTO.total_income}</h3>  
</c:if>

<div class="table-responsive">
<table class="table align-items-center table-flush <c:if test="${daily_incomeDTO!=null}">table-dark</c:if>" id="my_table" style="margin-top: 15px;">
	<thead>
	<tr>
		<th scope="col">거래 코드</th>
		<th scope="col">총 가격</th>
		<th scope="col">거래 시각</th>
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
        <a class="page-link" href="${app}/pos/closing/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/closing/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/pos/closing/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/pos/closing/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/closing/${pageDTO.totalPage}/" tabindex="-1">
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
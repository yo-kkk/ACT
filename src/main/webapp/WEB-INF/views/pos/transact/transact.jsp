<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
	
<script type="text/javascript">
$(document).ready(function() {
	$('#viewall_btn').click(function() {
		ajax_paging(1,'');
	});	
	
	$('#search_btn').click(function() {
		var keyword = $('#search_product').val();
		if(!keyword){
			alert('검색어를 입력하세요.');
		}else{
			ajax_paging(1,keyword);
		}
	});
	
	$('#transact_btn').click(function() {
		var ages = $('#ages').val();
		var sex = $('#sex').val();
		var payment = $('#payment').val();
		var total_price = 0;
		
		var product_quantity= new Array();
		
		$('#transact_table tr').each(function(index){
			total_price += Number( $(this).find('td').eq(2).text() );
			if(index>=1){
				var p_c = $(this).find('td').eq(0).text();
				var p_q = $(this).find('td').eq(1).find('select').val();
				product_quantity[index]=new Array(p_c,p_q);
			}
		});

		if(ages==null||sex==null||payment==null){
			alert('고객 정보를 입력해주세요');
		}else if(total_price==0){
			alert('제품을 추가해주세요.');
		}else{
			jQuery.ajaxSettings.traditional = true;
			
			var transact_confirm = confirm("거래 품목이 정확합니까? 다시한번 확인해주세요.");
			
			if(transact_confirm){
			$.ajax({
				type : 'POST',
				url  : 'transact_all',
				data : {ages : ages,
						sex : sex,
						payment : payment,
						total_price : total_price,
						product_quantity : product_quantity
						},
				async : false,
				success : function(data){
					alert('거래가 완료되었습니다.');
					location.reload();
				}
			});
			
			}
			
		}
	});
	
});


function ajax_paging(pg,keyword){	
	$.ajax({
		type : 'POST',
		url : 'product_list',
		data : {
			store_name : '${store_name}',
			pg	:	pg,
			keyword : keyword
		},
		async : false,
		success : function(data) {
			
			let ref = "<tr>";
				ref+= '<th scope="col">제품코드</th>';
				ref+= '<th scope="col">재고</th>';
				ref+= '<th scope="col">가격</th>';
				ref+= '<th scope="col">이벤트</th>';
				ref+= "</tr>";
			for(let i=0;i<data.length;i++){
				ref+= '<tr>';
				ref+= '<td class="select_productDetail">';
				ref+= '<button type="button" onclick="insert_product(this)" class="btn btn-secondary" id="'+i+'">';
		          		ref+= data[i].productDTO.product_code;
		       	ref+= '</button>';	            		
		       	ref+= '</td>';
				ref+= '<td id="q_'+i+'">'+data[i].quantity+'</td>';
				ref+= '<td id="p_'+i+'">'
				if(data[i].eventDTO != null){
					ref+=Number(data[i].productDTO.price)*(100 - Number(data[i].eventDTO.discount_rate))/100;
				}else{
					ref+=data[i].productDTO.price;
				}
				ref+= '</td>';
				ref+= '<td>' 
				
				if(data[i].eventDTO != null){
					ref+= data[i].eventDTO.event_name + ' (할인율 : ' + data[i].eventDTO.discount_rate + '% )';
				}else{
					ref+= 'X';
				}
				
				ref+= '</td>';
				
				ref+= '</tr>';					
				}
			
			$('#modal_table').html(ref);
			
			var startBlock = data[0].pageDTO.startBlock;
			var endBlock = data[0].pageDTO.endBlock;
			var pg = data[0].pageDTO.pg;
			var totalPage = data[0].pageDTO.totalPage;			
			
			let pagebtn ='';
				pagebtn+=' <nav aria-label="...">            ';
				pagebtn+='		  <ul class="pagination">    ';
				pagebtn+='		    <li class="page-item ';
				if(startBlock==1){pagebtn+='disabled';}
				pagebtn+='">';
				pagebtn+='		      <a id="'+keyword+'" class="page-link" onclick="paging_before(this)" tabindex="-1"> ';
				pagebtn+='		        <i class="fa fa-angle-left" id='+startBlock+'></i> ';
				pagebtn+='		      </a> ';
				pagebtn+='		    </li>  ';
				for(let i=startBlock;i<=endBlock;i++){
					pagebtn+='		    <li class="page-item ';
					if(i==pg){pagebtn+='active';}
					pagebtn+='">';
					pagebtn+='		    	<a id="'+keyword+'"class="page-link" '; 
					if(i!=pg){pagebtn+='onclick="paging_btn(this)"';}
					pagebtn+='>'+i+'</a>'; 
					if(i==pg){pagebtn+='<span class="sr-only">(current)</span>';}
					pagebtn+='		    </li>';
				}
				pagebtn+='		    <li class="page-item ';
				if(endBlock==totalPage){pagebtn+='disabled'};
				pagebtn+='"> ';
				pagebtn+='		      <a id="'+keyword+'" class="page-link" onclick="paging_after(this)" > ';
				pagebtn+='		        <i class="fa fa-angle-right" id='+endBlock+'></i> ';
				pagebtn+='		      </a>  ';
				pagebtn+='		    </li>   ';
				pagebtn+='		  </ul>     ';
				pagebtn+=' </nav>           ';
			$('#modal_paging').html(pagebtn);				
			
			$('#list_modal').modal("show");		
			
			}			
	});		
}

function paging_btn(obj){
	var pg = $(obj).text();
	var keyword = $(obj).attr('id');
	ajax_paging(pg,keyword);
}

function paging_before(obj){
	var pg = Number($(obj).find('i').attr('id'))-1;
	var keyword = $(obj).attr('id');
	ajax_paging(pg,keyword);
}

function paging_after(obj){
	var pg = Number($(obj).find('i').attr('id'))+1;
	var keyword = $(obj).attr('id');
	ajax_paging(pg,keyword);
}

function insert_product(obj){	
	var product_code = $(obj).text();
	var seq = $(obj).attr('id');
	var quantity = $('#q_'+seq).text();
	var price = $('#p_'+seq).text();
	var bool = 0;
	
	$('#transact_table tr').each(function(){
		var p_c = $(obj).find('td').eq(0).text();
		if(product_code==p_c){
			bool = 1;
		}
	});
	
	if(quantity==0){
		alert('재고가 없습니다.');
	}else if(bool==1){
		alert('해당제품이 목록에 존재합니다.')
	}
	else{
	
		let my_table="";
		my_table+= '<tr>';
		my_table+= '<td>' + product_code + '</td>';
	
		my_table+= '<td>';
		my_table+= '<form class="form-inline">';			
		my_table+= '<select class="form-control is-valid display-3 quantity" style="height: 70%; width : 100px; margin-left: 20px;">';			
		my_table+= '<option value="1">1</option>'
		
		for(let i=2;i<=quantity;i++){
			my_table+='<option value="'+i+'">'+i+'</option>';
		}														
		my_table+= '</select>';
		my_table+= '<button type="button" onclick="deleteLine(this)" class="btn btn-danger btn-sm" style="margin-left:10px;"> 제거 </button>'
		my_table+= '</form>';
		my_table+= '<span style="visibility: hidden;">'+price+'</span></td>';
		my_table+= '<td>'+price+'</td>';
			
		my_table+= '</tr>';
	
		$('#transact_body').append(my_table);
		$('#list_modal').modal('hide');
		
		$('.quantity').on('change',function(){
			var this_price = $(this).parent().parent().parent().find('td').eq(1).find('span').text();
			var quantity = $(this).val();
			
			$(this).parent().parent().parent().find('td').eq(2).html(this_price*quantity);
			
		});	
		
	}
		
}

function deleteLine(obj) {
    var tr = $(obj).parent().parent().parent();
 
    tr.remove();
}
</script>

<!-- Modal -->
<div class="modal fade" id="list_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 1200px;">
    <div class="modal-content">
      <div class="modal-header">
       
       <h5 class="modal-title" id="exampleModalLabel">제품 리스트</h5>
       
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table align-items-center table-flush" id="modal_table">
		</table>
      </div>
      
      <!-- paging modal -->
      <div style="margin-left: 500px;" id="modal_paging">
      
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
            <div class="card-header border-0" style="height : 210px;">
             <h3>${store_name} 매장 거래 (구매)</h3> 
              
             <form class="form-inline" style="margin-top: 25px;">
             	
				<select class="form-control is-invalid display-3" name="ages" id="ages" style="height: 70%;">
					<option disabled selected hidden>연령</option>
					<option value="teen">청소년</option>			
					<option value="20">20대</option>			
					<option value="30">30대</option>			
					<option value="40">40대</option>			
					<option value="50">50대</option>			
					<option value="order">60대 이상</option>					
				</select>
				
				<select class="form-control is-invalid display-3" name="sex" id="sex" style="height: 70%; margin-left: 20px;">
					<option disabled selected hidden>성별</option>
					<option value="M">남자</option>						
					<option value="W">여자</option>						
				</select>
				
				<select class="form-control is-invalid display-3" name="payment" id="payment" style="height: 70%; margin-left: 20px;">
					<option disabled selected hidden>결제 수단</option>
					<option value="현금">현금</option>						
					<option value="카드">카드</option>						
					<option value="기타">기타</option>						
				</select>
				
				<button type="button" class="btn btn-outline-warning" id="transact_btn" style="margin-left: 30px;">
					결제하기
				</button>
				
			 </form>
				
				
              <form class="form-inline" style="margin-top: 30px;">

				<div class="input-group mb-4">
				<div class="input-group-prepend">
					<span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
				</div>
				<input class="form-control" placeholder="제품코드 검색" type="text" id="search_product" style="height: 70%; width: 300px;">
				</div>

				<button type="button" class="btn btn-success btn-sm" id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
					<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
					<span class="btn-inner--text">검색</span>
				</button>
				
				<button type="button" class="btn btn-warning btn-sm" id="viewall_btn" style="margin-bottom: 25px;">
              	전체보기
              	</button>
				
	
				
				</form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="transact_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">제품 코드</th>
		<th scope="col">선택 수량</th>
		<th scope="col">가격</th>
	</tr>
	</thead>
	<tbody id="transact_body">
	
	</tbody>
</table>
</div>

</div>
</div>
</div>    
</div>

	
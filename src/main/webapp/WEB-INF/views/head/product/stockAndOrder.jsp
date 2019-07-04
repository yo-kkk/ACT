<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
$(document).ready(function() {
	/* 전체보기 버튼 클릭시 모달창 팝업 이벤트 */
	$('#viewall_btn').click(function() {
		ajax_paging(1,'');
	});	
	
	/* 제품 검색 버튼 클릭시 모달창 팝업 이벤트 */
	$('#search_btn').click(function() {
		var keyword = $('#search_input').val();
		if(!keyword){
			alert('검색어를 입력하세요.');
		}else{
			ajax_paging(1,keyword);
		}
	});
	
	/* 발주 제품 선택 완료후 발주 버튼 클릭 이벤트*/
	$('#order_btn').click(function() {
		var total_price = 0;
		
		var product_quantity= new Array();
		var arrayYN = 0;
		
		$('#product_list_tbody tr').each(function(index){
			total_price += Number( $(this).find('td').eq(4).text());
			
			var p_c = $(this).find('td').eq(0).text();
			var p_q = $(this).find('td').eq(3).find('input').val();
			var p_p = $(this).find('td').eq(4).text();
			var f_c = $(this).find('td').eq(1).attr('id');
			
			console.log(p_c);
			console.log(p_q);
			console.log(p_p);
			console.log(f_c);
			console.log('하나끝');

			product_quantity[index]=new Array(p_c,p_q,p_p,f_c);		
			arrayYN += 1;
		});

		if(total_price==0){
			alert('발주 목록이 비어있습니다.');
		}else{
			jQuery.ajaxSettings.traditional = true;
			
			var head_order_confirm = confirm("발주 품목이 정확합니까? 다시한번 확인해주세요.");
			
			if(head_order_confirm){
			$.ajax({
				type : 'POST',
				url  : 'head_order_all',
				data : {
						total_price : total_price,
						product_quantity : product_quantity,
						arrayYN			 : arrayYN
						},
				async : false,
				success : function(data){
					alert('발주가 완료되었습니다.');
					location.reload();
				}
			});
			
			}			
		}
	});

});

/* ajax 페이징 function */
function ajax_paging(pg,keyword){	
	$.ajax({
		type : 'POST',
		url : 'product_list',
		data : {
			"pg"	  :	pg,
			"keyword" : keyword
		},
		async : false,
		success : function(data) {
			console.log(JSON.stringify(data[0]));
			
			let ref = "<tr><th>제품코드</th><th>제조사</th><th>재고</th><th>가격</th><th>추가</th></tr>";
			for(let i=0;i<data.length;i++){
				ref+= '<tr>';
				ref+= '<td class="select_productDetail">';
				ref+=data[i].product_code;
		       	ref+= '</td>';
		       	ref+= '<td id="'+ data[i].factoryDTO.factory_code+'">'+ data[i].factoryDTO.factory_name +'</td>';	
				ref+= '<td id="q_'+i+'">'+data[i].head_stock_quantity+'</td>';
				ref+= '<td id="p_'+i+'">'+data[i].price+'</td>'
				ref+= '<td><button type="button" onclick="insert_product(this)" class="btn btn-secondary" id="'+i+'">추가</button></td>';	            		
				ref+= '</tr>';					
			}
			
			$('#allStockList_table').html(ref);
			
			var startBlock = data[0].pageDTO.startBlock;
			var endBlock = data[0].pageDTO.endBlock;
			var pg = data[0].pageDTO.pg;
			var totalPage = data[0].pageDTO.totalPage;			
			
			let pagebtn ='';
				pagebtn+=' <nav aria-label="...">            ';
				pagebtn+='		  <ul class="pagination">    ';
				pagebtn+='		    <li class="page-item ';
				
				if(startBlock==1){
					pagebtn+='disabled';
				}
				
				pagebtn+='">';
				pagebtn+='		      <a id="'+keyword+'" class="page-link" onclick="paging_before(this)" tabindex="-1">  ';
				pagebtn+='		        <i class="fa fa-angle-left" id='+startBlock+'></i>              ';
				pagebtn+='		      </a>                                            ';
				pagebtn+='		    </li>                                             ';
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
				pagebtn+='		      <a id="'+keyword+'" class="page-link" onclick="paging_after(this)" >                                                         ';
				pagebtn+='		        <i class="fa fa-angle-right" id='+endBlock+'></i>                                                      ';
				pagebtn+='		      </a>                                                                                     ';
				pagebtn+='		    </li>                                                                                      ';
				pagebtn+='		  </ul>                                                                                        ';
				pagebtn+=' </nav>                                                                                                ';
			$('#modal_paging').html(pagebtn);				
			
			$('#productModal').modal("show");		
			
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

/* 모달창에서 선택한 제품 발주 목록에 추가 function */
function insert_product(obj){	
	var product_code = $(obj).parent().parent().find('td').eq(0).text();	
	var factory_name = $(obj).parent().parent().find('td').eq(1).text();	
	var factory_code = $(obj).parent().parent().find('td').eq(1).attr('id'); 
	var seq = $(obj).attr('id');
	var quantity = $('#q_'+seq).text();
	var price = $('#p_'+seq).text();
	var bool = 0;
	
	$('#product_list_tbody tr').each(function(){
		var p_c = $(this).find('td').eq(0).text();

		if(product_code==p_c){
			bool = 1;
		}
	});
	
	if(bool==1){
		alert('해당제품이 목록에 존재합니다.')
	}else{
	
		let my_table="";
		my_table+= '<tr>';
		my_table+= '<td>' + product_code + '</td>';	
		my_table+= '<td id="'+ factory_code+'">'+ factory_name + '</td>';			
		my_table+= '<td>'+price+'</td>';		
		my_table+= '<td>';
		my_table+= '<form class="form-inline">';			
		my_table+= '<input type="text" value="1" class="form-control is-valid display-3 quantity" style="height: 70%; width : 100px; margin-left: 20px;">';	
		my_table+= '<button type="button" onclick="deleteLine(this)" class="btn btn-danger btn-sm" style="margin-left:10px;"> 제거 </button>'
		my_table+= '</form>';
		my_table+= '<span style="visibility: hidden;">'+price+'</span></td>';
		my_table+= '<td>'+price+'</td>';
		my_table+= '</tr>';	
	
		$('#product_list_tbody').append(my_table);
		$('#productModal').modal('hide');

		$('.quantity').on('keyup',function(){
			var this_price = $(this).parent().parent().parent().find('td').eq(3).find('span').text();
			var quantity = $(this).val();
			
			$(this).parent().parent().parent().find('td').eq(4).html(this_price*quantity);
			
		});	
		
	}
		
}

/* 발주 목록에서 제거 function  */
function deleteLine(obj) {
    var tr = $(obj).parent().parent().parent();
 
    tr.remove();
}
</script>

<!-- Product Detail Modal -->
<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 800px;]">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="productModalLabel">제품 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table align-items-center table-flush" id="allStockList_table">
		
		</table>    
      </div>
      <!-- modal paging part -->
      <div style="margin-left: 300px;" id="modal_paging">
      
	  </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<!-- Product Detail End -->

<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 140px;">
             <h3>본사 -> 제조사 발주</h3>          
             <form class="form-inline" style="margin-top: 25px;">
						<div class="input-group mb-4">
							<div class="input-group-prepend">
								<span class="input-group-text"><i
									class="ni ni-zoom-split-in"></i></span>
							</div>
							<input class="form-control" placeholder="Keyword" type="text"
								id="search_input" style="height: 70%;">
						</div>
						<button type="button" class="btn btn-success btn-sm"
							id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
							<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
							<span class="btn-inner--text">검색</span>
						</button>
						<button type="button" class="btn btn-warning btn-sm"
							id="viewall_btn" style="margin-bottom: 25px;">전체보기</button>
			  </form>
			  
			</div>

			<div class="table-responsive">
				<table class="table align-items-center table-flush" id="my_table">
					<thead class="thead-light">
						<tr>
							<th scope="col">제품코드</th>
							<th scope="col">제조사</th>							
							<th scope="col">단가</th>							
							<th scope="col">재고</th>
							<th scope="col">발주 총가격</th>							
						</tr>
					</thead>
					<tbody id="product_list_tbody">
					<!-- 제조사로 발주할 제품 list -->
					</tbody>
				</table>
				
				<button type="button" class="btn btn-outline-warning" id="order_btn" style="margin-top: 30px; margin-left: 580px; margin-bottom: 30px;">발주</button>
			</div>
		</div>
</div>
</div>    
</div>
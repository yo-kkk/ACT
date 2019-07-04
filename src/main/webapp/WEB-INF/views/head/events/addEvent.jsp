<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.min.css" />
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
	$('#loc').on('change',function(){
		var location_code = $('#loc').val();
		
		$.ajax({
   			type : 'POST',
   	    	url  : 'select_store',
   	    	data : {location_code : location_code},
   	    	async : false,
   	    	success : function(data){   	    		
   	    		$('#store_name').find('option').each(function(){
   	            	$(this).remove();
   	            });
   	    		
   	    		var select_box = '<option disabled selected hidden>지점을 선택하세요</option>';
   	    		
   	    		for(let i=0;i<data.length;i++){
   	            	select_box+='<option value="' + data[i] +'">' + data[i] +'</option>';
   	            }
   	    		
   	            $('#store_name').append(select_box);
   	    	}	
   	    });
		
	});
	
	var CheckIn_minDate = new Date();
	var tempNum = CheckIn_minDate.getDate()+1;
	var CheckOut_minDate = new Date();
	
	CheckOut_minDate.setDate(tempNum);
	
	var checkIn = $("#event_start_date").datepicker({
	   dateFormat : "yy/mm/dd",
	   minDate : CheckIn_minDate
	}).on("change", function() {
	   var date2 = $('#event_start_date').datepicker('getDate', '+1d'); 
	    date2.setDate(date2.getDate()+1); 
	   checkOut.datepicker("option", "minDate",date2);
	}), checkOut = $("#event_end_date").datepicker({
	   dateFormat : "yy/mm/dd",
	   minDate : CheckOut_minDate
	}).on("change", function() {
	   var date3 = $('#event_end_date').datepicker('getDate', '-1d'); 
	    date3.setDate(date3.getDate()-1); 
	   checkIn.datepicker("option", "maxDate", date3);   
	});
	
		/* 이벤트 이름/기간 등록 버튼 클릭 */
		$('.E_Info_btn').click(function() {			
			var event_name = $('#event_name').val();
			var start_date = $('#event_start_date').val();
			var end_date = $('#event_end_date').val();
			
			if(!event_name||!start_date||!end_date){
				alert('이벤트 정보를 등록해주세요');
			}else{
						
				let event_info_table="";
				event_info_table+= '<tr>';
				event_info_table+= '<td>' + event_name + '</td>';			
				event_info_table+= '<td>' + start_date + '</td>';			
				event_info_table+= '<td>' + end_date + '</td>';			
				event_info_table+= '</tr>';			
			
				$('#event_info_body').append(event_info_table);
				$('.E_Info_btn').remove();
		
			}
				
		});
		

		/* 지점 셀렉트박스 선택 */
		$('#store_name').on('change',function(){
			
			var store_name = $(this).val().trim();
			

			let target_stores_table="";	
			target_stores_table+= '<button type="button" onclick="deleteButton(this)" class="btn btn-outline-primary" ';			
			target_stores_table+= 'id="'+store_name+'">';			
			target_stores_table+= store_name+'</button>';			
		
			$('#target_stores_body').append(target_stores_table);
			
		});
		
		//<<<<<<<<<<<<<<<<<<<<<<<<<< 이벤트 등록 버튼 클릭 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		$('#order_btn').click(function() {
						
			var event_e_name= $('#event_info_table').find('tr').eq(1).find('td').eq(0).text();
			var event_s_date= $('#event_info_table').find('tr').eq(1).find('td').eq(1).text();
			var event_e_date= $('#event_info_table').find('tr').eq(1).find('td').eq(2).text();
			
			var target_stores= new Array();
			var product_info= new Array();
			
			var store_bool = 0;
			$('#target_stores_body').each(function(){
				var n = $('#target_stores_body button').length;
				var s_name;
				
				for(i=0; i< n; i++){
				var s_name = $(this).find('button').eq(i).text();
			
				target_stores[i]=new Array(s_name);
				
				store_bool = 1;
				
				}
			});
			
			var product_bool = 0;
			$('#product_info_table tr').each(function(index){
				
				if(index>=1){
					var p_code = $(this).find('td').eq(0).text();
					var p_percent = $(this).find('td').eq(1).find('input').val();
					var p_price = $(this).find('td').eq(2).text();

					product_info[index]=new Array(p_code,p_percent,p_price);
					
					product_bool = 1;
				}
			});

			if(event_e_name==""||event_s_date==""||event_e_date==""){
				alert('이벤트 정보를 등록해주세요.');
			}else{
				
				if(store_bool==0||product_bool==0){
					alert('지점 및 제품을 등록해주세요.')
				}else{
					jQuery.ajaxSettings.traditional = true;
				
					var head_order_confirm = confirm("등록 정보가 정확합니까? \n다시한번 확인해주세요.");
				
					if(head_order_confirm){
					$.ajax({
						type : 'POST',
						url  : 'addEvent',
						data : {
								event_name 	 :	event_e_name,
								start_date : 	event_s_date,
								end_date   : 	event_e_date,
								target_stores:  target_stores,
								product_info : 	product_info	
								},
						async : false,
						success : function(data){
							alert('등록이 완료되었습니다.');
							location.reload();
						}
							
					});
				
					}
				
				}
				
			}
		});
	
	//<<<<<<<<<<<<<<<<<<<<<<<<<< 이벤트 등록 버튼 클릭 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>	
		
	/* 전체보기 버튼클릭*/
	$('#viewall_btn').click(function() {
		ajax_paging(1,'');
	});	
	
	/* 검색어 입력 후 검색버튼 클릭*/
	$('#search_btn').click(function() {
		var keyword = $('#search_product').val();
	     
		if(!keyword){
			alert('검색어를 입력하세요.');	
		}else{
			ajax_paging(1,keyword);
		}
	});
	
});
	/* 데이터픽커 */
    function getDate(element) {
        var date;
        var dateFormat = "yy/mm/dd";
        try {
           date = $.datepicker.parseDate(dateFormat, element.value);
        } catch (error) {
           date = null;
        }
        return date;
     }
	

	/* 목록에서 특정 제품 제거 */
	function deleteLine(obj) {
	    var tr = $(obj).parent().parent().parent();
	    tr.remove();
	};
	
	/* 목록에서 특정 버튼 제거 */
	function deleteButton(store) {
		var store = store.id;
		$('#'+store).remove();
	};
	
	
	/* 페이징 */
	function ajax_paging(pg,keyword){	
		$.ajax({
			type : 'POST',
			url : './product_list',
			data : {
				pg	:	pg,
				keyword : keyword
			},
			async : false,
			success : function(data) {
				let ref = "<tr><th>제품코드</th><th>가격</th></tr>";
				for(let i=0;i<data.length;i++){
					ref+= '<tr>';
					ref+= '<td class="select_productDetail">';
					ref+= '<button type="button" onclick="insert_product(this)" class="btn btn-secondary" id="'+i+'">';
			        ref+= data[i].product_code;
			       	ref+= '</button>';
			       	ref+= '</td>';
					ref+= '<td id="p_'+i+'">'+data[i].price+'</td>'
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
				
				$('#list_modal').modal("show");		
				
				}			
		});		
	}
	
	
	/* 이벤트 적용 상품정보 입력  */
	function insert_product(obj){		
	var product_code = $(obj).text();
	var seq = $(obj).attr('id');
	var quantity = $('#q_'+seq).text();
	var price = $('#p_'+seq).text();
	var bool = 0;
		
	$('#product_info_body tr').each(function(){
		var p_c = $(this).find('td').eq(0).text();
		if(product_code==p_c){
			bool = 1;
		}
	});
	
	if(bool==1){
		alert('해당제품이 목록에 존재합니다.')
	}
	else{
		let my_table = "";                                                                                                                                           
		my_table+= '<tr>';                                                                                                                                       
		my_table+= '<td>' + product_code + '</td>';			                                                                                                   
		my_table+= '<td>';                                                                                                                                       
		my_table+= '<form class="form-inline">';			                                                                                                       
		my_table+= '<input type="text" value="0" class="form-control is-valid display-3 percent" style="height: 70%; width : 100px; margin-left: 20px;">';		
		my_table+= '<button type="button" onclick="deleteLine(this)" class="btn btn-danger btn-sm" style="margin-left:10px;"> 제거 </button>'                      
		my_table+= '</form>';                                                                                                                                    
		my_table+= '<td>' + price + '</td>';	                                                                                                                   
		my_table+= '<td></td>';	                                                                                                                               
		my_table+= '</tr>';  

		$('#product_info_body').append(my_table);
		$('#list_modal').modal('hide');
		
		$('.percent').on('keyup',function(){
			var this_price = $(this).parent().parent().parent().find('td').eq(2).text();
			var percent = $(this).val();
			
			$(this).parent().parent().parent().find('td').eq(3).html(this_price*(100-percent)/100);
	});
		
	}
	}
	
	/* 현재 페이지 */
	function paging_btn(obj){
		var pg = $(obj).text();
		var keyword = $(obj).attr('id');
		ajax_paging(pg,keyword);
	}

	/* 이전 페이지 */
	function paging_before(obj){
		var pg = Number($(obj).find('i').attr('id'))-1;
		var keyword = $(obj).attr('id');
		ajax_paging(pg,keyword);
	}

	/* 다음 페이지 */
	function paging_after(obj){
		var pg = Number($(obj).find('i').attr('id'))+1;
		var keyword = $(obj).attr('id');
		ajax_paging(pg,keyword);
	}
</script>


<!-- Modal -->
<div class="modal fade" id="list_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 800px;">
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
      <div style="margin-left: 300px;" id="modal_paging">
      
	  </div>
      </div>
    </div>
  </div>


<!-- Product Page content -->
<div class="container-fluid mt--7">
	<!-- Table -->
	<div class="row">
<!-- product list box  -->
		<div class="col" id="product_list_div">
			<div class="card shadow">
			<div class="card-header border-0" style="height: 110px;">	
			<form class="form-inline">			
				<h2 class="mb-4" style="margin-right: 20px;">이벤트 등록 페이지</h2>
				<button type="button" class="btn btn-outline-danger btn-sm " style="margin-bottom: 25px;" onclick="location.href='${app}/head/events/1/?keyword='"> 이벤트 목록 보기</button>			
			</form>
				<form class="form-inline">				
					<div style="margin-bottom: 20px;">
						<h3>Step 01 :</h3>
					</div>
						
						<div class="input-group mb-4">
							<input class="form-control" placeholder="이벤트 이름" type="text" placeholder="이벤트 이름" id="event_name" style="height: 70%; margin-left: 10px;">
						</div>
						
						<div class="input-group mb-4" style="margin-left: 10px;">
							<input type="text" class="caleandar form-control"  placeholder="이벤트 시작일"  id="event_start_date" name="event_start_date" style="height: 70%; width: 120px;">
						</div>	
										
						<div class="input-group mb-4" style="margin-left: 10px;">
							<input type="text" class="caleandar form-control"  placeholder="이벤트 종료일" id="event_end_date" name="event_end_date" style="height: 70%; width: 120px;">
						</div>
								
						<button type="button" class="btn btn-danger btn-sm E_Info_btn"  style="margin-left: 20px; margin-bottom: 25px;">
							이벤트 정보 등록
						</button>
				</form>
			</div>
			<hr style="height: 70%;">
			<div style="margin-left: 20px;">
				<form class="form-inline">				
						<div>
							<h3>Step 02 :</h3>
						</div>
						
						<select id="loc" class="form-control" style="margin-left: 20px;">
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
						
						<select id="store_name" class="custom-select form-control" style="margin-left: 20px;" >			
							<option disabled selected hidden>지역을 먼저 선택하세요</option>							
						</select>
				</form>
				
			</div>
			
			<hr style="height: 70%;">
			
			<div style="margin-left: 20px; margin-bottom: 20px;">	
				<form class="form-inline">	
				<div>
					<h3>Step 03 :</h3>
				</div>
					<input class="form-control" placeholder="Keyword" type="text" id="search_product" name="search_product" style="height: 70%; margin-left: 20px;">				
					<button type="button" class="btn btn-success btn-sm" id="search_btn" style="margin-left: 10px;">
					검색
					</button>
					
					<button type="button" class="btn btn-warning btn-sm" id="viewall_btn" >전체보기</button>

				</form>		
						
			</div>
			
				<div class="table-responsive">
					<table class="table align-items-center table-flush table-danger" id="event_info_table">
						<thead class="thead-light">
						<tr>
							<th scope="col">이벤트 이름</th>
							<th scope="col">이벤트 시작일</th>
							<th scope="col">이벤트 종료일</th>
						</tr>
						</thead>
						<tbody id="event_info_body">
						
						</tbody>									
					</table>
				</div>
				<div class="table-responsive" style="margin-top: 30px;">
					<table class="table align-items-center table-flush" id="target_stores_table">
						<thead class="thead-light">
						<tr>
							<th scope="col">할인 대상 지점</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td id="target_stores_body">
							
							</td>
						</tr>
						</tbody>									
					</table>
				</div>
				<div class="table-responsive">
					<table class="table align-items-center table-flush" id="product_info_table">
						<thead class="thead-light">
						<tr>
							<th scope="col">제품 코드</th>
							<th scope="col">할인율</th>
							<th scope="col">할인 미적용 가격</th>
							<th scope="col">할인적용 가격</th>
						</tr>
						</thead>
						<tbody id="product_info_body">
						
						</tbody>									
					</table>
					
					<button type="button" class="btn btn-outline-warning" id="order_btn" style="margin-top: 60px; margin-left: 580px; margin-bottom: 30px;">등록</button>	
				</div>
				
				
			</div>	
			
		</div>
<!-- product list box end -->
	
	</div>
</div>
<br/>
<hr/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Page content -->
<script type="text/javascript">
	$(document).ready(function() {
	
		select_Detail();
		
		$('#search_btn').click(function() {
			var keyword = $('#search_box').val();
			var store_name = '${store_name}';
			
			if(!keyword){
				alert('검색어를 입력하세요.');
			}else{
				$.ajax({
					type : 'POST',
					url : 'search',
					data : {
						keyword : keyword,
						store_name : store_name
					},
					async : false,
					success : function(data) {
						let val_tr = "<tr><th>제품코드</th><th>수량</th></tr>";
						for(let i=0;i<data.length;i++){
							val_tr+= '<tr>';
							val_tr+= '<td class="select_productDetail">';
							val_tr+= '<button type="button" class="btn btn-secondary productBtn" data-toggle="modal" data-target="#exampleModal">';
							val_tr+= data[i].productDTO.product_code;
							val_tr+= '</button>';
							val_tr+= '</td>';
							val_tr+= '<td>'+data[i].quantity+'</td>';
							val_tr+= '</td>';					
						}
						$('#my_table').html(val_tr);
						
						select_Detail();
					}
					
					
				});
			}

		});
		
		$('#refresh_btn').click(function() {
			
			$.ajax({
				type : 'POST',
				url : 'refresh',
				data : {
					store_name : '${store_name}'
				},
				async : false,
				success : function(data) {
					let ref = "<tr><th>제품코드</th><th>수량</th></tr>";
					for(let i=0;i<data.length;i++){
						ref+= '<tr>';
						ref+= '<td class="select_productDetail">';
						ref+= '<button type="button" class="btn btn-secondary productBtn" data-toggle="modal" data-target="#exampleModal">';
	               		ref+= data[i].productDTO.product_code;
	            		ref+= '</button>';
	            		ref+= '</td>';
						ref+= '<td>'+data[i].quantity+'</td>';
						ref+= '</td>';					
					}
					$('#my_table').html(ref);
					
					select_Detail();
					
				}
			});		
		});
			
	});
	
	function select_Detail(){
		$('.productBtn').click(function() {
			var product_code = $(this).text();

			$.ajax({
				type : 'POST',
				url : 'getDetail',
				data : {
					product_code : product_code
				},
				async : false,
				success : function(data) {
					$('#product_code').text("제품코드 : " + data.product_code);
		            $('#product_name').text("제품명 : " + data.product_name);
		            $('#manufact_year').text("제조년도 : " + data.manufact_year + "년");
		            $('#manufact_seas').text("제조시즌 : " + data.manufact_seas);
		            $('#sex').text("성별 : " + data.sex);
		            $('#category1').text("CATEGORY1 : " + data.category1);
		            $('#category2').text("CATEGORY2 : " + data.category2);
		            $('#fit').text("FIT : " + data.fit);
		            $('#color').text("색상 : " + data.color);
		            $('#product_sizes').text("SIZE : " + data.sizes);
		            $('#reg_date').text("제품등록일 : " + data.reg_date);
		            $('#season_off').text("시즌오프 : " + data.season_off);
		            $('#head_stock_quantity').text("본사 재고량 : " + data.head_stock_quantity);
		            $('#img_name').text("이미지 : " + data.img_name);
		            $('#price').text("가격 : " + data.price + "원");
				}
				
			});

		});
	}
</script>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">제품 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <div id="product_name"></div>
      <div id="product_code"></div>
      <div id="price"></div>
      <div id="manufact_year"></div>
      <div id="manufact_seas"></div>
      <div id="reg_date"></div>
      <div id="category1"></div>
      <div id="category2"></div>
      <div id="fit"></div>
      <div id="product_sizes"></div>
      <div id="sex"></div>
      <div id="color"></div>
      <div id="season_off"></div>
      <div id="head_stock_quantity"></div>
      <div id="img_name"></div>

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
              
              <h3 class="mb-0">${store_name} 매장 재고목록</h3>
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  <div class="input-group-prepend">
              <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
          	  </div>
          	  	<input class="form-control" placeholder="Keyword" type="text" id="search_box" style="height: 70%;">
        	  </div>
			  
			  <button type="button" class="btn btn-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  	<span class="btn-inner--text">검색</span>
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;">
              전체보기
              </button>
              </form>
            </div>

<div class="table-responsive">
<table class="table align-items-center table-flush" id="my_table">
	<thead class="thead-light">
	<tr>
		<th scope="col">제품코드</th>
		<th scope="col">수량</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="list">
		<tr>
			<td class="select_productDetail">
				<button type="button" class="btn btn-secondary productBtn" data-toggle="modal" data-target="#exampleModal">
               		${list.productDTO.product_code}
            	</button>
            </td>
			<td>${list.quantity}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>


<!-- 페이징 part-->
<div class="card-footer py-4" >

	<div>
	<form  class="form-inline" method="post">
	<select class="form-control" name="other_select" style="width: 300px;">
		<option disabled selected hidden>타매장 선택하기</option>
		<c:forEach items="${store_list}" var="store_list">
			<c:if test="${store_list!=my_store}">
				<option value="${store_list}">${store_list}
			</c:if>
		</c:forEach>
	</select>
	
	<input type="submit" class="btn btn-default productBtn btn-sm" value="타매장 확인" style="margin-left: 10px;"/>
	
	<input type="button" class="btn btn-danger btn-sm" value="자매장 돌아가기" onclick="location='./'"/>
			
	</form>
</div>
  <nav aria-label="...">
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item disabled">
        <a class="page-link" href="#" tabindex="-1">
          <i class="fas fa-angle-left"></i>
          <span class="sr-only">Previous</span>
        </a>
      </li>
      <li class="page-item active">
        <a class="page-link" href="#">1</a>
      </li>
      <li class="page-item">
        <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
      </li>
      <li class="page-item"><a class="page-link" href="#">3</a></li>
      <li class="page-item">
        <a class="page-link" href="#">
          <i class="fas fa-angle-right"></i>
          <span class="sr-only">Next</span>
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
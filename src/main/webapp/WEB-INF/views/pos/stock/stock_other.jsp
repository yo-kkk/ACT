<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<!-- Page content -->
<script type="text/javascript">
$(document).ready(function() {
	
	select_Detail();
	
	$('#search_btn').click(function() {
		var keyword = $('#search_box').val();
		location.href='${app}/pos/stock/1/${store_name}?keyword='+keyword
	});
	
	$('#other_store_btn').click(function() {
		var other_store = $('#other_select').val();
		location.href='${app}/pos/stock/1/'+other_store+'?keyword=';				
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
	            $('#season_off').text("시즌오프 : " + data.season_off);
	            $('#img_name').html("<img src='./download?fileName=" + data.img_name + "'/>");
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
        <h3 class="modal-title" id="exampleModalLabel">제품 정보</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
            <div style="margin-top: -10px;" class="modal-body">
      
      <div id="product_name"></div>
      <div style="margin-top: 5px;" id="product_code"></div>
      <div style="margin-top: 5px;" id="price"></div>
      <div style="margin-top: 5px;"id="manufact_year"></div>
      <div style="margin-top: 5px;" id="manufact_seas"></div>
      <div style="margin-top: 5px;" id="category1"></div>
      <div style="margin-top: 5px;" id="category2"></div>
      <div style="margin-top: 5px;" id="fit"></div>
      <div style="margin-top: 5px;" id="product_sizes"></div>
      <div style="margin-top: 5px;" id="sex"></div>
      <div style="margin-top: 5px;" id="color"></div>
      <div style="margin-top: 5px;" id="season_off"></div>
      <div>&nbsp;</div>
      <div id="img_name" style="margin-left: 100px;"></div>

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
			  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/pos/stock/1/${store_name}?keyword='">
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
	<select class="form-control" id="other_select" style="width: 300px;">
		<option disabled selected hidden>타매장 선택하기</option>
		<c:forEach items="${store_list}" var="store_list">
			<c:if test="${store_list!=my_store}">
				<option value="${store_list}">${store_list}
			</c:if>
		</c:forEach>
	</select>
	
	<button type="button" class="btn btn-default btn-sm" id="other_store_btn" style="margin-left: 10px;">타매장 확인</button>
	
	<input type="button" class="btn btn-danger btn-sm" value="자매장 돌아가기" onclick="location='./?keyword='"/>
			
	</form>
</div>

  <!-- paging!!! -->
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/stock/1/${store_name}?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/stock/${pageDTO.startBlock-1}/${store_name}?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/pos/stock/${p}/${store_name}?keyword=${keyword}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/pos/stock/${pageDTO.endBlock+1}/${store_name}?keyword=${keyword}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/stock/${pageDTO.totalPage}/${store_name}?keyword=${keyword}" tabindex="-1">
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
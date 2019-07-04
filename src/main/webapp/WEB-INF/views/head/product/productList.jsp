<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
	$(document).ready(function() {	
		
		select_Detail();
		
		$('#search_btn').click(function() {
			var keyword = $('#search_box').val();
			if(!keyword){alert('검색어를 입력하세요.');}
			location.href='${app}/head/product/1/?keyword='+keyword
		});
		
		$('#refresh_btn').click(function() {
			location.href='${app}/head/product/1/?keyword='
		});
		
		$('.update_Btn').click(function(){
			$('#product_code_edit').val($(this).parent().parent().find('td').eq(0).text().trim());
			$('#hiddenform').submit();
		});
		
		$('.delete_Btn').click(function(){
			if(confirm('해당 제품을 삭제하시겠습니까?'))
				
			$.ajax({
				type : 'POST',
				url : '../../product/deleteProduct',
				data : {
					product_code: $(this).parent().parent().find('td').eq(0).text().trim(),
				},
				async : false,
				success : function(data) {
					alert('해당 제품이 삭제되었습니다.');
					location.reload();
				},
				error : function() {
					alert('해당 제품 삭제에 실패했습니다.');
				}
			})			
			location.href='${app}/head/product/1/?keyword='
		});
	});
	
	function select_Detail(){
		$('.productBtn').click(function() {
			var product_code = $(this).text();

			$.ajax({
				type : 'POST',
				url : '../getDetail',
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
		            $('#reg_date').text("제품 등록일 : " + data.reg_date);
		            $('#season_off').text("시즌오프 : " + data.season_off);
		            $('#head_stock_quantity').text("본사 재고량 : " + data.head_stock_quantity);
		            $('#img_name').html("<img src='../download?fileName=" + data.img_name + "'/>");
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
      
      <div style="margin-top: 5px;" id="product_code"></div>
      <div style="margin-top: 5px;" id="product_name"></div>
      <div style="margin-top: 5px;" id="price"></div>
      <div style="margin-top: 5px;" id="category1"></div>
      <div style="margin-top: 5px;" id="category2"></div>
      <div style="margin-top: 5px;" id="fit"></div>
      <div style="margin-top: 5px;" id="product_sizes"></div>
      <div style="margin-top: 5px;" id="color"></div>
      <div style="margin-top: 5px;" id="sex"></div>
      <div style="margin-top: 5px;" id="manufact_year"></div>
      <div style="margin-top: 5px;" id="manufact_seas"></div>
      <div style="margin-top: 5px;" id="season_off"></div>
      <div style="margin-top: 5px;" id="head_stock_quantity"></div>
      <div style="margin-top: 5px;" id="reg_date"></div>
      <div>&nbsp;</div>
      <div>제품 사진</div>
      <div style="margin-top: 5px;" id="img_name"></div>

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
          <div class="card-header border-0">
            <h3 class="mb-0">Product List</h3>
            	<form class="form-inline" style="margin-top:10px;">
	              <div class="input-group mb-4">
	          	  	<div class="input-group-prepend">
	              		<span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
	          	  	</div>
	          	  	<input class="form-control" placeholder="Keyword" type="text" id="search_box" style="height:70%;">
	        	  </div>	  
					  <button type="button" class="btn btn-success btn-sm" id="search_btn" style="margin-left:10px; margin-bottom:25px;">
					  	<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
					  	<span class="btn-inner--text">검색</span>
					  </button>
					  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom:25px;">전체보기</button>
            	</form>
          </div>
          
          <div class="table-responsive">
            <table class="table align-items-center table-flush" id="my_table">
              <thead class="thead-light">
                <tr>
                	<th scope="col">제품 코드</th>
					<th scope="col">본사 재고량</th>
					<th scope="col">제품 정보 수정 및 삭제</th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items="${Productlist}" var="productlist">                
                <tr>                  
		            <td class="productlist">
						<button type="button" class="btn btn-secondary productBtn" data-toggle="modal" data-target="#exampleModal">${productlist.product_code}</button>
		            </td>
                  <td>${productlist.head_stock_quantity}</td>                   
                  <td>
                  	<button type="button" value="수정하기" class="btn btn-primary update_Btn" >수정</button>
                  	<button type="button" value="삭제하기" class="btn btn-primary delete_Btn" >삭제</button>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
            	<form name="hiddenform" id="hiddenform" action="../1/editProduct" method="get">
  				<input type="hidden" id="product_code_edit" name ="product_code">
  			</form>
          </div>
          
  <!-- paging!!! -->
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/product/1/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/product/${pageDTO.startBlock-1}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/product/${p}/?keyword=${keyword}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/product/${pageDTO.endBlock+1}/?keyword=${keyword}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/product/${pageDTO.totalPage}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i>
        </a>
      </li>
       
    </ul>
  </nav>
  <br/>
  
</div>
     <!-- 페이징 part end-->
               
        </div>
      </div>
    </div>    
  </div>
<br/>
<hr/>

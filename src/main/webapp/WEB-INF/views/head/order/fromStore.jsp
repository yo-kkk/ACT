<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<!-- Page content -->
<script type="text/javascript">
$(document).ready(function() {
	/* 제품 상세 정보 모달창 호출 function */
	get_detail();
	
	/* 발송 처리 */
	$('.sendBtn').click(function(){
		var send_yn = $(this).val();
		var store_order_code = $(this).parent().parent().find('td').eq(0).text().trim();
		var product_code = $(this).parent().parent().find('td').eq(4).text().trim();
		var quantity = $(this).parent().parent().find('td').eq(5).attr('id');
		
		if(send_yn == "y"){
			if(confirm("발송완료 처리하시겠습니까?")){
	   		 var frm = makeForm("../../sendAction");
				 frm.appendChild(addData("send_yn",send_yn));
				 frm.appendChild(addData("store_order_code",store_order_code));
				 frm.appendChild(addData("productDTO.product_code",product_code));
				 frm.appendChild(addData("quantity",quantity));
				 $('#fromStorebody').append(frm);
				 frm.submit();	    	   		
			}	
		}else{
			if(confirm("발송완료 처리를 보류하시겠습니까?")){
		   		 var frm = makeForm("../../sendAction");
					 frm.appendChild(addData("send_yn",send_yn));
					 frm.appendChild(addData("store_order_code",store_order_code));
					 frm.appendChild(addData("productDTO.product_code",product_code));
					 frm.appendChild(addData("quantity",quantity));
					 $('#fromStorebody').append(frm);
					 frm.submit();	    	   		
			}
		}
	});		

	/* 	$('#search_btn').click(function() {
	var keyword = $('#search_box').val();
	location.href='${app}/pos/stock/1/?keyword='+keyword
	});
		
	$('#other_store_btn').click(function() {
		var other_store = $('#other_store').val();
		location.href='${app}/pos/stock/1/'+other_store+'?keyword=';				
	}); */
		
});

function makeForm(actionURL) {
    var f = document.createElement("form");
 
    f.action = actionURL;
    f.method = "post";
 
    return f;
}

function addData(name, value) {
	 
    var elem = document.createElement("input");
 
    elem.setAttribute("type", "hidden");
    elem.setAttribute("name", name);
    elem.setAttribute("value", value);
 
    return elem;
}


function get_detail(){
	$('.productBtn').click(function(){
		var product_code = $(this).text().trim();
		
		$.ajax({
			type : 'POST',
			url : '../../getDetail',
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
	            $('#img_name').html("<img src='${app}/head/product/download?fileName=" + data.img_name + "'/>");	            $('#price').text("가격 : " + data.price + "원");
	            $('#price').text("가격 : " + data.price + "원");
			}				
		});
	});
}
</script>

<div id="fromStorebody">

<!-- product detail Modal -->
<div class="modal fade" id="product_detail_modal" tabindex="-1" role="dialog" aria-labelledby="product_detail_modalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="product_detail_modalLabel">제품 정보</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div style="margin-top: -10px;" class="modal-body">
      
      <div id="product_name"></div>
      <div style="margin-top: 5px;" id="product_code"></div>
      <div style="margin-top: 5px;" id="price"></div>
      <div style="margin-top: 5px;" id="manufact_year"></div>
      <div style="margin-top: 5px;" id="manufact_seas"></div>
      <div style="margin-top: 5px;" id="category1"></div>
      <div style="margin-top: 5px;" id="category2"></div>
      <div style="margin-top: 5px;" id="fit"></div>
      <div style="margin-top: 5px;" id="product_sizes"></div>
      <div style="margin-top: 5px;" id="sex"></div>
      <div style="margin-top: 5px;" id="color"></div>
      <div style="margin-top: 5px;" id="season_off"></div>
      <div>&nbsp;</div>
      <div id="img_name"></div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>    
<!-- product detail Modal end -->


 <div class="container-fluid mt--7">
    <!-- Table -->
    <div class="row">
      <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h2 class="mb-0">지점에서 신청한 발주 목록</h2>
            </div>
  
            <div class="table-responsive">

              <table class="table align-items-center table-flush">
            
                <thead class="thead-light">
                  <tr>                    
                  	<th scope="col">수주번호</th>
					<th scope="col">수주일</th>
                  	<th scope="col">지점명</th>
					<th scope="col">수주자</th>
					<th scope="col">제품코드</th>
					<th scope="col">신청수량/본사재고</th>
					<th scope="col">발송여부</th>					
					<th scope="col">수령여부</th>					
				 </tr>
                </thead>              
		    	<tbody>
                <c:forEach items="${list}" var="list">  
                <tr class="fromStore_list btn-outline-default" >              
                    <td>
                      ${list.store_order_code}
                    </td>
                    <td>
                      ${list.order_date}
                    </td>
                    <td>
                      ${list.storeDTO.store_name}
                    </td>
                    <td>
                      ${list.empDTO.name}/( ${list.empDTO.emp_id})
                    </td>                    
					<td class="productBtn" data-toggle="modal" data-target="#product_detail_modal">
                      ${list.productDTO.product_code}
                    </td>
                    <td id="${list.quantity}" style="text-align: center;">
                      ${list.quantity} / (${list.productDTO.head_stock_quantity})
                    </td>
                    <td>
                    <c:if test="${list.send_yn eq 'n'}">  
                     <button type="button" value="y" class="btn btn-danger sendBtn" >미발송</button>                     
                    </c:if>
                    <c:if test="${list.send_yn eq 'y'}">  
                     <button type="button" value="n" class="btn btn-success sendBtn" >발송</button>                     
                    </c:if>
                    </td>
                     <td>
                     <c:if test="${list.send_yn eq 'n'}">   
                       	 <button type="button" class="btn btn-danger" disabled>미발송</button>                                     
                     </c:if>                                         
                     <c:if test="${list.send_yn eq 'y'}">                    
	 					 <c:if test="${list.send_yn eq 'y' and list.receive_yn eq 'n'}">                    
	                     	<button type="button" value="n" class="btn btn-danger" >미수령</button>
	                     </c:if>
	                      <c:if test="${list.receive_yn eq 'y'}">                    
	                     	<button type="button" value="y" class="btn btn-success" >수령</button>
	                     </c:if>
                     </c:if>                    
                     </td>                   
                </tr>     
                </c:forEach>
                </tbody>
    			</table>
 </div>                  			

  <!-- paging!!! -->
  <nav aria-label="..." style="margin: 20px;">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/order/fromStore/1/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/order/fromStore/${pageDTO.startBlock-1}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/order/fromStore/${p}/?keyword=${keyword}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/order/fromStore/${pageDTO.endBlock+1}/?keyword=${keyword}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/pos/stock/${pageDTO.totalPage}/?keyword=${keyword}" tabindex="-1">
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

<br />
<hr />
</div> 
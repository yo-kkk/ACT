<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="app" value="${pageContext.request.contextPath}" />

<jsp:useBean id="now" class="java.util.Date" />

<!-- Page content -->
<script type="text/javascript">
$(document).ready(function() {
	/* 제품 상세 정보 모달창 호출 function */
	get_detail();
		
	/* 발주 취소 처리 (발주 당일만 취소 가능) */
	$('.delete_Btn').click(function(){
		var head_order_code = $(this).parent().parent().find('td').eq(0).text().trim();
		var product_code = $(this).parent().parent().find('td').eq(2).text().trim();

    	if(confirm("주문을 취소할 수 있습니다. 취소하시겠습니까?")){
    		 var frm = makeForm("../cancelHeadOrder");
			 frm.appendChild(addData("head_order_code",head_order_code));
			 frm.appendChild(addData("productDTO.product_code",product_code));
			 $('#tofactorybody').append(frm);
			 frm.submit();	    	   		
		}		  
	});
	
	$('.receiveBtn').click(function(){
		var receive_yn = $(this).val();
		var head_order_code = $(this).parent().parent().find('td').eq(0).text().trim();
		var product_code = $(this).parent().parent().find('td').eq(2).text().trim();
		var quantity = $(this).parent().parent().find('td').eq(3).text().trim();
		alert(product_code);
		
		if(receive_yn == "n"){
			if(confirm("해당 발주건을 수령 처리하시겠습니까?")){
				 var frm = makeForm("../updateReceive");
				 frm.appendChild(addData("receive_yn","y"));				 
				 frm.appendChild(addData("head_order_code",head_order_code));
				 frm.appendChild(addData("productDTO.product_code",product_code));
				 frm.appendChild(addData("quantity",quantity));
				 $('#tofactorybody').append(frm);
				 frm.submit();
			}	
		}else if(receive_yn == "y"){
			if(confirm("해당 발주건을 다시 미수령 처리하시겠습니까?")){
				var frm = makeForm("../updateReceive");
				 frm.appendChild(addData("receive_yn","n"));
				 frm.appendChild(addData("head_order_code",head_order_code));
				 frm.appendChild(addData("productDTO.product_code",product_code));
				 frm.appendChild(addData("quantity",quantity));				 
				 $('#tofactorybody').append(frm);
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
	            $('#img_name').html("<img src='${app}/head/product/download?fileName=" + data.img_name + "'/>");
	            $('#price').text("가격 : " + data.price + "원");
			}				
		});
	});
}


</script>
<div id="tofactorybody">
<!-- Modal -->
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

 <div class="container-fluid mt--7">
    <!-- Table -->
    <div class="row">
      <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h2 class="mb-0">제조사로 신청한 발주 내역</h2>
            </div>
  
            <div class="table-responsive">

              <table class="table align-items-center table-flush">
            
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">발주번호</th>
					<th scope="col">발주일</th>
					<th scope="col">제품코드</th>
					<th scope="col">수량</th>
					<th scope="col">제조사</th>
					<th scope="col">발주자</th>
					<th scope="col">수령여부</th>					
					<th scope="col">발주취소</th>					
				 </tr>
                </thead>
                <tbody>
                <fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate" /> 	                                  
                <c:forEach items="${list}" var="list">  
                <tr class="toFactoryOrder_list btn-outline-default">              
                    <td>
                      ${list.head_order_code}
                    </td>
                    <td>
                      ${list.order_date}
                    </td>
					<td class="productBtn" data-toggle="modal" data-target="#product_detail_modal">
                      ${list.productDTO.product_code}
                    </td>
                    <td>
                      ${list.quantity}
                    </td>
                    <td>
                      ${list.factoryDTO.factory_name}
                    </td>
                    <td>
                      ${list.empDTO.name} ( ${list.empDTO.emp_id})
                    </td>                    
                     <td>
                     <c:if test="${list.receive_yn eq 'n'}">                    
                     	<button type="button" value="n" class="btn btn-danger receiveBtn" >미수령</button>
                     </c:if>
                      <c:if test="${list.receive_yn eq 'y'}">                    
                     	<button type="button" value="y" class="btn btn-success receiveBtn" >수령</button>
                     </c:if>
                     </td>
                    <td>
                     <c:if test="${list.receive_yn eq 'n'}">                                        
	                    <fmt:parseDate value="${list.order_date}" pattern="yyyy-MM-dd kk:mm:ss" var="orderDate01" />
						<fmt:formatDate value="${orderDate01}" pattern="yyyy.MM.dd" var="orderDate02"/>	                  
	                    <c:if test="${orderDate02 ne nowDate}">
	                       <button type="button" value=" ${list.order_date}" class="btn btn-primary delete_Btn" disabled>X</button>
						</c:if>
	                   	 <c:if test="${orderDate02 eq nowDate}">
	                       <button type="button" value=" ${list.order_date}" class="btn btn-primary delete_Btn" >X</button>
						</c:if>
					</c:if>
					  <c:if test="${list.receive_yn eq 'y'}">                    
	                       <button type="button" value=" ${list.order_date}" class="btn btn-primary delete_Btn" disabled>X</button>
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
        <a class="page-link" href="${app}/head/order/toFactory/1/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/order/toFactory/${pageDTO.startBlock-1}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/order/toFactory/${p}/?keyword=${keyword}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/order/toFactory/${pageDTO.endBlock+1}/?keyword=${keyword}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/order/toFactory/${pageDTO.totalPage}/?keyword=${keyword}" tabindex="-1">
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
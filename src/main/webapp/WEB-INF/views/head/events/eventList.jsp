<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(document).ready(function(){				
		$('.eventDeleteBtn').click(function(){
			var delete_confirm = confirm("이벤트를 정말로 삭제하시겠습니까??");
			
			if(delete_confirm == true){
				
				$.ajax({
					type : 'POST',
					url : 'delete',
					data : {
						event_name: $(this).parent().parent().find('td').eq(0).text().trim()
					},
					success : function(result) {
						if(result.msg=="success"){
							alert('삭제 성공');
							location.reload();						
						}else{	
							alert('삭제 실패');
						}
					},
					error : function() {
						alert('다시 시도해 주세요');
					}
					
				});
			}
		});
		
		
		$('.eventDetailBtn').click(function(){
			var e_name 		= $(this).parent().parent().find('td').eq(0).text().trim();
			
			$.ajax({
				type : 'POST',
				url : 'detail',
				data : {
					event_name : e_name
				},
				async : false,
				success : function(result) {
					console.log(result);
 					let ref = "<tr>";
					for(let i=0;i<result.storeList.length;i++){
						ref+= '<td>';
				        ref+= result.storeList[i].store_name;	            		
				       	ref+= '</td>';
				       	if(i%4==3){
				       		ref+='</tr><tr>';
				       	}
						
					}
					$('#eventTargetStore').html(ref);
					
					let ref2 = "";
					for(let i=0;i<result.productList.length;i++){
						ref2+='<tr>';
						ref2+= '<td>';
				        ref2+= result.productList[i].productDTO.product_code;	            		
				       	ref2+= '</td>';
						ref2+= '<td>';
				        ref2+= result.productList[i].discount_rate;	            		
				       	ref2+= '</td>';
						ref2+= '<td>';
				        ref2+= result.productList[i].productDTO.price;	            		
				       	ref2+= '</td>';
						ref2+= '<td>';
				        ref2+= result.productList[i].productDTO.price*(100-result.productList[i].discount_rate)/100;	            		
				       	ref2+= '</td>';
				       	ref2+='</tr>';
					}
					
					$('#eventTargetProduct').html(ref2);
					$('#event_name').html(e_name);
				},
				error : function() {
					alert('다시 시도해주세요');
				}
			});
		});
			 
});	

</script>
	
  <!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              
              <form class="form-inline">
              <h3 class="mb-0" style=" margin-right: 20px;">Event List</h3>
			  <button type="button" id="add_btn" class="btn btn-outline-primary" onclick="location.href='./addEvent'">추가</button>
			  </form>
			</div>                      
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">이벤트 이름</th>
					<th scope="col">이벤트 시작일</th>
					<th scope="col">이벤트 종료일</th>
					<th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="list">  
                <tr>              
                    <td>
                      ${list.event_name}
                    </td>
                    <td>
                      ${list.start_date}
                    </td>
                    <td>
                      ${list.end_date}
                    </td>
                    <td>
                     <button type="button"  class="btn btn-primary eventDetailBtn"  data-toggle="modal"data-target="#exampleModal" >상세정보</button>
                     <button type="button"  class="btn btn-primary eventDeleteBtn" >삭제</button>   
                    </td>   
                </tr>                      
                </c:forEach>
                </tbody>
              </table>
            </div>
            
<!-- paging!!! -->
  <div class="card-footer py-4" >           
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/events/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/events/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/events/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/events/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/events/${pageDTO.totalPage}/" tabindex="-1">
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
<br/>
<hr/>

<!-- Modal -->
<div class="modal fade" id="exampleModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content" style="width:900px; height: 500px;" >
			<div class="modal-header">
				<h3 class="modal-title" id="exampleModalLabel">[<label id="event_name"></label>]의 상세내용</h3>
				<button type="button" class="close" data-dismiss="modal"aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body"  >			
				<div class="table-responsive">
				<form>
					<table class="table align-items-center">
						<thead class="thead-light">
						<tr>
							<th scope="col">이벤트 적용 지점</th>
							<th scope="col"> </th>
							<th scope="col"> </th>
							<th scope="col"> </th>
						</tr>
						<tr id=eventTargetStore>
							
						</tr>
						<tr>
							<th scope="col">이벤트 적용 상품</th>
							<th scope="col">할인율</th>
							<th scope="col">정가</th>
							<th scope="col">할인가</th>
						</tr>
						</thead>
						<tbody id="eventTargetProduct">
							
						</tbody>
					</table>
				</form>
				</div>
			
			</div>
		</div>
	</div>
</div>
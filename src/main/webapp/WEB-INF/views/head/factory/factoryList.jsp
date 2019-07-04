<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
$(document).ready(function(){
	$('.update_Btn').click(function(){
		$('#factory_code').val($(this).parent().parent().find('td').eq(0).text().trim());
		$('#factory_name').val($(this).parent().parent().find('td').eq(1).text().trim());
		$('#supervisor').val($(this).parent().parent().find('td').eq(2).text().trim());
		$('#address').val($(this).parent().parent().find('td').eq(3).text().trim());
		$('#phone').val($(this).parent().parent().find('td').eq(4).text().trim());
		
		$('#hiddenform').submit();
		});
		
		$('.delete_Btn').click(function(){
			$.ajax({
				type : 'POST',
				url : '../factory/deleteFactory',
				data : {
					factory_code: $(this).parent().parent().find('td').eq(0).text().trim(),
					factory_name: $(this).parent().parent().find('td').eq(1).text().trim()
				},
				async : false,
				success : function(data) {
					alert('삭제 성공');
					location.reload();
				},
				error : function() {
					alert('삭제 실패');
				}
			})
		});
		
});
</script>
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
            
            <form class="form-inline">
              <h3 class="mb-0" style=" margin-right: 20px;">Factory List</h3>
			  <button type="button" id="add_btn" class="btn btn-outline-primary" onclick="location.href='/act/head/factory/1/addFactory'">추가</button>
			</form>
			
			</div>          
            
            <div class="table-responsive">

              <table class="table align-items-center table-flush">
            
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">제조사코드</th>
					<th scope="col">제조사이름</th>
					<th scope="col">담당자</th>
					<th scope="col">주소</th>
					<th scope="col">전화번호</th>
					<th scope="col">기타</th>					
				 </tr>
                </thead>

                <tbody>
                <c:forEach items="${list}" var="list">  
                <tr class="factory_list">              
                    <td>
                      ${list.factory_code}
                    </td>
                    <td>
                      ${list.factory_name}
                    </td>
					<td>
                      ${list.supervisor}
                    </td>
                    <td>
                      ${list.address}
                    </td>
                    <td>
                      ${list.phone}
                    </td>
                    <td>
                     <button type="button" value="수정하기" class="btn btn-primary update_Btn" >수정</button>
                     <button type="button" value="삭제하기" class="btn btn-primary delete_Btn" >삭제</button>
                    </td>   
                </tr>     
                </c:forEach>
                </tbody>
    			
              </table>
              	<form id="hiddenform" action="./editFactory" method="get">
    				<input type="hidden" id="factory_code"  name ="factory_code">
    				<input type="hidden" id="factory_name"  name ="factory_name">
    				<input type="hidden" id="supervisor"    name ="supervisor"  >
    				<input type="hidden" id="address"       name ="address"     >
    				<input type="hidden" id="phone"         name ="phone"       >
    			</form>                                 
            </div>
            
  <!-- paging!!! -->
  <div class="card-footer py-4" >           
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/facory/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/factory/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/factory/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/factory/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/factory/${pageDTO.totalPage}/" tabindex="-1">
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
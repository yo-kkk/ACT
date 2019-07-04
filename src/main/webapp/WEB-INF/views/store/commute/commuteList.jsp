<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(document).ready(function(){			
		$('.deleteCommuteBtn').click(function(){
			var delete_confirm = confirm("정말로 삭제하시겠습니까?");
			
			if(delete_confirm == true){
				$.ajax({
					type : 'POST',
					url : 'delete',
					data : {
						emp_id: $(this).parent().parent().find('td').eq(0).text().trim(),
						work_date: $(this).parent().parent().find('td').eq(2).text().trim()
					},
					async : false,
					success : function(data) {
						alert('삭제 성공');
						location.reload();
					},
					error : function() {
						alert('삭제 실패');
					}
				});
			
			}
			
		});
		
		
		$('#updateCommuteBtn').click(function(){
				
			modify($(this));
		});
			 
}); 	
	function modify(obj){
		var emp_id 		= $(obj).parent().parent().find('td').eq(0).text().trim();
		var name 		= $(obj).parent().parent().find('td').eq(1).text().trim();
		var work_date 	= $(obj).parent().parent().find('td').eq(2).text().trim();
		var start_time	= $(obj).parent().parent().find('td').eq(3).text().trim();
		var end_time 	= $(obj).parent().parent().find('td').eq(4).text().trim();
		var etc			= $(obj).parent().parent().find('td').eq(5).text().trim();
		
		
		let my_tr = '';
			my_tr += '<tr>';
			my_tr += '<td>'+emp_id+'</td>';
			my_tr += '<td>'+work_date+'</td>';
			my_tr += '<td>'+start_time+'</td>';
			my_tr += '<td>'+end_time+'</td>';
			my_tr += '<td>'+etc+'</td>';
			my_tr += '</tr>';
		$('#tb_edit').html(my_tr);
		let my_name = name;
		$('#my_name').html(my_name);
		let my_id = emp_id;
		
		$('#edit_btn').click(function(){
			var mod_confirm = confirm("정말로 수정하시겠습니까?");
			
			if(mod_confirm == true){
				
				$.ajax({
					type : 'POST',
					url : 'edit',
					data : {
						emp_id : emp_id,
						work_date: work_date,
						start_time : $('#start_time').val(),
						end_time: $('#end_time').val(),
						etc :	$('#etc').val()
					},
					async : false,
					success : function(data) {
						alert('수정 성공');
						location.reload();
					},
					error : function() {
						alert('수정 실패되었습니다. 출퇴근 시간을 모두 입력해주세요.');
					}
				});
			
			}
		});
	}
	

</script>
	
  <!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
            
            <form class="form-inline">
              <h3 class="mb-0" style=" margin-right: 20px;">Commute List</h3>
			  <button type="button" id="add_btn" class="btn btn-outline-primary" onclick="location.href='./addComm'">추가</button>
			</form>
			
			</div>          
            
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">사원코드</th>
					<th scope="col">사원이름</th>
					<th scope="col">출근일</th>
					<th scope="col">출근시각</th>
					<th scope="col">퇴근시각</th>
					<th scope="col">비고</th>
					<th scope="col">수정</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="list">  
                <tr>              
                    <td>
                      ${list.empDTO.emp_id}
                    </td>
                    <td>
                      ${list.empDTO.name}
                    </td>
					<td>
                      ${list.work_date}
                    </td>
                    <td>
                      ${list.start_time}
                    </td>
                    <td>
                      ${list.end_time}
                    </td>
                    <td>
                      ${list.etc}
                    </td>
                    <td>
                     <button type="button" value="수정하기" onclick="modify(this)" class="btn btn-primary updateCommuteBtn" data-toggle="modal"data-target="#exampleModal">수정</button>
                     <button type="button" value="삭제하기"  class="btn btn-primary deleteCommuteBtn" >삭제</button>
                    </td>   
                </tr>                      
                </c:forEach>
                </tbody>
              </table>
            </div>
<!-- 페이징 part-->
<div class="card-footer py-4" >

  <nav id="paging_part" aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/commute/1/" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/store/commute/${pageDTO.startBlock-1}/" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/store/commute/${p}/" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/store/commute/${pageDTO.endBlock+1}/">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/store/commute/${pageDTO.totalPage}/" tabindex="-1">
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
				<h3 class="modal-title" id="exampleModalLabel"><label id="my_name"></label>님의 근태 수정하기</h3>
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
							<td>수정 전</td>
						</tr>
							<tr>
								<th scope="col">사번</th>
								<th scope="col">날짜</th>
								<th scope="col">출근시간</th>
								<th scope="col">퇴근시간</th>
								<th scope="col">비고</th>	
							</tr>
						</thead>
						<tbody id="tb_edit">
							
						</tbody>
					</table>
				</form>
				<div>
					<table class="table align-items-center">
						<thead class="thead-light">
						<tr>
							<td>수정 후</td>
						</tr>
						<tr>
							<th scope="col">출근시간</th>
							<th scope="col">퇴근시간</th>
							<th scope="col">비고</th>	
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><input type="time"  id="start_time" name="start_time" 	required></td>
							<td><input type="time"  id="end_time"	name="end_time" 	required></td>
							<td><input type="text"  id="etc"		name="etc" 					></td>	
						</tr>
						</tbody>
					</table>
						<button type="button" id="edit_btn"  class="btn btn-secondary edit_complete" >완료</button>
				</div>
				</div>
			</div>
			<div >
			</div>
		</div>
	</div>
</div>
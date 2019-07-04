<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(document).ready(function(){
		$('#success_btn').click(function() {
			var success_confirm = confirm("정말로 삭제하시겠습니까?");
			
			if(success_confirm == true){
				$.ajax({
					type : 'POST',
					url : 'addComm',
					data : {
						emp_id 		: $('#emp_id').val(),
						work_date 	: $('#work_date').val(),
						start_time 	: $('#start_time').val(),
						end_time 	: $('#end_time').val(),
						etc		 	: $('#etc').val()
					},
					async : false,
					success : function(data) {
						alert('등록되었습니다.');
					},
					error : function() {
						alert('다시 시도해주세요!');
					}
				})
			}
	});
});
</script>
<style>

    .card { width: 50rem; margin-top: -50px; height:38rem;  margin-left:23%; border-color: #366ed8;  }
    hr {border-color: #366ed8; padding-bottom: 15px; margin-top: 15px;}
    .label_format {font-size: 20px; padding-right: 50px; padding-bottom: 20px; width:200px;}
    .format {font-size: 20px; padding-right: 20px; padding-bottom: 30px; width: 30rem; }
	.btn{width: 20rem; padding: 15px; margin-top: 20px; }
</style>

               
<div style="align-content : center;">
<div class="card">
  <div class="card-body">
    <h2 class="card-title">근태 등록</h2>
    <hr>
	<table>
		<tr>
			<th class="label_format"><h3>사원이름</h3></th>
			<td class="format">
			
		<select id="emp_id" class="custom-select">			
			<option disabled selected hidden>사원을 선택하세요</option>
			<c:forEach items="${list}" var="list">  
			<option value="${list.emp_id}">${list.name}</option>
			</c:forEach>
		</select></td>
		</tr>
		<tr>
			<th class="label_format"><h3>출근일</h3></th>
			<td class ="format"><input type="date" class="form-control" id="work_date" name="work_date"placeholder='1900-00-00양식' required /></td>
		</tr>
		<tr>
			<th class ="label_format"><h3>출근시간</h3></th>
			<td class ="format"><input type="time" class="form-control" class="form-control"  id="start_time" required /></td>
		</tr>
		<tr>
			<th class ="label_format"><h3>퇴근시간</h3></th>
			<td class ="format"><input type="time" class="form-control" class="form-control"  id="end_time" required /></td>
		</tr>
		<tr>
			<th class ="label_format"><h3>사유</h3></th>
			<td class ="format"><input type="text" class="form-control" class="form-control"  id="etc" required /></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<button type="submit" class="btn btn-outline-dark" id="success_btn">완료</button>
			</td>
		</tr>
	</table>
  </div>
</div>
</div>
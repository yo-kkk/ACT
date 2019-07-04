<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 42%; max-height: 60%;">
      <!-- Table -->
        <div class="card shadow">
        
        <div class="card-header border-0" style="height: 80px;">
        	<h2>지점별 월 목표 설정</h2>                       
        </div>
        
<form action="../factory/1/addFactory" method="POST">
	<div>
		<div class="table-responsive">
			<table class="table align-items-center table-flush">
				<tr>
				<th style="margin-left: 10px;">제조사이름</th>
					<td><input type="text" class="form-control"	class="form-control" id="factory_name" name="factory_name" required placeholder="제조사 이름" style="width: 320px; "/></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">담당자</th>
					<td><input type="text" class="form-control" id="supervisor"	name="supervisor" required placeholder="담당자 이름" style="width: 320px;"/></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">주소</th>
					<td><input type="text" class="form-control"	class="form-control" id="address" name="address" required placeholder="제조사" style="width: 320px;"/></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">전화번호</th>
					<td><input type="tel" class="form-control"	class="form-control" id="phone" name="phone" required placeholder="전화번호" style="width: 320px;"/></td>
				</tr>
				<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-outline-success" id="success_btn">완료</button>
				</td>
				</tr>
			</table>
		</div>
	</div>
</form>    
  	</div>
  </div>
    
<tr>
	<th>지점명</th>
	<td>${employeeDTO.storeDTO.store_name}</td>
</tr>

<tr>
	<th>목표 월</th>
	<td>${monthly_goalDTO.object_month}</td>
</tr>
<tr>
	<th>목표 금액</th>
	<td>${monthly_goalDTO.monthly_target}</td>
</tr>

<tr>
	<td colspan="2">
		<a href="empList">[리스트]</a>
		<a href="${app}/head/empList">게시판 리스트로</a>

	</td>
</tr>

<tr>
	<td colspan="2">
	<div id="commentDisplay"></div>
	</td>
</tr>
</table>

<br/>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

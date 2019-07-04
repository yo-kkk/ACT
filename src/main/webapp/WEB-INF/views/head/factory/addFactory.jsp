<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 42%; max-height: 60%;">
      <!-- Table -->
        <div class="card shadow">
        
        <div class="card-header border-0" style="height: 80px;">
        	<h2>제조사 등록</h2>                       
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
 
<br/>
<hr/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 42%; max-height: 60%;">
      <!-- Table -->
        <div class="card shadow">
        
        <div class="card-header border-0" style="height: 80px;">
        	<h2>제조사 정보 수정</h2>                       
        </div>
        
<form action="../1/editFactory" method="post">
	<div>
		<div class="table-responsive">
			<table class="table align-items-center table-flush">
				<tr>
					<td><input type="hidden" id="factory_code"  name="factory_code" value="${factoryDTO.factory_code}"/> </td>
				</tr>
				
				<tr>
				<th style="margin-left: 10px;">제조사이름</th>
					<td><input type="text" class="form-control"	name="factory_name" id="factory_name"  value="${factoryDTO.factory_name}"  required style="width: 320px;"/> </td>
				</tr>
				
				<tr>
					<th style="margin-left: 10px;">담당자</th>
					<td><input type="text" class="form-control" id="supervisor"	name="supervisor" value="${factoryDTO.supervisor}"  required style="width: 320px;"/></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">주소</th>
					<td><input type="text" class="form-control"	class="form-control" id="address" value="${factoryDTO.address}" name="address" required style="width: 320px;"/></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">전화번호</th>
					<td><input type="tel" class="form-control"	class="form-control" id="phone" value="${factoryDTO.phone}" name="phone" required style="width: 320px;"/></td>
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

	
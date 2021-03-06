<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function() {
		$('#complete').click(function(){
			alert('제품이 등록되었습니다.')
			$('#productInsertForm').submit();
		})
	});
</script>

<!-- Page content -->
<div class="container-fluid mt--7">
	<!-- Table -->
    <div class="row">
      <div class="col">
        <div class="card shadow">
          <div class="card-header border-0">
            <h3 class="mb-0">제품 등록</h3>
          </div>

<form id="productInsertForm" action="upload" method="post" name="myform" enctype="multipart/form-data">
	<div>
		<div class="form-group" style="margin:0 auto" align="center">
			<table>
				
				<tr><td><br/></td></tr>
				<tr><td><br/></td></tr>
				
				<tr>
					<th>제품 이름 &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="product_name" required /></td>
						
					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 제품 가격 &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="price" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 카테고리1 &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="category1" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 카테고리2 &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="category2" required /></td>
				</tr>
				
				<tr><td><br/></td></tr>
				<tr><td><br/></td></tr>
				
				<tr>
					<th>FIT &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="fit" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SIZE &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="sizes" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; COLOR &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="color" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 성별 &nbsp; &nbsp;</th>
					<td>
						<select name ="sex" id="sex" class="custom-select">
							<option value="" selected>----------선택----------
							<option value="M">M
							<option value="F">F
							<option value="U">U
							<option value="K">K</option>
						</select>
					</td>
				</tr>
				
				<tr><td><br/></td></tr>
				<tr><td><br/></td></tr>
				
				<tr>
					<th>제조 년도 &nbsp; &nbsp;</th>
					<td><input type="text" class="form-control" name="manufact_year" required /></td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 제조 시즌 &nbsp; &nbsp;</th>
					<td>
						<select name ="manufact_seas" id="manufact_seas" class="custom-select">
							<option value="" selected>----------선택----------
							<option value="SS">SS
							<option value="FW">FW</option>
						</select>
					</td>

					<th>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 제조사 &nbsp; &nbsp;</th>
					<td>
						<select name ="factory_code" id="factory_code" class="custom-select">
							<option value="" selected>----------선택----------
							<option value="1">민경이네옷공장
							<option value="2">바이오의류공장
							<option value="3">우의성의류공장
							<option value="4">콜네임의류공장</option>
						</select>
					</td>
				</tr>
				
				<tr><td><br/></td></tr>
				<tr><td><br/></td></tr>
				
			</table>
			
		<div class="form-group" style="margin:0 auto" align="center">
			<table>
				<tr><td><br/></td></tr>
				<tr>
					<td colspan="2" align="center">
					<button type="button" id="complete" class="btn btn-primary">완료</button>
					</td>
				</tr>
				<tr><td><br/></td></tr>
			</table>
		</div><br/>

		</div>
	</div>
</form>

        </div>
      </div>
    </div>
</div>
<br/>
<hr/>

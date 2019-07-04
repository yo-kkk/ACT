<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function(){
	$('#r1').on('change',function(){
		var location_code = $('#r1').val();
		
		$.ajax({
			type : 'POST',
	    	url  : '/act/head/emp/select_store',
	    	data : {location_code : location_code},
	    	async : false,
	    	success : function(data){
	    		$('#r2').find('option').each(function(){
	            	$(this).remove();
	            });
	    		
	    		var select_box = null;
	    		
	    		for(let i=0;i<data.length;i++){
	            	select_box+='<option value="' + data[i] +'">' + data[i] +'</option>';
	            }
	            $('#r2').append(select_box);
	    		
	    	}
	    }); 
	});
});
</script>

<!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 42%; max-height: 60%;">
      <!-- Table -->
        <div class="card shadow">
        
        <div class="card-header border-0" style="height: 80px;">
        	<h2>지점별 월 목표 설정</h2>  
        	<hr/>                     
        </div>
        
<form method="post">
	<div>
		<div class="table-responsive">
			<table class="table align-items-center table-flush" style="overflow-x:visible; text-align: center;">
				<tr>
				<th style="margin-left: 10px;">지점 선택</th>
					<td>
							<div>
								<select name ="r1" id="r1" class="custom-select" style="margin-bottom: 20px;">
								<option disabled selected hidden>지역</option>
								<option value="02">서울
								<option value="031">경기도
								<option value="033">강원도
								<option value="041">충남
								<option value="043">충북
								<option value="051">부산
								<option value="053">대구
								<option value="054">경남
								<option value="055">경북
								<option value="042">대전
								</option>
							</select>
							</div>
							<div>	
							<select name ="storesDTO.store_name" id="r2"  class="custom-select">
								<option disabled selected hidden>지점</option>		
							</select>
							</div>												
					</td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">목표월</th>
					<td><input type="month"class="form-control"  id="month" name="object_month" required /></td>
				</tr>
				<tr>
					<th style="margin-left: 10px;">목표 금액</th>
					<td><input type="text" class="form-control"name="monthly_target"  id= "a"required /></td>
				</tr>
				<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-outline-success" >완료</button>
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
        
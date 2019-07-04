<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(document).ready(function() {
		
		var e_id;
		var month;
		
		$('#emp_id').on('change',function(){	
			
			e_id = $(this).val().trim();
			
			$('#month').on('change',function(){		
				month = $(this).val().trim();
				$('#search_btn').click(function () {
					

					$.ajax({
						type : 'POST',
						url  : './seachCommList',
						data : {
							emp_id:  e_id,
							work_date :month	
						},
						async : false,
						success : function(SearchSalaryList){
							let work_minute= 0;
				 			let commList	="<tr>";	
				 			let totalSalary =0;
				 			let total_minute = 0;
				 			
				 			for(let i = 0; i <SearchSalaryList.length; i++){
				 				totalSalary = SearchSalaryList[i].empDTO.salary;
				 				work_minute = SearchSalaryList[i].work_minute;	
				 					
								commList		+= '<td>';			
					 			commList		+= SearchSalaryList[i].empDTO.emp_id;			
				 	 			commList		+= '</td>';			
				 	 			commList		+= '<td>';			
					 			commList		+= SearchSalaryList[i].empDTO.name;			
				 	 			commList		+= '</td>';	
				 	 			commList		+= '<td>';			
					 			commList		+= SearchSalaryList[i].work_date;			
				 	 			commList		+= '</td>';	
				 	 			commList		+= '<td>';			
					 			commList		+= SearchSalaryList[i].start_time;			
				 	 			commList		+= '</td>';	
				 	 			if(SearchSalaryList[i].end_time != null){
				 	 				commList		+= '<td>';			
					 				commList		+= SearchSalaryList[i].end_time;			
				 	 				commList		+= '</td>';	
				 	 			}else{
				 	 				commList		+= '<td>미퇴근</td>';
				 	 			}
				 	 			commList		+= '<td>';			
					 			commList		+= SearchSalaryList[i].empDTO.salary;			
				 	 			commList		+= '</td>';	 			
				 	 			if(work_minute>0){
									commList		+= '<td>';			
						 			commList		+= Math.round(parseInt(SearchSalaryList[i].work_minute));				
					 	 			commList		+= ' 분';
					 	 			commList		+= '</td>';
					 	 			total_minute  	= total_minute + parseInt(SearchSalaryList[i].work_minute);
					 	 			totalSalary  	= SearchSalaryList[i].empDTO.salary*total_minute/60;
				 	 			}else{
				 	 				commList		+= '<td>미적용</td>';
				 	 			}
				 	 			commList		+= '</tr>';	
				 			}

				 			
								$('#commList').html(commList); 
								$('#total_time').html(total_minute); 
								$('#total_sal').html(Math.round(totalSalary)); 
				
							
						},
						error: function(){
							alert('다시 시도해 주세요.');
		
						}
					});
				});
			});
		});
		
        $('#pay_Btn').click(function () {
	       var bs_month =  month;
	       var emp_id = e_id;
	       var monthly_salary = $('#total_sal').text();
	       
		       $.ajax({
				type : 'POST',
				url  : './addSalary',
				data : {
					bs_month:bs_month,
					emp_id:  emp_id,
					monthly_salary :monthly_salary	
				},
				async : false,
				success : function(){
					alert('급여가 지급되었습니다.');
				},
				error: function(){
					alert('다시 시도해 주세요.');
	
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
            <div class="card-header border-0" style="height : 120px;">
              <form class="form-inline">
              <h3 class="mb-0">${store_name} Commute List</h3>
               </form>
              
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  <div class="input-group-prepend">
              <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
          	  </div>
          	  	<select id="emp_id" class="custom-select form-control" style="margin-right: 20px; width: 200px;">			
					<option disabled selected hidden>사원을 선택하세요</option>
					<c:forEach items="${emp_list}" var="emp_list">  
					<option value="${emp_list.emp_id}">${emp_list.name}</option>
					</c:forEach>
				</select>
				
			  
			  
          	  </div>
			  
			  <input type="month" class="form-control"  id="month" name="object_month" required style="margin-bottom: 25px;"/>
			  
			  
			  <button type="button" id="search_btn" class="btn btn-success btn-sm"  style="margin-left: 10px; margin-bottom: 25px;">검색</button>
			  <button type="button" id="pay_Btn" class="btn btn-warning btn-sm" style="margin-bottom: 25px;">급여지급</button>
              
              </form>
            </div>

			<div class="table-responsive ">
			<table class="table align-items-center table-flush">
                <thead class="thead-light" style="margin-top: 40px;">
                  <tr>
                  	<th scope="col">사원코드</th>
					<th scope="col">사원이름</th>
					<th scope="col">출근일</th>
					<th scope="col">출근시각</th>
					<th scope="col">퇴근시각</th>
					<th scope="col">시급</th>
					<th scope="col">근로 시간(분)</th>
                  </tr>
                </thead>
                <tbody id = commList>
                
                </tbody>

                
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">총 근로 시간(분)</th>
                  	<th scope="col">총 급여</th>					
                  </tr>
                </thead>
                <tbody>
	                <tr>
	                	<td id = total_time></td>
	                	<td id = total_sal></td>
	                </tr>
                </tbody>
			</table>
			</div>

</div>
</div>
</div>    
</div>
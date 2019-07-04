<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div id="empListDiv"  class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h3 class="mb-0">Employee List</h3>
            </div>
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">사원코드</th>
					<th scope="col">이름</th>
					<th scope="col">직급</th>
					<th scope="col">근무지점</th>
					<th scope="col">연락처</th>
					<th scope="col">거주지</th>
					<th scope="col">생년월일</th>
					<th scope="col">입사일</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${Emplist}" var="emplist">  
                	<c:if test="${emplist.retire_date eq null}">              
                  <tr class="selectEmpBtn" data-toggle="modal" data-target="#exampleModal" id="${emplist.emp_id}">                                      
                    </c:if>
                	<c:if test="${emplist.retire_date ne null}">              
                  <tr class="selectEmpBtn" data-toggle="modal" style="color : #f5365c;" data-target="#exampleModal" id="${emplist.emp_id}">                                      
                    </c:if>                     
                    <th scope="row" >
                          <span class="mb-0 text-sm">${emplist.emp_id}</span>
                    </th>
                    <th scope="row">
                          <span class="mb-0 text-sm">${emplist.name}</span>
                    </th>
                    <td>                    
                      ${emplist.positionDTO.name}
                    </td>
                    <td>
                      ${emplist.storeDTO.store_name}
                    </td>
                    <td>
                      ${emplist.phone}
                    </td>
                    <td>
                      ${emplist.address}
                    </td>
                    <td>  
					  ${emplist.birthday}
					</td>
                    <td>  
					  ${emplist.hire_date}
                    </td>                          
                   </tr>                 
                </c:forEach>
                </tbody>
              </table>
            </div>

       <!-- 페이징 part-->
            <div class="card-footer py-4">
              <nav aria-label="...">
                <ul class="pagination justify-content-end mb-0">
                  <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">
                      <i class="fas fa-angle-left"></i>
                      <span class="sr-only">Previous</span>
                    </a>
                  </li>
                  <li class="page-item active">
                    <a class="page-link" href="#">1</a>
                  </li>
                  <li class="page-item">
                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item">
                    <a class="page-link" href="#">
                      <i class="fas fa-angle-right"></i>
                      <span class="sr-only">Next</span>
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

<!-- update empInfo Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
  
       <!-- update part start -->      
		<form id="empUpdateForm"  class="table-responsive" action="empUpdate" method="post">
			<input id="hiddenId" type="hidden" name="emp_id"/>
			<input id="posit_code" type="hidden" name="positionDTO.position_code"/>
			<table border="1" class="table align-items-center table-dark">
			<thead class="thead-dark">
        	<tr>
	            <th scope="col">항목</th>
	            <th scope="col">내용</th>
			</tr>
			<tr>
				<th scope="row">지점명</th>			
				<td><input id="storeName"   class="form-control"  type="text" name="storeDTO.store_name" autofocus required/></td>
			</tr>
			<tr>
				<th scope="row">이름</th>
				<td><input id="empName"  class="form-control"  type="text" name="name"  required/></td>
			</tr> 
			<tr>
				<th scope="row">직급</th>
				<td><input id="posit_name"  class="form-control"   type="text" name="positionDTO.name" required/></td>
			</tr>
			<tr>
				<th scope="row">기본급</th>
				<td><input id="salary"  class="form-control"  type="text" name="salary"  required/></td>
			</tr>
			<tr>
				<th scope="row">생년월일</th>
				<td><input id="birth"  class="form-control"  type="text" name="birthday"  required/></td>
			</tr>
			<tr>
				<th scope="row">거주지</th>
				<td><input id="empAddress" class="form-control"  type="text" name="address"  required/></td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td><input id="empPhone"  class="form-control"  type="text" name="phone"  required/></td>
			</tr>
			<tr>
				<th scope="row">입사일</th>
				<td><input  id="hiredate"  class="form-control"  type="text" name="hire_date" disabled/></td>
			</tr>
			<tr>
				<th scope="row">작성자 이름</th>
				<td>등록자 아이디 표시?</td>
			</tr>			
			</table><br/>
		</form>       
       <!-- update part end-->
        <button id="modalClose" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="updateEmpBtn" type="button" class="btn btn-primary">Save changes</button>
      </div>
      <div class="modal-footer">
        <button id="letRetireBtn" type="button" 	class="btn btn-danger">Retire</button> 
        <input  id="retireDate"   name="retireDate" type="date" required/>
        <input  id="deleteEmpId"   name="emp_id" type="hidden" value=""/>
      </div>
    </div>
  </div>
</div>

<script>
$(document).ready(function(){
 	$('.selectEmpBtn').click(function(){

		var emp_id = this.id;
		$.ajax({
			method  : 'GET',
			url	    : 'empUpdate',
			data    : { "emp_id" : emp_id },
			async : false,			
			success : function(data){	
				$('#exampleModalLabel').text('Update Result');				
				$('#hiddenId').val(data.emp_id);
				$('#deleteEmpId').val(data.emp_id);
				$('#storeName').val(data.storeDTO.store_name);
				$('#empName').val(data.name);				
				$('#posit_code').val(data.positionDTO.position_code);				
				$('#posit_name').val(data.positionDTO.name);					
				$('#salary').val(data.salary);
				$('#birth').val(data.birthday);				
				$('#empAddress').val(data.address);				
				$('#empPhone').val(data.phone);
				$('#hiredate').val(data.hire_date);				
			}
		});	
		
		
	}); 

 	//직원 정보 수정 모달창에서 수정버튼 클릭
 	$('#updateEmpBtn').click(function(){

 		var queryString = $("#empUpdateForm").serialize() ;
 		
 		$.ajax({
 			method : 'POST',
 			url	   : 'empUpdate',
 			data   : queryString,
 			success : function(data){	
 				$('#exampleModalLabel').text();
				$('#hiddenId').val(data.emp_id);
				$('#hiddenId').attr("disabled","disabled");
				$('#storeName').val(data.storeDTO.store_name);
				$('#storeName').attr("disabled","disabled");
				$('#empName').val(data.name);				
				$('#empName').attr("disabled","disabled");				
				$('#posit_code').val(data.positionDTO.position_code);				
				$('#posit_name').val(data.positionDTO.name);					
				$('#posit_name').attr("disabled","disabled");					
				$('#salary').val(data.salary);
				$('#salary').attr("disabled","disabled");
				$('#birth').val(data.birthday);				
				$('#birth').attr("disabled","disabled");			
				$('#empAddress').val(data.address);				
				$('#empAddress').attr("disabled","disabled");			
				$('#empPhone').val(data.phone);
				$('#empPhone').attr("disabled","disabled");
				$('#hiredate').val(data.hire_date);				
			}
 		})
 		
 		// 수정완료후 모달창 종료1
		$('.close').click(function(){
			location.reload();		
			$('#retireDate').empty();
		});
 		
 		// 수정완료후 모달창 종료2	
 		$('#modalClose').click(function(){
 			location.reload();					    
			$('#retireDate').empty();
		});
 		
//********* 수정완료후 모달창 종료3 (background mouse click) *********
//********* 수정완료후 모달창 종료4 (press ESC key) *********	
  	});
	
	$('#letRetireBtn').click( function() {
		var retireYN = confirm("are you sure?");

		if(retireYN){
			$.ajax({
				method : 'GET',
				url	   : 'retireEmp',
				data   : {   "retire_date" :  $('#retireDate').val(),
		       				 "emp_id" 	   :  $('#deleteEmpId').val()},
		       	success : function(data){
		       		alert(data.msg);
		       		location.href=data.url;
		       	}
			});		
		}else{
			return;
		}
	});
 	
});


</script>

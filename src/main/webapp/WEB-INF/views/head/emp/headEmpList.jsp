<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<script>
$(document).ready(function(){
	$('#retired').click(function(){
		
		
	});
	
});

</script>

<script type ="text/javascript">
$(document).ready(function(){
	
	$('#search_btn').click(function() {
		var keyword = $('#serchbox').val();
		
		if(!keyword){
			alert('검색어를 입력하세요.');
		}
		
		location.href='${app}/head/emp/empList/1/?keyword='+keyword;
	});
	
	$('#refresh_btn').click(function() {	
		location.href='${app}/head/emp/empList/1/?keyword=';
	});
	
});
</script>
  <!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div id="empListDiv"  class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h2>Employee List</h2>
              <!-- 검색창 -->         
			   
			  	<form class="form-inline" style="margin-top:10px;">
	              <div class="input-group mb-4">
	          	  	<div class="input-group-prepend">
	              		<span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
	          	  	</div>
					<input class="form-control" placeholder="사원이름" type="text" id="serchbox" style="height: 70%;">
	        	  </div>	         	  
                <button type="button" class="btn btn-success btn-sm" id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
              		<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span>
			  		<span class="btn-inner--text">검색</span>
			    </button>
					  <button type="button" class="btn btn-warning btn-sm" id="refresh_btn" style="margin-bottom:25px;">전체보기</button>	
						
            	</form>			  			  	
			    <!-- 검색창 -->
			    <span class="mb-0" style="color: red;">※ 빨간색으로 표시된 사원은 퇴사자입니다.</span>
			    
            </div>
            <div class="table-responsive">
              <table class="table align-items-center table-flush" id="inputbox">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col">사원코드</th>
					<th scope="col">이름</th>
					<th scope="col">직급</th>
					<th scope="col">근무지점</th>
					<th scope="col">입사일</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${Emplist}" var="emplist">  
                	<c:if test="${emplist.retire_date eq null}">              
                  <tr class="selectEmpBtn btn-outline-default" data-toggle="modal" data-target="#exampleModal" id="${emplist.emp_id}">                                      
                    </c:if>
                	<c:if test="${emplist.retire_date ne null}">              
                  <tr class="selectEmpBtn btn-outline-default" data-toggle="modal" style="color : #f5365c;" data-target="#exampleModal" id="${emplist.emp_id}">                                      
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
					  ${emplist.hire_date}
                    </td>                          
                   </tr>                 
                </c:forEach>
                </tbody>
              </table>
            </div>

  <!-- paging!!! -->
  <nav aria-label="..." style="margin: 20px;">
  
    <ul class="pagination" style="justify-content: center;">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/emp/empList/1/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/emp/empList/${pageDTO.startBlock-1}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>     
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/emp/empList/${p}/?keyword=${keyword}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/emp/empList/${pageDTO.endBlock+1}/?keyword=${keyword}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/emp/empList/${pageDTO.totalPage}/?keyword=${keyword}" tabindex="-1">
          <i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i>
        </a>
      </li>
       
    </ul>
  </nav>
  <br/>
           
          </div>
        </div>
      </div>    
    </div>
<br/>
<hr/>

<!-- update empInfo Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 900px;">
    <div class="modal-content">
      <div class="modal-header" style="padding-bottom: 0px;">
        <h1 class="modal-title" id="exampleModalLabel"></h1>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <!-- modal-body start  -->
      <div class="modal-body">
       <!-- update part start -->      
		<div class="table-responsive" style="padding-bottom: 0px;">    
		<form id="empUpdateForm"  class="table-responsive" action="empUpdate" method="post">
			<input id="hiddenId" type="hidden" name="emp_id"/>
			<input id="posit_code" type="hidden" name="positionDTO.position_code"/>
			
			<table class="table align-items-center">
			<thead class="thead-light">
	        	<tr>
		            <th scope="col">항목</th>
		            <th scope="col">내용</th>
				</tr>				            
			</thead>
			<tbody>
			<tr>
				<th scope="col">지점명</th>			
				<td><input id="storeName"   class="form-control"  type="text" name="storeDTO.store_name" autofocus required/></td>
			</tr>
			<tr>
				<th scope="col">이름</th>
				<td><input id="empName"  class="form-control"  type="text" name="name"  required/></td>
			</tr> 
			<tr>
				<th scope="col">직급</th>
				<td><input id="posit_name"  class="form-control"   type="text" name="positionDTO.name" required/></td>
			</tr>
			<tr>
				<th scope="col">기본급</th>
				<td><input id="salary"  class="form-control"  type="text" name="salary"  required/></td>
			</tr>
			<tr>
				<th scope="col">생년월일</th>
				<td><input id="birth"  class="form-control"  type="text" name="birthday"  required/></td>
			</tr>
			<tr>
				<th scope="col">거주지</th>
				<td><input id="empAddress" class="form-control"  type="text" name="address"  required/></td>
			</tr>
			<tr>
				<th scope="col">연락처</th>
				<td><input id="empPhone"  class="form-control"  type="text" name="phone"  required/></td>
			</tr>
			<tr>
				<th scope="col">입사일</th>
				<td><input  id="hiredate"  class="form-control"  type="text" name="hire_date" disabled/></td>
			</tr>
			<tr>
				<th scope="col">작성자 이름</th>
				<td>등록자 아이디 표시?</td>
			</tr>
			</tbody>				
			</table>
		</form>       
       <!-- update part end-->
      </div>
      <div class="modal-footer" style="padding: 0px;">
        <input class="form-control datepicker" id="retireDate"   name="retireDate" type="date" required/>
        <button id="letRetireBtn" type="button" 	class="btn btn-danger">Retire</button> 
        <input  id="deleteEmpId"   name="emp_id" type="hidden" value=""/>
        <button id="updateEmpBtn" type="button" class="btn btn-primary">Save changes</button>
      </div>
      <!-- modal-body end -->
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
			url	    : '../../empUpdate',
			data    : { "emp_id" : emp_id },
			async : false,			
			success : function(data){	
				$('#exampleModalLabel').text(data.name+"("+data.emp_id +")");
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
 			url	   : '../../empUpdate',
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
				url	   : '../../retireEmp',
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>

 <!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 55%; max-height: 70%;">
      <!-- Table -->
          <div class="card shadow">
            <div class="card-header border-0" style="height: 40px;">
              <h2>직원 등록</h2>                       
            </div>
            
            
             <form method="post" style="padding: 30px;">
                                         
            	<div class="table-responsive" style="overflow-x:visible">
            	
                <div class="row">
                  <div class="col">
                    <div class="form-group" style="width: 200px;">
                      <div class="input-group mb-4">        
                      	<input type = "text"  placeholder="이름"  class="form-control"  name="name" required>             
                      </div>
                    </div>
                  
                    <div class="form-group" style="width: 600px;">
                   		<div class="input-group-prepend">
                          <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; border: 1px; font-size: 0.9rem">생년월일</span>                  		
                  		  <input type="date"  id="inputName" class="form-control"name="birthday" placeholder='1900-00-00양식' required style="margin-left: 10px; width: 200px;"/>
                      	  <input type="tel" class="form-control" placeholder="연락처" name="phone" required style="margin-left: 20px;"/>
                      </div>
                    </div>
                
                 </div>
                 </div>
                                                   
                <div class="row">
                  <div class="col">
                    <div class="form-group" style="width: 600px";>                 
					<input placeholder="거주지" type="text" class="form-control" name="address" required />
                    </div>
                  </div>
                </div>
                
                 <div class="row">
                   <div class="col">
						<div class="form-group" style="width: 600px;">
                        <div class="input-group-prepend">
                         <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; font-size: 0.9rem;">직급</span>      				    
				         <select name= "positionDTO.position_code" class="form-control" style="margin-left: 10px; width: 200px;"> 
					 		<option disabled selected hidden>직급</option>
					 		<option value="6">아르바이트</option>
				 		</select>
				         <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; border: 1px; font-size: 0.9rem; margin-left: 20px;">근무지점</span>
                         
                          <select id="emp_id" class="custom-select" style="margin-left: 10px;">			
							<option value='${list.emp_id}'>${list.storeDTO.store_name}</option>			
						  </select>
				 		  <input type="hidden" name="storeDTO.store_name" value="${list.storeDTO.store_name}"/>
                         </div>				      
                  		 </div> 
                   </div>

                  </div>
                  
                  <div class="row">
                  <div class="col">
                  <div class="form-group" style="width: 300px;">
                  <div class="input-group-prepend">
                      <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; border: 1px; font-size: 0.9rem;">입사일</span>                  
				      <input type="date"class="form-control" id="inputName" name="hire_date" placeholder='1900-00-00양식' required style="margin-left: 20px;"/>
				  </div>	
				  </div>	
				  </div>
				  
                  </div>                              
            	  </div> 
            <div>
            <span style="float: right;"><input type="submit" class="btn btn-success" value="완료" style="width: 100px;"/></span>
              </div>
            </form>  
  		<br/>
          </div>
    
    </div>
 
<br/>
<hr/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>

     <script type="text/javascript">        
               $(document).ready(function(){           	 
               	$('#r1').on('change',function(){
               		$('#r2').removeAttr('disabled');
               		var location_code = $('#r1').val();
               		
               		if(location_code == 000){
               			$('#r2').find('option').each(function(){
           	            	$(this).remove();
           	            });
               			$('#r2').attr('disabled','disabled');
               		}else{
               			$.ajax({
                   			type : 'POST',
                   	    	url  : 'select_store',
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
               		}              		 
               	});
               });
               </script>
               
               <script>
		   var replaceChar = /[~!@\#$%^&*\()\=+_'\;<>\/.\`:\"\\,\[\]?|{}ㄱ-ㅎㅏ-ㅣ]/gi;
               $(document).ready(function(){
                   $("#inputName").on("focusout", function() {
                       var x = $(this).val();
                       if (x.length > 0) {
                           if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
                               x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
                           }
                           $(this).val(x);
                       }
                       }).on("keyup", function() {
                           $(this).val($(this).val().replace(replaceChar, "-"));
               
                  });
               });       
               </script>

 <!-- Page content -->
    <div class="container-fluid mt--7" style="max-width: 50%; max-height: 70%;">
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
							<input type="text" placeholder="이름" class="form-control"  name="name" required />
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
					<input placeholder="거주지" type="text" class="form-control"name="address" required />            
                    </div>
                  </div>
                </div>
                
                 <div class="row">
                   <div class="col">
						<div class="form-group" style="width: 600px;">
                        <div class="input-group-prepend">
                         <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; font-size: 0.9rem;">직급</span>      
				         <select name ="positionDTO.position_code" class="form-control" style="margin-left: 20px; width: 200px;">
					         <option disabled selected hidden>직급</option>
					         <option value="2">임원
					         <option value="3">본사직원
					         <option value="4">점장
					         <option value="5">지사직원
					         <option value="6">아르바이트
					         </option>
				         </select>
				         
				         <span class="input-group-text" style="margin-right: 2px; background-color: #AFDDFA; color: black; border: 1px; font-size: 0.9rem; margin-left: 20px;">근무지점</span>
                         
                         <select name ="storeDTO.location" id="r1" class="form-control custom-select" style="margin-right: 2px; width: 160px; margin-left: 10px;">
						    <option disabled selected>지역</option>  
							<option value="000" >본점</option>                              
							<option value="02">서울</option>                                
							<option value="031">경기도</option>                              
							<option value="033">강원도</option>                              
							<option value="041">충남</option>                               
							<option value="043">충북</option>                               
							<option value="051">부산</option>                               
							<option value="053">대구</option>                               
							<option value="054">경남</option>                               
							<option value="055">경북</option>                               
				 		 </select>
				 		 
				 		 <select name ="storeDTO.store_name" id="r2" class="custom-select" style="margin-left: 10px; width: 300px;">
							<option disabled selected hidden>지점</option>		
						 </select>
				 		 
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

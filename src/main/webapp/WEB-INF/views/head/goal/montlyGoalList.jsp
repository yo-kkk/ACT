<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
$(document).ready(function() {

	$('#search_btn').click(function() {
		var year = $('#year').val();
		
		var month = $('#month').val();
		
		if(!year||!month){
			alert('년/월 일을 지정해주세요.');
		}else{
			location.href='${app}/head/goal/goalList/1/?store=${store_name}&when='+year+'-'+month;
		}
	});
	
	$('.title_btn').click(function(){
		var date = $(this).text().replace(/[/]/g,'-');
		location.href='${app}/head/transact_l/1/?when='+date;
		
	})
	
	$('#loc').on('change',function(){
		
		
   		var location_code = $('#loc').val();
   		
   		$.ajax({
   			type : 'POST',
   	    	url  : 'select_store',
   	    	data : {location_code : location_code},
   	    	async : false,
   	    	success : function(data){
   	    		$('#store_select').find('option').each(function(){
   	            	$(this).remove();
   	            });
   	    		
   	    		var select_box = null;
   	    		
   	    		for(let i=0;i<data.length;i++){
   	            	select_box+='<option value="' + data[i] +'">' + data[i] +'</option>';
   	            }
   	    		
   	            $('#store_select').append(select_box);
   	         
   	         	$('#store_select_btn').click(function() {
   	        	 	var store = $('#store_select').val();
   	        	 	location.href='${app}/head/goal/goalList/1/?store='+store+'&when=';
   	         	
   	         	});
   	      }
   	    	
   	    }); 
   	});
});
</script>



<!-- <script type ="text/javascript">


$(document).ready(function(){
	$('#monthtt').on('change',function(){
		var month = $('#monthtt').val() 
	
		
		$.ajax({
			type: 'POST',
			url :'select_month',
			data: {month : month},
			async :false,
			success : function(data){
			
   	         let var_tr =  "<tr ><th class='oing'>지점명</th><th >목표 월</th><th >목표금액</th><th >금액</th></tr>"
   	        	for(let i=0;i<data.length;i++){
   	        		var_tr+= ' <tr>';
   	        		var_tr+=  ' <td>';
   	        		var_tr+=     data[i].storesDTO.store_name;
   	        		var_tr+=  '  </td>';
   	        		var_tr+=   ' <td>';
   	        		var_tr+=      data[i].object_month;
   	        		var_tr+=   ' </td>';
   	        		var_tr+=  '  <td>';
   	        		var_tr+=      data[i].monthly_target;
   	        		var_tr+=  '  </td>';
   	        		var_tr+=  '          <td>';
   	        		var_tr+=  data[i].monthly_income; 
   	        		var_tr+=  '  </td>';
   	        		var_tr+= '</tr>';
   	        		
   	        	}
   	      $('#inputbox').html(var_tr);
   	 
			}     	 
			
		});
		
	
		
	});
}); -->
</script>
<!-- Page content -->
    <div class="container-fluid mt--7">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0" style="height : 200px;">
              <form class="form-inline">
                     
              <select id="loc" class="form-control" >
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
			  
			  <select id="store_select" class="form-control" style="margin-left: 20px;">
				<option disabled selected hidden>지점</option>		
			  </select>
			         
			  <button type="button" class="btn btn-outline-warning btn-sm" id="store_select_btn" style="margin-left: 20px;">
              지점조회
              </button>
			                
              </form>
              <form  class="form-inline" style="margin-top: 10px;">
              
              <div class="input-group mb-4">
          	  
          	  	<select class="form-control" id="year" style="width: 120px;">
					<option disabled selected hidden>년도</option>
					<option value="2019">2019년</option>
					<option value="2020">2020년</option>
					<option value="2021">2021년</option>
					<option value="2022">2022년</option>
					<option value="2023">2023년</option>
					<option value="2024">2024년</option>
				</select>
				
				<select class="form-control" id="month" style="width: 80px;">
					<option disabled selected hidde>월</option>
					<option value="01">1월</option>
					<option value="02">2월</option>
					<option value="03">3월</option>
					<option value="04">4월</option>
					<option value="05">5월</option>
					<option value="06">6월</option>
					<option value="07">7월</option>
					<option value="08">8월</option>
					<option value="09">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
				</select>
          	  </div>
			  
			  <button type="button" class="btn btn-outline-success btn-sm"id="search_btn" style="margin-left: 10px; margin-bottom: 25px;">
			  월별로 검색
			  </button>
			  <button type="button" class="btn btn-warning btn-sm" id="all_btn" style="margin-bottom: 25px;" onclick="location.href='${app}/head/goal/goalList/1/?store='+store+&when='+year+'-'+month;">
              전체보기
              </button>
              </form>
                 
              <h3 class="mb-0">${store_name} 지점 <c:if test="${when!=''}">(${when})</c:if> 월 목표/월 총수익 조회 </h3>
            </div>

 <!--  
    <div class="container-fluid mt--7">
      Table
      <div id="empListDiv"  class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h3 class="mb-0">월</h3>
              </div></div>
  				<div id="boxbox">
  		             <input type="month" id="monthtt" name="monthtt"> 
  		        
          	</div> -->
			   
			    
	
            
            <div class="table-responsive">
              <table class="table align-items-center table-flush" id="inputbox">
                <thead class="thead-light">
                  <tr>
                  	<th scope="col" class="boxbbb">지점명</th>
					<th scope="col">목표 월</th>
					<th scope="col">목표금액</th>
					<th scope="col">금액 </th>
					<th scope="col">달성률</th>
					
			
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${Emplist}" var="emplist">  
       
                    <td >
                      ${emplist.storesDTO.store_name}
                    </td>
                    <td class="month">
                      ${emplist.object_month}
                    </td>
                    <td class ="target">
                      ${emplist.monthly_target}
                    </td>
                    <td class="income">
                    ${emplist.monthly_income} 
                    </td>
                   
                     <td class="percent">
                    <c:if test="${emplist.monthly_income >= emplist.monthly_target}">
						${Math.round(((emplist.monthly_income - emplist.monthly_target)/emplist.monthly_income) * 100/2)} %
                    </c:if>
                    <c:if test="${emplist.monthly_income < emplist.monthly_target}">
						0 %
                    </c:if>
                    </td>
                  
                
                                      
                   </tr>                 
                </c:forEach>
                </tbody>
              </table>
              </div>
            </div></div>

</div>
<!-- 페이징 part-->

<div class="card-footer py-4" >
	<div>

</div>

  <!-- paging!!! -->
  <nav aria-label="...">
  
    <ul class="pagination justify-content-end mb-0">
      <li class="page-item <c:if test="${pageDTO.pg==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/goal/goalList/1/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i>
        </a>
      </li>
    
      <li class="page-item <c:if test="${pageDTO.startBlock==1}">disabled</c:if>">
        <a class="page-link" href="${app}/head/goal/goalList/${pageDTO.startBlock-1}/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-left"></i>
        </a>
      </li>
      
      <c:forEach var="p" begin="${pageDTO.startBlock}" end="${pageDTO.endBlock}">
      	<li class="page-item <c:if test="${p==pageDTO.pg}"> active </c:if>">
        	<a <c:if test="${p!=pageDTO.pg}"> href="${app}/head/goal/goalList/${p}/?store=${store_name}&when=${when}" </c:if>class="page-link">${p}</a>
      		<c:if test="${p==pageDTO.pg}"><span class="sr-only">(current)</span> </c:if>
      	</li>
      </c:forEach>
      
      <li class="page-item <c:if test="${pageDTO.endBlock==pageDTO.totalPage}">disabled</c:if>" >
        <a class="page-link" href="${app}/head/goal/goalList/${pageDTO.endBlock+1}/?store=${store_name}&when=${when}">
          <i class="fas fa-angle-right"></i>
        </a>
      </li>
      
      <li class="page-item <c:if test="${pageDTO.pg==pageDTO.totalPage}">disabled</c:if>">
        <a class="page-link" href="${app}/head/goal/goalList/${pageDTO.totalPage}/?store=${store_name}&when=${when}" tabindex="-1">
          <i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i>
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


<br />
<hr />
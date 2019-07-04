<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="app" value="${pageContext.request.contextPath}" />	
	
<script type="text/javascript">
	
	  $(document).ready(function () {
	        $('#checkMember').click(function () {
		        $('.select').prop('checked', this.checked );//전체선택
	        });
	        
	        $("#agreeBtn").click(function(){
	         	$("#selectCheck").attr({
					"method" : "post",
					"action" : "./paySalary",
					"data":""
				
				});
				$("#selectCheck").submit();
				alert('월급이 지급되었습니다. ')
				location.reload();
			});               
		});
		
</script>
  <!-- Page content -->
    <div class="container-fluid mt--10">
      <!-- Table -->
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
              <h3 class="mb-0">월급지급 List</h3>
            </div>            
            <div class="table-responsive">
             	<button type="button" id="agreeBtn" class="btn btn-primary agreeBtn" >월급지급</button>
                <button type="button"  id="disagreeBtn" class="btn btn-primary disagreeBtn" onclick="location.href='./pastSalaryList/1?when=&store='">월급 지급 내역</button>
            <form id = "selectCheck">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th width="30pt"  align="center"><input type="checkbox" id="checkMember" name="checkAll" value="selectAll" /></th>
                  	<th scope="col">지점</th>
					<th scope="col">목표 월</th>
					<th scope="col">목표 금액</th>
					<th scope="col">달성 금액</th>
					<th scope="col">성과급 지급 %</th>
					<th scope="col">지급 여부</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="list">  
                <tr>
                	<td width="30pt"  align="center"><input type="checkbox" id="checkMember" name="checkMember" class="select" value="${list.object_month}_${list.storesDTO.store_name}"/></td>              
                    <td>
                      ${list.storesDTO.store_name}
                    </td>
                    <td>
                      ${list.object_month}
                    </td>
                    <td class="target">
                      ${list.monthly_target}
                    </td>
                    <td class="income">
                      ${list.monthly_income}
                    </td>
                    <td class="percent">
                    <c:if test="${list.monthly_income >= list.monthly_target}">
						${Math.round(((list.monthly_income - list.monthly_target)/list.monthly_income) * 100/2)} %
                    </c:if>
                    <c:if test="${list.monthly_income < list.monthly_target}">
						0 %
                    </c:if>
                    </td>
                    <td>
                       ${list.pay_yn}
                    </td>   
                </tr>                      
                </c:forEach>
                </tbody>
              </table>
             </form>
            </div>           
          </div>
        </div>
      </div>    
    </div>
<br/>
<hr/>
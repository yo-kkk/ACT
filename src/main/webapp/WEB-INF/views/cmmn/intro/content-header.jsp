<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Header -->

<script type="text/javascript">
	$(document).ready(function(){
		$('#go_btn').click(function() {
			$.ajax({
				type : 'POST',
				url : 'go',
				async : false,
				success : function(data) {
					alert('${userInfo.name}님 오늘 하루도 잘 부탁드립니다. \n${userInfo.name}님의 출근 시각은 ' + data + ' 입니다.');
				},
				error : function() {
					alert('이미 출근하셨습니다. 확인 부탁드립니다.');
				}
			})
		});

		$('#leave_btn').click(function() {
			$.ajax({
				type : 'POST',
				url : 'leave',
				async : false,
				success : function(data) {
					alert('${userInfo.name}님 오늘 하루도 수고 많으셨습니다. \n${userInfo.name}님의 퇴근 시각은 ' + data +' 입니다.');
				},
				error : function() {
					alert('아직 출근을 안 하셨습니다. 확인 부탁드립니다.');
				}
			})
		});
		
		$('#src_btn').click(function() {
			$.ajax({
				type : 'POST',
				url : '../Intro/commute',
				data : {
						start 	: $('#start').val(),
						end		: $('#end').val()
						},
				async : false,
				success : function(data) {
					let my_td = '';
					$.each(data, function(key, val){
						my_td += '<tr>';
						my_td += '<td>' + val['work_date'] + '</td>';
						my_td += '<td>' + val['start_time'] + '</td>';
						my_td += '<td>' + val['end_time'] + '</td>';
						my_td += '<td>' + val['etc'] + '</td>';
						my_td += '</tr>';
					});
					$('#my_commute').html(my_td);
				},
				error : function() {
					alert('날짜 검색에 실패했습니다.');
				}
			})
		});
		
});
</script>
<div class="header bg-gradient-primary py-7 py-lg-8">
	<div class="container">
		<div class="header-body text-center mb-3">
			<div class="row justify-content-center">
				<div class="col-lg-5 col-md-6">
					<button type="button" class="btn btn-primary" id="go_btn">출근하기</button>
					<button type="button" class="btn btn-primary" id="leave_btn">퇴근하기</button>
					<!-- Button trigger modal -->
					<button type="button" value="근태확인" id="commute_btn"class="btn btn-primary" data-toggle="modal"data-target="#exampleModal">근태확인</button>
				</div>
			</div>
		</div>
	</div>
	<div class="separator separator-bottom separator-skew zindex-100">
		<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none"
			version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="exampleModal"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content" style="width: 600px; height: 600px;" >
			<div class="modal-header">
				<h3 class="modal-title" id="exampleModalLabel">${userInfo.name}님의 출퇴근 내역 (최대 10개 출력)</h3>
				<button type="button" class="close" data-dismiss="modal"aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body" >
			<div class="input-daterange datepicker row align-items-center">
			    <div class="col">
			        <div class="form-group">
			            <div class="input-group input-group-alternative">
			                <div class="input-group-prepend">
			                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
			                </div>
			                <input id="start" class="form-control" placeholder="Start date" type="text" required/>
			            </div>
			        </div>
			    </div>
			    
			    <div class="col" style="margin-left: -10px;">
			        <div class="form-group">
			            <div class="input-group input-group-alternative">
			                <div class="input-group-prepend">
			                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
			                </div>
			                <input id="end" class="form-control" placeholder="End date" type="text" required >
			            </div>
			        </div>
			    </div>
			    
				<button type="button" id="src_btn" class="btn btn-secondary" style="margin-bottom: 23px;">검색</button>
				
			</div>
			
				
				<div class="table-responsive">
					<table class="table align-items-center">
						<thead class="thead-light">
							<tr>
								<th scope="col">날짜</th>
								<th scope="col">출근시간</th>
								<th scope="col">퇴근시간</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody id="my_commute">
						<c:forEach items="${list}" var="list">
							<tr>
							<td>${list.work_date}</td>
							<td>${list.start_time}</td>
							<td>${list.end_time}</td>
							<td>${list.etc}</td>
							</tr>
						</c:forEach>	
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
	</div>
</div>




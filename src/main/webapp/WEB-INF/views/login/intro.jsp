<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Page content -->
    <div class="container mt--6 pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-6 col-md-7">
          <div class="card bg-secondary shadow border-0" style="height : 440px; width: 640px; margin-left: -40px;">
            <div class="card-header bg-transparent" style="padding-bottom: 5px;">
	          <div class="justify-content-center text-center">
	              <div><h1>Be pride of ACT</h1></div>
	              <div><p class="text-lead">업무를 선택해 주세요!</p></div>
	          </div>
            </div>
         
            <div class="card-body px-lg-6 py-lg-5" style="margin-top: -15px;">
	            <div class="row"  style="height: 240px; padding-bottom: 3px;">
				    <button type="button" class="col-sm btn btn-primary" onclick="location='../pos/'">   <h3 style="color: white">포스     </h3> </button>
				    <button type="button" class="col-sm btn btn-success" onclick="location='../store/'"> <h3 style="color: white">지점관리 </h3> </button>
				    <button type="button" class="col-sm btn btn-warning" onclick="location='../head/'" >  <h3 style="color: white">본사     </h3> </button>
			    </div>                    
            </div>
            
          </div>        
        </div>
      </div>
    </div>
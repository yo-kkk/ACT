<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- Page content -->
    <div class="container mt--8 pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-5 col-md-7">
          <div class="card bg-secondary shadow border-0">
        
            <div class="card-body px-lg-5 py-lg-5" style="height: 360px">
              <form method="post">
                <div class="form-group mb-3">
                  <h2 style="text-align:center">WELCOME !</h2>
                  <div class="input-group input-group-alternative" style="margin-top: 30px;">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                    </div>
                    <input class="form-control" name="emp_id" placeholder="사번" type="text">
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group input-group-alternative">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                    </div>
                    <input class="form-control" name="emp_password" placeholder="비밀번호" type="password">
                  </div>
                </div>
                
                <div class="text-center">
                  <input type="submit" class="btn btn-primary my-4" value="Sign In"/>
                </div>
              </form>
            </div>
          </div>

        </div>
      </div>
    </div>   
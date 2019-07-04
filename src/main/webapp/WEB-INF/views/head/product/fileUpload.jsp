<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(document).ready(function() {
		$('#complete').click(function(){
			alert('이미지 파일이 업로드되었습니다.')
			$('#productUploadForm').submit();
		})
	});
</script>

<!-- Page content -->
  <div class="container-fluid mt--7">
    <!-- Table -->
    <div class="row">
      <div class="col">
        <div class="card shadow">
          <div class="card-header border-0">
            <h3 class="mb-0">이미지 파일 등록</h3>
          </div>

<form id="productUploadForm" action="productList" method="post" name="myform" enctype="multipart/form-data">

<div class="form-group" style="margin:0 auto" align="center">
	<table>
		<tr>
			<th></th>
			<td>
				<img id="picture" width="495" height="495"/><br/><br/>						
			</td>
		</tr>
	</table>
	<div class="input-group mb-3" style="width:500px;" align="center">
	  <div class="custom-file">
	    <input type="file" name="upFile" onchange="document.getElementById('picture').src = window.URL.createObjectURL(this.files[0])" class="custom-file-input" id="inputGroupFile02">
	    <label class="custom-file-label" for="inputGroupFile02" aria-describedby="inputGroupFileAddon02">Choose file</label>
	  </div>
	  <div class="input-group-append">
	    <input type="submit" value="업로드" id="complete" class="input-group-text"/>
	    <input type="hidden" value="${productDTO.product_code}" name="product_code"/><br/>
	  </div>
	</div>
</div>

</form>

        </div>
      </div>
    </div>
  </div>
<br/>
<hr/>
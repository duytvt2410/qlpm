<%@page import="controller.CauHoi"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Làm bài</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
 <nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="<%=request.getContextPath() + "/trangchu"%>">Ontap qlpm</a>

  <!-- Toggler/collapsibe Button -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
	<% 
		List<CauHoi> getAllListCauHoi = (List<CauHoi>) request.getAttribute("getAllListCauHoi");
	%>
  <!-- Navbar links -->
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
    <%
    	String book = "";
    	for(CauHoi timBook : getAllListCauHoi) {
    		if(!book.equals(timBook.getBook())) {
    			book = timBook.getBook();
    %>
		      <li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><%= book %></a>
		        <div class="dropdown-menu">
			        <% 
			        	String chapter = "";
			        	for(CauHoi timChapter : getAllListCauHoi) {
			        		if(!chapter.equals(timChapter.getChapter()) && book.equals(timChapter.getBook())) {
			        			chapter = timChapter.getChapter();
			        	
			        %>
			        		<a class="dropdown-item" href="<%=request.getContextPath() + "/lambaitheochuong?book="+book + "&chapter="+chapter%>"><%= chapter + " (" + timChapter.getNumberOfQuestion() +")"%></a>
			        <% 
			        		}
			        	}
			        %>
			     </div>
		      </li>
		    <% } %>
    <%
    	}
    %>
     <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath() +"/thithu"%>">Thi thử ngẫu nhiên 30 câu</a>
	</li>
    </ul>
  </div>
</nav>
	<% 
		List<CauHoi> getListCauHoiTheoChuong = (List<CauHoi>) request.getAttribute("getListCauHoiTheoChuong");
	%>
	<div class="container">
			<% 
				int stt = 1;
				String ketqua = "";
				for(CauHoi cauhoi : getListCauHoiTheoChuong) { 
			%>
				<h5><%=stt + ". " + cauhoi.getQuestion()%></h5>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="A" name="optradio_<%=stt%>">A. <%= cauhoi.getAnswerA() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="B" name="optradio_<%=stt%>">B. <%= cauhoi.getAnswerB() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="C" name="optradio_<%=stt%>">C. <%= cauhoi.getAnswerC() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="D" name="optradio_<%=stt%>">D. <%= cauhoi.getAnswerD() %>
				  </label>
				</div>
				<br>
				<h6 class="text-danger" id="kq_<%=stt%>" style="display: none"></h6>
				<br>
			<% 
				ketqua += cauhoi.getResult() + "dt14082410dt";
				stt++;
				} 
			%>
			<div class="row">
				<div class= "col-md-3">
					<button type="button" onclick="xemketqua()" class="btn btn-primary">Xem kết quả</button>
					<button type="button" onclick="lammoi()" class="btn btn-warning">Làm mới</button>
				</div>
				<div class= "col-md-9">
					<h4 class="text-danger" id="showketqua" style="display: none"></h4>
				</div>
			</div>
			 
			 
	</div>
	<script type="text/javascript">
		function xemketqua() {
			var tongsocau = '<%=stt - 1%>';
			var len = parseInt(tongsocau);
			var dapancuaban = '';
			var ketquadung = '<%=ketqua%>'.split("dt14082410dt");

			for(var i = 1; i <= len; i++) {
				var id = 'optradio_' + i;
				dapancuaban+= $("input[name='"+id+"']:checked").val() + "dt14082410dt";
			}
			var arrDapancuaban = dapancuaban.split("dt14082410dt");
			var socaudung = 0;
			for(var i = 0; i < len; i++) {
				if(ketquadung[i] == arrDapancuaban[i]) {
					socaudung++;
				} else {
					var id = '#kq_' + (i + 1);
					$(id).text("-> Đáp án đúng là " + ketquadung[i]);
					$(id).css("display", "block");
				}
			}
			
			$("#showketqua").text(socaudung + " / " + tongsocau + " số câu đúng.");
			$("#showketqua").css("display", "block");
		}
		
		function lammoi(){
			var tongsocau = '<%=stt - 1%>';
			var len = parseInt(tongsocau);
			
			for(var i = 0; i < len; i++) {
				var idd = '#kq_' + (i + 1);
				$(idd).css("display", "none");
			}
			$('input[type="radio"]:checked').each(function(){
				$(this).prop('checked', false);
			  });


			$("#showketqua").css("display", "none");
		}
	</script>

</body>
</html>

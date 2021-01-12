<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="controller.QuanLiCauHoi"%>
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
  <style type="text/css">
 #myBtn {
  display: none;
  position: fixed;
  bottom: 20px;
  right: 30px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  background-color: #d26158;
  color: white;
  cursor: pointer;
  padding: 10px 15px;
  border-radius: 2px;
}

.arrow-up {
  border: solid white;
  border-width: 0 3px 3px 0;
  display: inline-block;
  padding: 3px;
  transform: rotate(-135deg);
  -webkit-transform: rotate(-135deg);
}

#myBtn:hover {
  background-color: #fd6d61;
}
  
  	@media only screen and (max-width: 600px) {
  		h5 {font-size: 13px}
  		.form-check-label {font-size: 13px}
  		#myBtn{right:10px; padding: 5px 10px}
  	}
  </style>
</head>
<body>
<button onclick="topFunction()" id="myBtn" title="Go to top"><i class="arrow-up"></i></button>
 <nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="<%=request.getContextPath() + "/trangchu"%>">Ontap qlda</a>

  <!-- Toggler/collapsibe Button -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
	
	<%
	String fileName = "/WEB-INF/cauhoi.txt";
	List<CauHoi> getAllListCauHoi = new ArrayList<CauHoi>();

	InputStream fileInputStream = null;
	BufferedReader bufferedReader = null;
	InputStream ins = application.getResourceAsStream(fileName);
	try {
		if (ins == null) {
			response.setStatus(response.SC_NOT_FOUND);
		} else {
			BufferedReader br = new BufferedReader((new InputStreamReader(ins)));
			String line = br.readLine();
			String content = "";
			while (line != null) {
				content += line;
				line = br.readLine();
			}
			String arrContent[] = content.split("dt1408end2410dt");
			int id = 1;
			for (String s : arrContent) {
				String[] objarr = s.split("dt14082410dt");
				CauHoi cauHoi = new CauHoi(objarr[0], objarr[1], objarr[3], objarr[4], objarr[5], objarr[6],
						objarr[7], objarr[8], Integer.parseInt(objarr[2]));
				cauHoi.setId(id);
				getAllListCauHoi.add(cauHoi);
				id++;
			}
		}
	} catch (IOException e) {
		out.println(e.getMessage());
	}
	
%>
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
	<li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath() +"/thithutheosach?book=Rita"%>">Thi thử ngẫu nhiên 30 câu sách Rita PMP</a>
	</li>
	<li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath() +"/thithutheosach?book=PMI"%>">Thi thử ngẫu nhiên 30 câu sách PMI-ACP</a>
	</li>
    </ul>
  </div>
</nav>
	<% 
	String b = (String) request.getAttribute("book");
	String ch = (String) request.getAttribute("chapter");
	String sach = (String) request.getAttribute("sach");
	List<CauHoi> getListCauHoiTheoChuong = new ArrayList<CauHoi>();
		if(b != null && ch !=null) {
		
		
			for(CauHoi cauhoi : getAllListCauHoi) {
				
				if(cauhoi.getBook().equalsIgnoreCase(b) && cauhoi.getChapter().equalsIgnoreCase(ch)) {
					getListCauHoiTheoChuong.add(cauhoi);
				}
			}
		} else if (sach != null) {
			if(sach.equals("Rita")) {
				List<Integer> random30question = QuanLiCauHoi.random30question(1, 156);
				for(Integer in : random30question) {
					for(CauHoi cauhoi : getAllListCauHoi) {
						if(in == cauhoi.getId()) {
							getListCauHoiTheoChuong.add(cauhoi);
							break;
						}
					}
				}
			} else {
				List<Integer> random30question = QuanLiCauHoi.random30question(157, 256);
				for(Integer in : random30question) {
					for(CauHoi cauhoi : getAllListCauHoi) {
						if(in == cauhoi.getId()) {
							getListCauHoiTheoChuong.add(cauhoi);
							break;
						}
					}
				}
			}
		} else {
			List<Integer> random30question = QuanLiCauHoi.random30question(1, getAllListCauHoi.size());
			for(Integer in : random30question) {
				for(CauHoi cauhoi : getAllListCauHoi) {
					if(in == cauhoi.getId()) {
						getListCauHoiTheoChuong.add(cauhoi);
						break;
					}
				}
			}
		}
	%>
	<div class="container">
			<% 
				int stt = 1;
				String ketqua = "";
				for(CauHoi cauhoi : getListCauHoiTheoChuong) { 
			%>
				<h5 style="color: #104f93"><%=stt + ". " + cauhoi.getQuestion()%></h5>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="A" name="optradio_<%=stt%>"><strong>A.</strong> <%= cauhoi.getAnswerA() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="B" name="optradio_<%=stt%>"><strong>B.</strong> <%= cauhoi.getAnswerB() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="C" name="optradio_<%=stt%>"><strong>C.</strong> <%= cauhoi.getAnswerC() %>
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input" value="D" name="optradio_<%=stt%>"><strong>D.</strong> <%= cauhoi.getAnswerD() %>
				  </label>
				</div>
				<br>
				<h6 id="kq_<%=stt%>" style="color:red; display: none"></h6>
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
	//Get the button
	var mybutton = document.getElementById("myBtn");

	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};

	function scrollFunction() {
	  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	    mybutton.style.display = "block";
	  } else {
	    mybutton.style.display = "none";
	  }
	}

	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
	  document.body.scrollTop = 0;
	  document.documentElement.scrollTop = 0;
	}
	
	
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
					var id = '#kq_' + (i + 1);
					$(id).text("-> Đúng");
					$(id).css("color", "#1cdb1c");
					$(id).css("display", "block");
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

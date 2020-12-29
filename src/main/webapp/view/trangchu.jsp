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
<title>QLDA 2020</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<!-- Brand -->
		<a class="navbar-brand"
			href="<%=request.getContextPath() + "/trangchu"%>">Ontap qlda</a>

		<!-- Toggler/collapsibe Button -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
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
		<!-- Navbar links -->
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<%
					String book = "";
					for (CauHoi timBook : getAllListCauHoi) {
						if (!book.equals(timBook.getBook())) {
							book = timBook.getBook();
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" data-toggle="dropdown"><%=book%></a>
					<div class="dropdown-menu">
						<%
							String chapter = "";
									for (CauHoi timChapter : getAllListCauHoi) {
										if (!chapter.equals(timChapter.getChapter()) && book.equals(timChapter.getBook())) {
											chapter = timChapter.getChapter();
						%>
						<a class="dropdown-item"
							href="<%=request.getContextPath() + "/lambaitheochuong?book=" + book + "&chapter="
									+ chapter%>"><%=chapter + " (" + timChapter.getNumberOfQuestion() + ")"%></a>
						<%
							}
									}
						%>
					</div></li>
				<%
					}
				%>
				<%
					}
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath() + "/thithu"%>">Thi thử ngẫu
						nhiên 30 câu</a></li>
			</ul>
		</div>
	</nav>
	<img src="<%=request.getContextPath() + "/qlmp cau hoi.jpg"%>">
	<small style="position: absolute; bottom: 0; right: 0">Được
		viết bởi Huỳnh Khương Duy</small>
</body>
</html>

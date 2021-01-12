package controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/themcauhoi", "/luucauhoi" , "/trangchu", "/lambaitheochuong", "/thithu", "/thithutheosach"})
public class QuanLiCauHoi extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		if (url.startsWith(request.getContextPath() + "/luucauhoi")) {
			luuCauHoi(request);
		}

		response.sendRedirect(request.getContextPath() + "/themcauhoi");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		if (url.startsWith(request.getContextPath() + "/themcauhoi")) {
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/themcauhoi.jsp");
			rd.forward(request, response);
		} else if (url.startsWith(request.getContextPath() + "/trangchu")) {
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/trangchu.jsp");
			rd.forward(request, response);
		} else if (url.startsWith(request.getContextPath() + "/lambaitheochuong")) {
			
			String book = request.getParameter("book");
			String chapter = request.getParameter("chapter");
			
			
			request.setAttribute("book", book);
			request.setAttribute("chapter", chapter);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/lambai.jsp");
			rd.forward(request, response);
		} else if (url.startsWith(request.getContextPath() + "/thithu")) {
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/lambai.jsp");
			rd.forward(request, response);
		} else if (url.startsWith(request.getContextPath() + "/thithutheosach")) {
			String book = request.getParameter("book");
			request.setAttribute("sach", book);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/lambai.jsp");
			rd.forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/themcauhoi");
		}

	}

	private void luuCauHoi(HttpServletRequest request) {
		CauHoi cauhoi = layCauHoi(request);
		String delimit = "dt14082410dt";

		BufferedWriter bw = null;
		FileWriter fw = null;
		String fileOutPath = request.getRealPath("/").replace('\\', '/');
		File folder = new File(fileOutPath + "cauhoi");
		String data = cauhoi.getBook() + delimit + cauhoi.getChapter() + delimit + cauhoi.getNumberOfQuestion() + delimit + cauhoi.getQuestion()
				+ delimit + cauhoi.getAnswerA() + delimit + cauhoi.getAnswerB() + delimit + cauhoi.getAnswerC()
				+ delimit + cauhoi.getAnswerD() + delimit + cauhoi.getResult() +"dt1408end2410dt"+ "\r\n";
		try {
			if (!folder.exists())
				folder.mkdirs();
			File file = new File(fileOutPath + "cauhoi\\cauhoi.txt");
			if (!file.exists())
				file.createNewFile();
			fw = new FileWriter(file.getAbsoluteFile(), true);
			bw = new BufferedWriter(fw);
			bw.write(data);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try {
				if (bw != null)
					bw.close();
				if (fw != null)
					fw.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	
	private List<CauHoi> getAllListCauHoi(HttpServletRequest request) {
		String fileOutPath = request.getRealPath("/").replace('\\', '/');
		// Đọc dữ liệu từ File với BufferedReader
		FileInputStream fileInputStream = null;
		BufferedReader bufferedReader = null;
		List<CauHoi> list = null;
		try {
			fileInputStream = new FileInputStream(fileOutPath + "cauhoi\\cauhoi.txt");
			bufferedReader = new BufferedReader(new InputStreamReader(fileInputStream));
			String line = bufferedReader.readLine();
			list = new ArrayList<CauHoi>();
			String content = "";
			while (line != null) {
				content += line; 
				line = bufferedReader.readLine();
			}
			String arrContent[] = content.split("dt1408end2410dt");
			int id = 1;
			for(String s : arrContent) {
				String[] objarr = s.split("dt14082410dt");
				CauHoi cauHoi = new CauHoi(objarr[0], objarr[1], objarr[3], objarr[4], objarr[5], objarr[6], objarr[7], objarr[8], Integer.parseInt(objarr[2]));
				cauHoi.setId(id);
				list.add(cauHoi);
				id++;
			}
		} catch (Exception e) {
			return null;
		}
		return list;
	}

	private CauHoi layCauHoi(HttpServletRequest request) {
		CauHoi cauhoi = null;
		try {
			String book = request.getParameter("book");
			String chapter = request.getParameter("chapter");
			int numberOfQuestion = Integer.parseInt(request.getParameter("number_of_questions"));
			String question = request.getParameter("question");
			String answerA = request.getParameter("answer_a");
			String answerB = request.getParameter("answer_b");
			String answerC = request.getParameter("answer_c");
			String answerD = request.getParameter("answer_d");
			String result = request.getParameter("result");
			cauhoi = new CauHoi(book, chapter, question, answerA, answerB, answerC, answerD, result, numberOfQuestion);
		} catch (Exception e) {
			return null;
		}

		return cauhoi;
	}
	
	public static List<Integer> random30question(int min, int max) {
		Random rd = new Random();
		List<Integer> arr = new ArrayList<Integer>();
		
		for(int i = 0; i < 30; i++) {
			int x = rd.nextInt(max - min) + min;
			boolean c = false;
			while(!c) {
				boolean isExist = false;
				for(Integer in : arr) {
					if(in == x) {
						isExist = true;
						break;
					}
				}
				if(isExist == false) {
					arr.add(x);
					c = true;
				} else {
					x = rd.nextInt(max - min) + min;
				}
			}
		}
		return arr;
	}
	
	public static void main(String[] args) {
		File f = new File("src/main/webapp/cauhoi/cauhoi.txt");
		System.out.println(f.exists());
	}
	
}

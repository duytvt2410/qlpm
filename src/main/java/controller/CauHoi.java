package controller;

public class CauHoi {
	private String book, chapter, question, answerA, answerB, answerC, answerD, result;
	private int numberOfQuestion, id;
	
	
	
	public CauHoi(String book, String chapter, String question, String answerA, String answerB, String answerC,
			String answerD, String result, int numberOfQuestion) {
		super();
		this.book = book;
		this.chapter = chapter;
		this.question = question;
		this.answerA = answerA;
		this.answerB = answerB;
		this.answerC = answerC;
		this.answerD = answerD;
		this.result = result;
		this.numberOfQuestion = numberOfQuestion;
	}
	public String getBook() {
		return book;
	}
	public void setBook(String book) {
		this.book = book;
	}
	public String getChapter() {
		return chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswerA() {
		return answerA;
	}
	public void setAnswerA(String answerA) {
		this.answerA = answerA;
	}
	public String getAnswerB() {
		return answerB;
	}
	public void setAnswerB(String answerB) {
		this.answerB = answerB;
	}
	public String getAnswerC() {
		return answerC;
	}
	public void setAnswerC(String answerC) {
		this.answerC = answerC;
	}
	public String getAnswerD() {
		return answerD;
	}
	public void setAnswerD(String answerD) {
		this.answerD = answerD;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public int getNumberOfQuestion() {
		return numberOfQuestion;
	}
	public void setNumberOfQuestion(int numberOfQuestion) {
		this.numberOfQuestion = numberOfQuestion;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "CauHoi [book=" + book + ", chapter=" + chapter + ", question=" + question + ", answerA=" + answerA
				+ ", answerB=" + answerB + ", answerC=" + answerC + ", answerD=" + answerD + ", result=" + result
				+ ", numberOfQuestion=" + numberOfQuestion + ", id=" + id + "]";
	}
	
}

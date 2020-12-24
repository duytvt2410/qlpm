<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Thêm câu hỏi</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  
  
  <div class="col-xl-12">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Thêm câu hỏi</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <h2>Thêm câu hỏi: </h2>
					  <form action="<%=request.getContextPath() + "/luucauhoi" %>" class="was-validated" method="post">
					    <div class="form-group">
					      <label for="book">Sách:</label>
					      <input type="text" class="form-control" id="book" name="book" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="chapter">Chương:</label>
					      <input type="text" class="form-control" id="chapter"  name="chapter" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="number_of_questions">Số câu:</label>
					      <input type="text" class="form-control" id="number_of_questions"  name="number_of_questions" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="question">Câu hỏi:</label>
					      <textarea rows="4" cols="" class="form-control" id="question"  name="question" required></textarea>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					      
					    </div>
					    <div class="form-group">
					      <label for="answer_a">Đáp án A:</label>
					      <input type="text" class="form-control" id="answer_a"  name="answer_a" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="answer_b">Đáp án B:</label>
					      <input type="text" class="form-control" id="answer_b"  name="answer_b" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="answer_c">Đáp án C:</label>
					      <input type="text" class="form-control" id="answer_c"  name="answer_c" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="answer_d">Đáp án D:</label>
					      <input type="text" class="form-control" id="answer_d"  name="answer_d" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <div class="form-group">
					      <label for="result">Đáp án là:</label>
					      <input type="text" class="form-control" id="result"  name="result" required>
					      <div class="valid-feedback">Hợp lệ.</div>
					      <div class="invalid-feedback">Không được bỏ trống.</div>
					    </div>
					    <button type="submit" class="btn btn-primary">Lưu câu hỏi</button>
					    <button type="button" class="btn btn-danger">Hủy</button>
					  </form>
                </div>
              </div>
            </div>
          </div>


</body>
</html>

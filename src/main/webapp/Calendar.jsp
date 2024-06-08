<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Calendar</title>
<style>
* {
	margin: 0;
	padding: 0;
	font-family: sans-serif;
	box-sizing: border-box;
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background-color: #f8f9fa;
}

.calendar {
	width: 100%;
	max-width: 1000px;
	margin: 50px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 10px;
	padding: 20px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.year-month {
	font-size: 3rem;
	font-weight: bold;
}

.nav {
	display: flex;
	border: 1px solid #333333;
	border-radius: 5px;
}

.nav-btn {
	width: 28px;
	height: 34px;
	border: bold;
	font-size: 19px;
	font-weight: bold;
	line-height: 30px;
	background-color: transparent;
	cursor: pointer;
}

.go-today {
	width: 75px;
	border-left: 1px solid #333333;
	border-right: 1px solid #333333;
	font-weight: bold;
}

.days {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

.day {
	width: calc(100%/ 7);
	text-align: center;
	font-weight: bold;
	color: #343a40;
}

.dates {
	display: flex;
	flex-flow: row wrap;
	height: 500px;
}

.date {
	width: calc(100%/ 7);
	padding: 15px;
	text-align: center;
	cursor: pointer;
	border: 1px solid #dee2e6;
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: bold;
}

.day:nth-child(7n+1), .date:nth-child(7n+1) {
	color: #D13E3E;
}

.day:nth-child(7n), .date:nth-child(7n) {
	color: #396EE2;
}

.other {
	opacity: 0.3;
}

.today {
	position: relative;
	color: #FFFFFF;
}

.today::before {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: -1;
	width: 30px;
	height: 30px;
	display: block;
	background-color: #FF0000;
	border-radius: 50%;
	content: '';
}
</style>
</head>
<body>
	<div class="calendar">
		<div class="header">
			<div class="year-month"></div>
			<div class="nav">
				<button class="nav-btn go-prev" onclick="prevMonth()">&lt;</button>
				<button class="nav-btn go-today" onclick="goToday()">Today</button>
				<button class="nav-btn go-next" onclick="nextMonth()">&gt;</button>
			</div>
		</div>
		<div class="main">
			<div class="days">
				<div class="day">Sun</div>
				<div class="day">Mon</div>
				<div class="day">Tue</div>
				<div class="day">Wed</div>
				<div class="day">Thu</div>
				<div class="day">Fri</div>
				<div class="day">Sat</div>
			</div>
			<div class="dates"></div>
		</div>
	</div>

	<!-- 모달 창 추가 
  <div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="eventModalLabel">일정 추가</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="eventForm">
            <div class="mb-3">
              <label for="eventDate" class="form-label">날짜</label>
              <input type="text" class="form-control" id="eventDate" readonly>
            </div>
            <div class="mb-3">
              <label for="eventTitle" class="form-label">일정 제목</label>
              <input type="text" class="form-control" id="eventTitle" required>
            </div>
            <div class="mb-3">
              <label for="eventDescription" class="form-label">일정 내용</label>
              <textarea class="form-control" id="eventDescription" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">저장</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  모달창 여기까지 적용 -->
	<script type="text/javascript" src="./resources/js/Calendar.js"></script>
</body>
</html>

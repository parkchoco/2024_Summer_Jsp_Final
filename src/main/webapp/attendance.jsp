<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Calendar, java.util.Date, java.util.GregorianCalendar, java.util.List, java.util.Set, java.util.HashSet, mvc.model.BoardDAO" %>
<%

    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null || sessionId.isEmpty()) {

        response.sendRedirect("Login.jsp");
        return;
    }

    BoardDAO dao = BoardDAO.getInstance();


    boolean pointsRecordedToday = dao.hasPointsRecordedToday(sessionId);
    System.out.println("pointsRecordedToday: " + pointsRecordedToday);
    if (!pointsRecordedToday) {

        dao.updateUserPoints(sessionId, 10);
        dao.savePointsHistory(sessionId, 10);


        Integer userPoints = (Integer) session.getAttribute("userPoints");
        if (userPoints == null) {
            userPoints = 0;
        }
        userPoints += 10;
        session.setAttribute("userPoints", userPoints);
        System.out.println("New user points: " + userPoints);


        out.println("<script>alert('출석완료');</script>");
    } else {

        out.println("<script>alert('이미 출석 하셨습니다');</script>");
    }


    Calendar cal = Calendar.getInstance();
    int currentMonth = cal.get(Calendar.MONTH);
    int currentYear = cal.get(Calendar.YEAR);


    List<Date> pointsDates = dao.getUserPointsDatesForMonth(sessionId, currentYear, currentMonth);
    System.out.println("pointsDates: " + pointsDates); 


    Set<Integer> markedDays = new HashSet<>();
    for (Date date : pointsDates) {
        Calendar tempCal = Calendar.getInstance();
        tempCal.setTime(date);
        markedDays.add(tempCal.get(Calendar.DAY_OF_MONTH));
    }
%>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Attendance</title>
    <style>
        .calendar {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 20px;
        }
        .middle-text {
            font-size: 1.5rem;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .year-month {
            font-size: 2rem;
            font-weight: bold;
        }
        .days {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .day {
            width: calc(100% / 7);
            text-align: center;
            font-weight: bold;
            color: #343a40;
        }
        .dates {
            display: flex;
            flex-flow: row wrap;
            height: 400px;
        }
        .date {
            width: calc(100% / 7);
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
            color: black;
        }
        .day:nth-child(7n), .date:nth-child(7n) {
            color: black;
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
            background-color: #ff0000;
            border-radius: 50%;
            content: '';
        }
        .marked {
            position: relative;
            color: #000000;
        }
        .marked::before {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: -1;
            width: 30px;
            height: 30px;
            display: block;
            background-color: #ff0000;
            border-radius: 50%;
            content: '';
        }
    </style>
</head>
<body>
<div class="container py-4 position-relative">
<jsp:include page="/home.jsp" />
    
    
    <div class="calendar">
        <div class="header">
            <div class="middle-text"><strong>출석 현황</strong></div>
            <div class="year-month"><%= currentYear %>년 <%= (currentMonth + 1) %>월</div>
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
            <div class="dates">
               <%
                    Calendar calendar = new GregorianCalendar(currentYear, currentMonth, 1);
                    int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                    int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
                    int dayCounter = 1;


                    for (int i = 0; i < 6; i++) {
                        for (int j = 1; j <= 7; j++) {
                            if (i == 0 && j < firstDayOfWeek || dayCounter > daysInMonth) {
                                out.println("<div class='date other'></div>");
                            } else {
                                String className = "date";

                                if (markedDays.contains(dayCounter)) {
                                    className += " marked";
                                }
                                if (dayCounter == Calendar.getInstance().get(Calendar.DAY_OF_MONTH) &&
                                    currentMonth == Calendar.getInstance().get(Calendar.MONTH) &&
                                    currentYear == Calendar.getInstance().get(Calendar.YEAR)) {
                                    className += " today";
                                }
                                out.println("<div class='" + className + "'>" + dayCounter + "</div>");
                                dayCounter++;
                            }
                        }
                    }
                %>
            </div>
        </div>
    </div>
    </div>
</body>
</html>

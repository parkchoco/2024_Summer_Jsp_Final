<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="mvc.model.BoardDAO" %>
<%

    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null || sessionId.isEmpty()) {

        response.sendRedirect("Login.jsp");
        return;
    }


    int points = 0;
    int level = 0;

    try {

        BoardDAO boardDAO = BoardDAO.getInstance();
        points = boardDAO.getUserPoints(sessionId);
        level = boardDAO.getUserLevel(sessionId);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Welcome</title>
    <style>
        .gif-container {
            position: relative;
            width: 100%; 
            max-width: 800px; 
            margin: auto; 
        }
        .background-img {
            display: block;
            width: 100%; 
        }
        .overlay-gif {
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            height: 300px;
            animation: moveLeftToRight 10s linear infinite;
        }
        .overlay-gif-back {
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            height: 300px;
            opacity: 0;
            animation: moveRightToLeft 10s linear infinite;
        }
        
        @keyframes moveLeftToRight {
            0% {
                left: 0;
                opacity: 1;
            }
            50% {
                left: calc(100% - 300px);
                opacity: 1;
            }
            51% {
                opacity: 0;
            }
            100% {
                right: 0;
                opacity: 0;
            }
        }
        
        @keyframes moveRightToLeft {
            0% {
                right: 0;
                opacity: 0;
            }
            49.9% {
                opacity: 0;
            }
            50% {
                left: calc(100% - 300px); 
                opacity: 1;
            }
            100% {
                left: 0;
                opacity: 1;
            }
        }
        
        .points {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 1rem;
            font-weight: bold;
            color: #333;
            background: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>
    <div class="container py-4 position-relative">
        <div class="points">
            Points: <strong><%= points %></strong> | Level: <strong><%= level %></strong>
        </div>
        <jsp:include page="/home.jsp" />
        <div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center">
            <div class="container-fluid py-5 gif-container">
                <img src="./images/background_img2.png" alt="배경 이미지" class="background-img">
                <img src="./images/cat.gif" alt="고양이 GIF" class="overlay-gif">
                <img src="./images/cat_flipped.gif" alt="다른 고양이 GIF" class="overlay-gif-back">
            </div>
        </div>
        
        

        <jsp:include page="/Calendar.jsp" />
        
    </div>

    <jsp:include page="/Brand.jsp" />
</body>
</html>

<%@page contentType="text/html; charset=utf-8" %>
<%@page import ="java.util.Date" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Welcome</title>
    <style>
        .gif-container {
            position: relative;
            width: fit-content;
            margin: auto;
        }
        .background-img {
            display: block;
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
            right:0;
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
                left: calc(100% - 300px); /* Adjust the width of your GIF */
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
                right:0;
                opacity: 0;
            }
            49.9% {
            	opacity:0;
            }
            50% {
                left: calc(100% - 300px); /* Adjust the width of your GIF */
                opacity: 1;
            }
            100% {
                left: 0;
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<%@ include file="home.jsp" %>

<div class="container py-4">
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5 text-center gif-container">
            <img src="images/background_img2.png" alt="배경 이미지" class="background-img">
            <img src="images/cat.gif" alt="고양이 GIF" class="overlay-gif">
            <img src="images/cat_flipped.gif" alt="다른 고양이 GIF" class="overlay-gif-back">
        </div>
    </div>
</div>

<%@ include file="Brand.jsp" %>
</body>
</html>

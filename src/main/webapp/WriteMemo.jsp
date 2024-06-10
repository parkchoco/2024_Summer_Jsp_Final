<%@ page contentType="text/html; charset=UTF-8" %>

<head>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <title>MEMO</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 80%;
            max-width: 1000px;
            text-align: center;
        }

        h1 {
            color: #333333;
            margin-bottom: 20px;
            font-size: 4rem;
            font-weight: bold;
        }

        label {
            font-size: 1.2em;
            color: #555555;
        }

        textarea {
            width: 100%;
            height: 400px;
            padding: 10px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 1em;
            color: #333333;
            resize: none;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px; /* 버튼 사이의 간격 설정 */
        }

        .button-container button,
        .button-container input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            width: auto; /* 크기 자동 조정 */
        }

    </style>
</head>
<body>

    <div class="container">
        <h1>MEMO</h1>
        <form action="SaveMemo.jsp" method="post">
            Memo Title <br><input type="text" name="title"><br>
            <br>
            <textarea id="content" name="content" rows="10" cols="50" required></textarea><br><br>
            <div class="button-container">
                <button class="home-button" onclick="location.href='member/LoginPage.jsp?msg=2'" type="button">Home</button>
                <input type="submit" value="Save">
            </div>
        </form>
    </div>
</body>
</html>

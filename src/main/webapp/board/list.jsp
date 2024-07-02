<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	String subject = (String) request.getAttribute("subject");
	List boardList = (List) request.getAttribute("boardlist");	
	int total_record = ((Integer) request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer) request.getAttribute("total_page")).intValue();
	Integer num = (Integer) request.getAttribute("num");
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Board</title>
<script type="text/javascript">
	function checkForm() {	
		if (${sessionId==null}) {
			alert("로그인 해주세요.");
			return false;
		}

		location.href = "./BoardWriteForm.do?id=<%=sessionId%>"
	}
</script>
</head>
<body>
<div class="container py-4">
	<jsp:include page="../home.jsp" />
	
	 <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">나의 과목</h1>
        <p class="col-md-8 fs-4">My StudyRoom</p>      
      </div>
    </div>
	
	<div class="row align-items-md-stretch   text-center">	 	
		<form action="<c:url value="./BoardListAction.do"/>" method="post">			
					
			<div style="padding-top: 20px">
				<table class="table table-hover table-bordered" style="text-align: left; font-size: 1em;">
    <thead class="table-light">
        <tr>
            <th>Subject</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (boardList != null && !boardList.isEmpty()) {
                for (int j = 0; j < boardList.size(); j++) {
                    BoardDTO notice = (BoardDTO) boardList.get(j);
        %>
        <tr style="height: 60px; vertical-align: middle;">
            <td><a href="./BoardViewAction.do?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"><%=notice.getSubject()%></a></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr style="height: 60px; vertical-align: middle;">
            <td colspan="5" style="text-align: center;">No records found.</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>



			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum%>" />
				<c:forEach var="i" begin="1" end="<%=total_page%>">
					<a href="<c:url value="./BoardListAction.do?pageNum=${i}" /> ">
						<c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>

							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>			
			<div class="py-3" align="right">							
				<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">과목 추가</a>				
			</div>			

			
		</form>			
	</div>
	<jsp:include page="/Brand.jsp" />
</div>
</body>
</html>






package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;
import mvc.model.DisplayDAO;
import mvc.model.DisplayDTO;

@WebServlet("*.do")
public class BoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    static final int LISTCOUNT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String RequestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String command = RequestURI.substring(contextPath.length());

        response.setContentType("text/html; charset=utf-8");
        request.setCharacterEncoding("utf-8");

        switch (command) {
            // existing cases
            case "/BoardListAction.do":
                requestBoardList(request);
                forward(request, response, "/board/list.jsp");
                break;
            case "/BoardWriteForm.do":
                requestLoginName(request);
                forward(request, response, "/board/writeForm.jsp");
                break;
            case "/BoardWriteAction.do":
                requestBoardWrite(request);
                forward(request, response, "/BoardListAction.do");
                break;
            case "/BoardWriteAction2.do":
                requestDisplayWrite(request);
                forward(request, response, "/DisplayContent.do");
                break;
            case "/DisplayContent.do":
                requestDisplayList(request);
                forward(request, response, "/board/displayContent.jsp");
                break;
            case "/BoardViewAction.do":
                requestBoardView(request);
                forward(request, response, "/BoardView.do");
                break;
            case "/BoardView.do":
                forward(request, response, "/board/view.jsp");
                break;
            case "/BoardUpdateAction.do":
                requestBoardUpdate(request);
                response.sendRedirect(request.getContextPath() + "/BoardListAction.do");
                break;
            case "/BoardDeleteAction.do":
                requestBoardDelete(request);
                response.sendRedirect(request.getContextPath() + "/BoardListAction.do");
                break;
            case "/DeleteContent.do":
                requestContentDelete(request, response);
                break;
        
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(path);
        if (rd != null) {
            rd.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    public void requestBoardList(HttpServletRequest request) {
        BoardDAO dao = BoardDAO.getInstance();
        ArrayList<BoardDTO> boardlist = new ArrayList<>();

        int pageNum = 1;
        int limit = LISTCOUNT;

        if (request.getParameter("pageNum") != null) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        String items = request.getParameter("items");
        String text = request.getParameter("text");

        int total_record = dao.getListCount(items, text);
        boardlist = dao.getBoardList(pageNum, limit, items, text);

        int total_page = (int) Math.ceil((double) total_record / limit);

        request.setAttribute("pageNum", pageNum);
        request.setAttribute("total_page", total_page);
        request.setAttribute("total_record", total_record);
        request.setAttribute("boardlist", boardlist);
    }

    public void requestLoginName(HttpServletRequest request) {
        String id = request.getParameter("id");

        BoardDAO dao = BoardDAO.getInstance();
        String name = dao.getLoginNameById(id);

        request.setAttribute("name", name);
    }

    public void requestBoardWrite(HttpServletRequest request) {
        BoardDAO dao = BoardDAO.getInstance();

        BoardDTO board = new BoardDTO();
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        dao.insertBoard(board);
    }

    public void requestDisplayWrite(HttpServletRequest request) {
        DisplayDAO dao = DisplayDAO.getInstance();

        DisplayDTO display = new DisplayDTO();
        display.setSubject(request.getParameter("subject"));
        display.setContent(request.getParameter("content"));

        dao.insertDisplay(display);

        // Set the content as a request attribute to display it
        request.setAttribute("submittedSubject", request.getParameter("subject"));
        request.setAttribute("submittedContent", request.getParameter("content"));
    }

    public void requestDisplayList(HttpServletRequest request) {
        DisplayDAO dao = DisplayDAO.getInstance();
        ArrayList<DisplayDTO> displayList = new ArrayList<>();

        String searchSubject = request.getParameter("subject");

        if (searchSubject != null && !searchSubject.trim().isEmpty()) {
            displayList = dao.getDisplaysBySubject(searchSubject);
        } else {
            displayList = dao.getDisplayList();
        }

        request.setAttribute("displayList", displayList);
    }

    public void requestBoardView(HttpServletRequest request) {
        BoardDAO dao = BoardDAO.getInstance();
        int num = Integer.parseInt(request.getParameter("num"));
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));

        BoardDTO board = dao.getBoardByNum(num, pageNum);
        String subject = dao.getSubjectByNum(num);

        request.setAttribute("num", num);
        request.setAttribute("page", pageNum);
        request.setAttribute("subject", subject);
        request.setAttribute("board", board);
    }

    public void requestBoardUpdate(HttpServletRequest request) {
        int num = Integer.parseInt(request.getParameter("num"));
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));

        BoardDAO dao = BoardDAO.getInstance();

        BoardDTO board = new BoardDTO();
        board.setNum(num);
        board.setName(request.getParameter("name"));
        board.setSubject(request.getParameter("subject"));
        board.setContent(request.getParameter("content"));

        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
        String regist_day = formatter.format(new java.util.Date());

        board.setHit(0);
        board.setRegist_day(regist_day);
        board.setIp(request.getRemoteAddr());

        dao.updateBoard(board);
    }
    
    public void requestBoardDelete(HttpServletRequest request) {
        int num = Integer.parseInt(request.getParameter("num"));

        BoardDAO dao = BoardDAO.getInstance();
        dao.deleteBoard(num);
    }


    public void requestContentDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id != null && !id.isEmpty()) {
            DisplayDAO dao = DisplayDAO.getInstance();
            boolean isDeleted = dao.deleteDisplayById(Integer.parseInt(id));

            if (isDeleted) {
                response.sendRedirect("DisplayContent.do");
            } else {
                request.setAttribute("error", "Unable to delete content.");
                requestDisplayList(request);
                forward(request, response, "/board/displayContent.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid content id.");
            requestDisplayList(request);
            forward(request, response, "/board/displayContent.jsp");
        }
    }
    

}

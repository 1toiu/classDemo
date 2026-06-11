package cn.gzu.classdemo.controller;

import cn.gzu.classdemo.entity.Book;
import cn.gzu.classdemo.service.BookService;
import cn.gzu.classdemo.service.DeepSeekService;
import cn.gzu.classdemo.service.DeepSeekService.ChatMessage;
import cn.gzu.classdemo.service.impl.BookServiceImpl;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ai/chat")
public class AiChatServlet extends HttpServlet {
    private static final int MAX_MESSAGE_LENGTH = 500;
    private static final int MAX_HISTORY_MESSAGES = 10;
    private static final String HISTORY_KEY = "aiChatHistory";

    private final DeepSeekService deepSeekService = new DeepSeekService();
    private final BookService bookService = new BookServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        JsonObject result = new JsonObject();

        try {
            JsonObject body = JsonParser.parseReader(req.getReader()).getAsJsonObject();
            String message = body.has("message") ? body.get("message").getAsString().trim() : "";
            if (message.isEmpty()) {
                writeError(resp, HttpServletResponse.SC_BAD_REQUEST, "请输入需要咨询的内容");
                return;
            }
            if (message.length() > MAX_MESSAGE_LENGTH) {
                writeError(resp, HttpServletResponse.SC_BAD_REQUEST, "单次消息不能超过 500 个字符");
                return;
            }

            HttpSession session = req.getSession();
            List<ChatMessage> history = getHistory(session);
            history.add(new ChatMessage("user", message));
            trimHistory(history);

            List<Book> books = bookService.listBooks(null, null);
            String answer = deepSeekService.chat(history, books);
            history.add(new ChatMessage("assistant", answer));
            trimHistory(history);
            session.setAttribute(HISTORY_KEY, history);

            result.addProperty("answer", answer);
            resp.getWriter().write(result.toString());
        } catch (IllegalStateException e) {
            writeError(resp, HttpServletResponse.SC_SERVICE_UNAVAILABLE, e.getMessage());
        } catch (Exception e) {
            getServletContext().log("AI 客服请求失败", e);
            writeError(resp, HttpServletResponse.SC_BAD_GATEWAY, "AI 客服暂时无法响应，请稍后重试");
        }
    }

    @SuppressWarnings("unchecked")
    private List<ChatMessage> getHistory(HttpSession session) {
        Object value = session.getAttribute(HISTORY_KEY);
        return value instanceof List ? (List<ChatMessage>) value : new ArrayList<ChatMessage>();
    }

    private void trimHistory(List<ChatMessage> history) {
        while (history.size() > MAX_HISTORY_MESSAGES) {
            history.remove(0);
        }
    }

    private void writeError(HttpServletResponse resp, int status, String message) throws IOException {
        resp.setStatus(status);
        JsonObject error = new JsonObject();
        error.addProperty("error", message);
        resp.getWriter().write(error.toString());
    }
}

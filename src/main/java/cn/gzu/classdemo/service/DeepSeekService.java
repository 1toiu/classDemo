package cn.gzu.classdemo.service;

import cn.gzu.classdemo.entity.Book;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class DeepSeekService {
    private static final String API_URL = "https://api.deepseek.com/chat/completions";
    private static final int CONNECT_TIMEOUT_MS = 10_000;
    private static final int READ_TIMEOUT_MS = 60_000;

    public String chat(List<ChatMessage> history, List<Book> books) throws IOException {
        String apiKey = readSetting("DEEPSEEK_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new IllegalStateException("未配置 DEEPSEEK_API_KEY");
        }

        JsonObject request = new JsonObject();
        request.addProperty("model", defaultValue(readSetting("DEEPSEEK_MODEL"), "deepseek-chat"));
        request.addProperty("stream", false);
        request.addProperty("temperature", 0.4);
        request.addProperty("max_tokens", 700);

        JsonArray messages = new JsonArray();
        messages.add(message("system", buildSystemPrompt(books)));
        for (ChatMessage item : history) {
            messages.add(message(item.getRole(), item.getContent()));
        }
        request.add("messages", messages);

        HttpsURLConnection connection = (HttpsURLConnection) new URL(API_URL).openConnection();
        connection.setRequestMethod("POST");
        connection.setConnectTimeout(CONNECT_TIMEOUT_MS);
        connection.setReadTimeout(READ_TIMEOUT_MS);
        connection.setDoOutput(true);
        connection.setRequestProperty("Authorization", "Bearer " + apiKey.trim());
        connection.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
        connection.setRequestProperty("Accept", "application/json");

        byte[] body = request.toString().getBytes(StandardCharsets.UTF_8);
        try (OutputStream output = connection.getOutputStream()) {
            output.write(body);
        }

        int status = connection.getResponseCode();
        String responseBody = readResponse(status >= 200 && status < 300
                ? connection.getInputStream()
                : connection.getErrorStream());
        connection.disconnect();

        if (status < 200 || status >= 300) {
            throw new IOException("DeepSeek API 请求失败（HTTP " + status + "）：" + extractError(responseBody));
        }

        JsonObject response = JsonParser.parseString(responseBody).getAsJsonObject();
        JsonArray choices = response.getAsJsonArray("choices");
        if (choices == null || choices.size() == 0) {
            throw new IOException("DeepSeek API 未返回有效回答");
        }
        return choices.get(0).getAsJsonObject()
                .getAsJsonObject("message")
                .get("content")
                .getAsString()
                .trim();
    }

    private JsonObject message(String role, String content) {
        JsonObject message = new JsonObject();
        message.addProperty("role", role);
        message.addProperty("content", content);
        return message;
    }

    private String buildSystemPrompt(List<Book> books) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("你是现代图书馆网上书城的 AI 客服。")
                .append("请使用简洁、友好的中文回答，优先帮助用户选书、了解价格和库存、使用购物车与订单功能。")
                .append("只能根据下方书目和系统规则回答具体商品信息；不确定时明确说明，不要编造。")
                .append("你不能替用户下单、付款、删除订单或修改账户。")
                .append("系统规则：加入购物车后可调整数量并结算；订单可在“我的订单”查看；具体配送与退款政策未在系统中配置。")
                .append("\n当前书目：\n");
        int count = 0;
        for (Book book : books) {
            if (count++ >= 50) {
                break;
            }
            prompt.append("- 《").append(book.getTitle()).append("》")
                    .append("，作者：").append(book.getAuthor())
                    .append("，分类：").append(book.getCategory())
                    .append("，价格：").append(book.getPrice()).append("元")
                    .append("，库存：").append(book.getStock())
                    .append("，简介：").append(defaultValue(book.getDescription(), "暂无"))
                    .append("\n");
        }
    return prompt.toString();
    }

    private String readSetting(String name) {
        String value = System.getenv(name);
        return value == null || value.trim().isEmpty() ? System.getProperty(name) : value;
    }

    private String defaultValue(String value, String fallback) {
        return value == null || value.trim().isEmpty() ? fallback : value;
    }

    private String readResponse(InputStream input) throws IOException {
        if (input == null) {
            return "";
        }
        StringBuilder result = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(input, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                result.append(line);
            }
        }
        return result.toString();
    }

    private String extractError(String responseBody) {
        try {
            JsonObject root = JsonParser.parseString(responseBody).getAsJsonObject();
            JsonObject error = root.getAsJsonObject("error");
            return error == null ? responseBody : error.get("message").getAsString();
        } catch (Exception ignored) {
            return responseBody == null || responseBody.isEmpty() ? "无错误详情" : responseBody;
        }
    }

    public static class ChatMessage {
        private final String role;
        private final String content;

        public ChatMessage(String role, String content) {
            this.role = role;
            this.content = content;
        }

        public String getRole() {
            return role;
        }

        public String getContent() {
            return content;
        }
    }
}

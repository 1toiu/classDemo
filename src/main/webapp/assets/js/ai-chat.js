(function () {
    document.addEventListener("DOMContentLoaded", function () {
        const root = document.getElementById("ai-chat-root");
        if (!root) {
            return;
        }

        const panel = document.getElementById("ai-chat-panel");
        const toggle = document.getElementById("ai-chat-toggle");
        const close = document.getElementById("ai-chat-close");
        const form = document.getElementById("ai-chat-form");
        const input = document.getElementById("ai-chat-input");
        const messages = document.getElementById("ai-chat-messages");
        const send = document.getElementById("ai-chat-send");
        const status = document.getElementById("ai-chat-status");
        const contextPath = root.dataset.contextPath || "";

        function setOpen(open) {
            panel.classList.toggle("hidden", !open);
            toggle.classList.toggle("hidden", open);
            if (open) {
                input.focus();
            }
        }

        function appendMessage(text, role) {
            const item = document.createElement("div");
            item.className = "ai-message ai-message-" + role;
            item.textContent = text;
            messages.appendChild(item);
            messages.scrollTop = messages.scrollHeight;
        }

        function setLoading(loading) {
            send.disabled = loading;
            input.disabled = loading;
            send.textContent = loading ? "思考中..." : "发送";
            status.textContent = loading ? "正在联系 DeepSeek..." : "回答由 DeepSeek 生成";
        }

        toggle.addEventListener("click", function () {
            setOpen(true);
        });
        close.addEventListener("click", function () {
            setOpen(false);
        });

        form.addEventListener("submit", async function (event) {
            event.preventDefault();
            const message = input.value.trim();
            if (!message) {
                return;
            }

            appendMessage(message, "user");
            input.value = "";
            setLoading(true);

            try {
                const response = await fetch(contextPath + "/ai/chat", {
                    method: "POST",
                    credentials: "same-origin",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({message: message})
                });
                const data = await response.json();
                if (!response.ok) {
                    throw new Error(data.error || "请求失败");
                }
                appendMessage(data.answer, "assistant");
            } catch (error) {
                appendMessage(error.message || "AI 客服暂时无法响应，请稍后重试。", "error");
            } finally {
                setLoading(false);
                input.focus();
            }
        });

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter" && !event.shiftKey) {
                event.preventDefault();
                form.requestSubmit();
            }
        });
    });
})();

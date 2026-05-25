function confirmDelete(message) {
    return window.confirm(message || "确认删除这条数据吗？");
}

function fillBookForm(button) {
    const fields = ["id", "title", "author", "category", "price", "stock", "description", "coverUrl"];
    fields.forEach(function (name) {
        const input = document.querySelector("[name='" + name + "']");
        if (input) {
            input.value = button.dataset[name] || "";
        }
    });
    window.scrollTo({ top: 0, behavior: "smooth" });
}

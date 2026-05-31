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

document.addEventListener("DOMContentLoaded", function () {
    const iconMap = {
        add: "+",
        add_box: "+",
        add_shopping_cart: "+",
        account_circle: "◎",
        arrow_forward: "→",
        auto_stories: "□",
        category: "□",
        chevron_left: "‹",
        chevron_right: "›",
        dashboard: "▦",
        delete: "×",
        edit: "✎",
        expand_more: "⌄",
        filter_list: "≡",
        group: "◇",
        help_outline: "?",
        library_books: "▤",
        lock: "●",
        logout: "↩",
        menu: "☰",
        menu_book: "▤",
        notifications: "○",
        person: "◎",
        person_add: "+",
        receipt_long: "≡",
        search: "⌕",
        settings: "⚙",
        shopping_bag: "□",
        shopping_cart: "□",
        today: "□",
        warning: "!"
    };

    document.querySelectorAll(".material-symbols-outlined").forEach(function (icon) {
        const name = (icon.dataset.icon || icon.textContent || "").trim();
        if (iconMap[name]) {
            icon.dataset.iconName = name;
            icon.textContent = iconMap[name];
            icon.setAttribute("aria-hidden", "true");
        }
    });
});

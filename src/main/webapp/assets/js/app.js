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
        add: '<path d="M12 5v14M5 12h14"/>',
        add_box: '<rect x="4" y="4" width="16" height="16" rx="2"/><path d="M12 8v8M8 12h8"/>',
        add_shopping_cart: '<circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/><path d="M3 4h2l2.2 10.5a2 2 0 0 0 2 1.5h7.9a2 2 0 0 0 1.9-1.4L21 8H7"/><path d="M15 5v6M12 8h6"/>',
        account_circle: '<circle cx="12" cy="12" r="9"/><circle cx="12" cy="10" r="3"/><path d="M6.8 18a6.4 6.4 0 0 1 10.4 0"/>',
        arrow_forward: '<path d="M5 12h14M13 6l6 6-6 6"/>',
        auto_stories: '<path d="M5 5h6a3 3 0 0 1 3 3v12a3 3 0 0 0-3-3H5z"/><path d="M19 5h-5a3 3 0 0 0-3 3v12a3 3 0 0 1 3-3h5z"/>',
        category: '<rect x="4" y="4" width="7" height="7" rx="1"/><rect x="13" y="4" width="7" height="7" rx="1"/><rect x="4" y="13" width="7" height="7" rx="1"/><rect x="13" y="13" width="7" height="7" rx="1"/>',
        chevron_left: '<path d="M15 18l-6-6 6-6"/>',
        chevron_right: '<path d="M9 18l6-6-6-6"/>',
        dashboard: '<rect x="4" y="4" width="7" height="7" rx="1"/><rect x="13" y="4" width="7" height="5" rx="1"/><rect x="4" y="13" width="7" height="7" rx="1"/><rect x="13" y="11" width="7" height="9" rx="1"/>',
        delete: '<path d="M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3"/>',
        edit: '<path d="M4 20h4l11-11a2.1 2.1 0 0 0-3-3L5 17z"/><path d="M14 6l4 4"/>',
        expand_more: '<path d="M6 9l6 6 6-6"/>',
        filter_list: '<path d="M4 6h16M7 12h10M10 18h4"/>',
        group: '<path d="M16 19a4 4 0 0 0-8 0"/><circle cx="12" cy="10" r="3"/><path d="M21 19a3.5 3.5 0 0 0-4-3.4"/><path d="M3 19a3.5 3.5 0 0 1 4-3.4"/><path d="M17 8.5a2.5 2.5 0 0 1 0 5"/><path d="M7 8.5a2.5 2.5 0 0 0 0 5"/>',
        help_outline: '<circle cx="12" cy="12" r="9"/><path d="M9.5 9a2.8 2.8 0 1 1 4.6 2.1c-.9.7-1.6 1.2-1.6 2.4"/><path d="M12 17h.01"/>',
        library_books: '<path d="M5 4h11a2 2 0 0 1 2 2v14H7a2 2 0 0 1-2-2z"/><path d="M8 4v14a2 2 0 0 0 2 2"/><path d="M9 8h6M9 12h6"/>',
        lock: '<rect x="5" y="10" width="14" height="10" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
        logout: '<path d="M10 17l5-5-5-5"/><path d="M15 12H3"/><path d="M14 4h5v16h-5"/>',
        menu: '<path d="M4 7h16M4 12h16M4 17h16"/>',
        menu_book: '<path d="M4 5h7a3 3 0 0 1 3 3v12a3 3 0 0 0-3-3H4z"/><path d="M20 5h-6a3 3 0 0 0-3 3v12a3 3 0 0 1 3-3h6z"/>',
        notifications: '<path d="M18 9a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/><path d="M10 21a2 2 0 0 0 4 0"/>',
        person: '<circle cx="12" cy="8" r="4"/><path d="M5 20a7 7 0 0 1 14 0"/>',
        person_add: '<circle cx="10" cy="8" r="4"/><path d="M3 20a7 7 0 0 1 14 0"/><path d="M19 8v6M16 11h6"/>',
        receipt_long: '<path d="M6 3h12v18l-2-1-2 1-2-1-2 1-2-1-2 1z"/><path d="M9 8h6M9 12h6M9 16h4"/>',
        search: '<circle cx="10.5" cy="10.5" r="6.5"/><path d="M16 16l4 4"/>',
        settings: '<circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.8 1.8 0 0 0 .4 2l.1.1-2 3.4-.2-.1a1.8 1.8 0 0 0-2 .4 1.8 1.8 0 0 0-.6 1.2h-4a1.8 1.8 0 0 0-.6-1.2 1.8 1.8 0 0 0-2-.4l-.2.1-2-3.4.1-.1a1.8 1.8 0 0 0 .4-2 1.8 1.8 0 0 0-1.5-1.1v-4a1.8 1.8 0 0 0 1.5-1.1 1.8 1.8 0 0 0-.4-2l-.1-.1 2-3.4.2.1a1.8 1.8 0 0 0 2-.4A1.8 1.8 0 0 0 11 2h4a1.8 1.8 0 0 0 .6 1.2 1.8 1.8 0 0 0 2 .4l.2-.1 2 3.4-.1.1a1.8 1.8 0 0 0-.4 2 1.8 1.8 0 0 0 1.5 1.1v4a1.8 1.8 0 0 0-1.4.9z"/>',
        shopping_bag: '<path d="M6 8h12l-1 12H7z"/><path d="M9 8a3 3 0 0 1 6 0"/>',
        shopping_cart: '<circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/><path d="M3 4h2l2.2 10.5a2 2 0 0 0 2 1.5h7.9a2 2 0 0 0 1.9-1.4L21 8H7"/>',
        today: '<rect x="4" y="5" width="16" height="15" rx="2"/><path d="M8 3v4M16 3v4M4 10h16"/>',
        warning: '<path d="M12 3l10 18H2z"/><path d="M12 9v5M12 17h.01"/>'
    };

    document.querySelectorAll(".material-symbols-outlined").forEach(function (icon) {
        const name = (icon.dataset.icon || icon.textContent || "").trim();
        if (iconMap[name]) {
            icon.dataset.iconName = name;
            icon.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' + iconMap[name] + '</svg>';
            icon.setAttribute("aria-hidden", "true");
        }
    });
});

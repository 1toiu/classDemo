package cn.gzu.classdemo.util;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

public final class WebUtil {
    private WebUtil() {
    }

    public static Integer getInt(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return Integer.valueOf(value);
    }

    public static int getInt(HttpServletRequest request, String name, int defaultValue) {
        Integer value = getInt(request, name);
        return value == null ? defaultValue : value;
    }

    public static BigDecimal getDecimal(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        return new BigDecimal(value.trim());
    }
}

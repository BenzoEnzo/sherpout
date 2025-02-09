package com.sherpout.server.error.util;

import java.util.Map;

public final class ErrorUtil {
    private ErrorUtil(){}

    public static String fillPlaceholders(String message, Map<String, String> placeholders) {
        if (message == null || placeholders == null) {
            return message;
        }
        String result = message;

        for (Map.Entry<String, String> entry : placeholders.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            result = result.replace(placeholder, entry.getValue());
        }

        return result;
    }
}

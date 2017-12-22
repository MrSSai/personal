package cn.knowsbox.utils;


import org.springframework.beans.factory.annotation.Autowired;

/**
 * Create on 2017/12/22
 * 控制台log输出
 *
 */
@SuppressWarnings({"rawtypes", "unchecked"})
public class LogSout {

    @Autowired
    private static boolean flag = false;

    @Autowired
    public static void logout(String message) {
        if (!flag) {
            System.err.println(message);
        }
    }

    @Autowired
    public static void logout(String message1, String message2) {
        if (!flag) {
            System.err.println(message1 + message2);
        }
    }

    @Autowired
    public static void logout(String message1, String message2, String message3) {
        if (!flag) {
            System.err.println(message1 + message2 + message3);
        }
    }
}

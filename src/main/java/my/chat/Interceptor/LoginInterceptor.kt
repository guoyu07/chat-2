package my.chat.Interceptor

import com.jfinal.aop.Interceptor
import com.jfinal.aop.Invocation
import com.jfinal.core.Controller
import my.chat.common.UserConstants
import my.chat.model.User

/**
 * @author lyu lyusantu@gmail.com
 * *
 * @version V1.0
 * *
 * @Title: ${file_name}
 * *
 * @Description: ${todo}
 * *
 * @date ${date} ${time}
 */
class LoginInterceptor : Interceptor {

    override fun intercept(invocation: Invocation) {
        val controller = invocation.controller
        val user = controller.getSessionAttr<User>(UserConstants.LOGIN_USER)
        //		if (user == null && !invocation.getMethod().getName().equals("index")) {
        if (user == null) {
            controller.setSessionAttr(UserConstants.NOT_LOGIN_ERR_MSG, "您还未登录")
            controller.redirect("/user/login")
        } else {
            invocation.invoke()
        }
    }
}

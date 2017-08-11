package my.chat.controller

import com.jfinal.core.Controller

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
class IndexController : Controller() {

    fun index() {
        renderJsp("/index.jsp")
    }

}

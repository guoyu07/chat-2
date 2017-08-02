package my.chat.controller

import com.jfinal.core.Controller
import my.chat.common.Constants

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
        setAttr(Constants.TITLE, "home").renderJsp("/index.jsp")
    }
}

package my.chat.route

import com.jfinal.config.Routes
import my.chat.controller.ArticleController

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
class ArticleRoute : Routes() {

    override fun config() {
        baseViewPath = "/WEB-INF/view"
        add("/article", ArticleController::class.java)
    }
}

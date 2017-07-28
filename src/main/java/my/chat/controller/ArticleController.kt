package my.chat.controller

import com.jfinal.core.Controller
import my.chat.model.Article
import my.chat.service.ArticleService
import java.util.*

/**
 * @Title: ${file_name}
 * @Description: ${todo}
 * @author lyu lyusantu@gmail.com
 * @date ${date} ${time}
 * @version V1.0
 */
class ArticleController : Controller() {

    internal var article: Article? = null

    companion object {
        internal var articleService = ArticleService()
    }

    fun list() {
        renderJsp("list.jsp")
    }

    fun add() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp("add.jsp")
        } else {
            val flag = getModel(Article::class.java).setPubtime(Date()).save()
            println(flag)
            renderJsp(if (flag) "/article/list" else "/article/add")
        }
    }
}
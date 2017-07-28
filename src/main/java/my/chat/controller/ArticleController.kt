package my.chat.controller

import com.jfinal.core.Controller
import com.jfinal.plugin.activerecord.Page
import my.chat.common.Constants
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
        val p = getParaToInt("p") ?: 1
        val articlePage = articleService.list(p, 10)
        setAttr(Constants.TITLE, "文章列表")
                .setAttr("page", articlePage)
                .renderJsp("list.jsp")
    }

    fun add() {
        if (request.method.equals("GET", ignoreCase = true)) {
            setAttr(Constants.TITLE, "写文章").renderJsp("add.jsp")
        } else {
            val flag = getBean(Article::class.java, "article").setPubtime(Date()).save()
            setAttr(Constants.TITLE, if (flag) "文章列表" else "写文章")
                    .redirect(if (flag) "/article/list" else "/article/add")
        }
    }
}
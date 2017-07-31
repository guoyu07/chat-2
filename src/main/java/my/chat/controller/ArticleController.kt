package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.jfinal.plugin.activerecord.Page
import my.chat.common.Constants
import my.chat.common.UserConstants
import my.chat.model.Article
import my.chat.model.User
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

    @Clear
    fun list() {
        val p = getParaToInt("p") ?: 1
        val articlePage = articleService.list(p, 10, null)
        setAttr(Constants.TITLE, "文章列表")
                .setAttr("way","list")
                .setAttr("page", articlePage)
                .renderJsp("list.jsp")
    }

    fun mylist() {
        val p = getParaToInt("p") ?: 1
        val user: User = getSessionAttr(UserConstants.LOGIN_USER)
        val articlePage = articleService.list(p, 10, user.id)
        setAttr(Constants.TITLE, "我的文章")
                .setAttr("way","mylist")
                .setAttr("page", articlePage)
                .renderJsp("list.jsp")
    }

    @Clear
    fun add() {
        if (request.method.equals("GET", ignoreCase = true)) {
            setAttr(Constants.TITLE, "写文章").renderJsp("add.jsp")
        } else {
            val flag = getBean(Article::class.java, "article").setPubtime(Date()).save()
            setAttr(Constants.TITLE, if (flag) "文章列表" else "写文章")
                    .redirect(if (flag) "/article/list" else "/article/add")
        }
    }

    fun detail() {
        article = articleService.detail(getParaToInt("id"))
        setAttr(Constants.TITLE, article!!.title).setAttr("article", article).renderJsp("show.jsp")
    }

}
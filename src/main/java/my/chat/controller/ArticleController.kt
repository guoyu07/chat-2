package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.jfinal.json.FastJson
import com.jfinal.plugin.activerecord.Record
import com.xiaoleilu.hutool.db.Page
import my.chat.common.UserConstants
import my.chat.model.Article
import my.chat.model.ArticleComment
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

    internal var articleComment: ArticleComment? = null

    companion object {
        internal var articleService = ArticleService()
    }

    @Clear
    fun list() {
        val p = getParaToInt("p") ?: 1
        val articlePage = articleService.list(p, 10, null)
        setAttr("way", "list")
                .setAttr("page", articlePage)
                .renderJsp("list.jsp")
    }

    fun mylist() {
        val p = getParaToInt("p") ?: 1
        val user: User = getSessionAttr(UserConstants.LOGIN_USER)
        val articlePage = articleService.list(p, 10, user.id)
        setAttr("way", "mylist")
                .setAttr("page", articlePage)
                .renderJsp("list.jsp")
    }

    fun add() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp("add.jsp")
        } else {
            val flag = getBean(Article::class.java, "article").setPubtime(Date()).save()
            redirect(if (flag) "/article/list" else "/article/add")
        }
    }

    fun detail() {
        article = articleService.detail(getParaToInt("id"))
        // 已阅读数量+1
        article!!.setReadNum(article!!.readNum!!.toInt() + 1).update()
        // 加载评论
        val page = Page(getParaToInt("p") ?: 1, 1)
        val listComment = articleService.listComment(article!!.id!!, page)
        val from: String? = getPara("from")
        if (from != null && from.equals("leaveMsg"))
            setAttr("leaveMsgSuccess", "留言成功")
        setAttr("article", article)
                .setAttr("page", listComment)
                .setAttr("way", getPara("way"))
                .setAttr("p", getPara("p"))
                .renderJsp("show.jsp")
    }

    // 加载文章评论
    fun loadArticleComments() {
        val aid = getParaToInt("aid")
        val page = Page(getParaToInt("p") ?: 1, 1)
        val listComment = articleService.listComment(aid, page)
        renderJson(listComment)
    }

    // 加载留言
    fun leaveMsg() {
        articleComment = getBean(ArticleComment::class.java, "")
        articleComment!!.setTime(Date()).save()
        // 更改文章评论总数
        articleService.updateArticleCommentCount(articleComment!!.aid!!)
        val url = "/article/detail?id=" + articleComment!!.aid + "&way=" + getPara("way") + "&p=" + getPara("p") + "&from=leaveMsg"
        redirect(url, true)
    }

}
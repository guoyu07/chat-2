package my.chat.controller

import com.jfinal.core.Controller
import com.xiaoleilu.hutool.db.Page
import my.chat.common.UserConstants
import my.chat.model.Tweets
import my.chat.model.TweetsComment
import my.chat.model.User
import my.chat.service.TweetsService
import java.util.*

/**
 * @Title: ${file_name}
 * @Description: ${todo}
 * @author lyu lyusantu@gmail.com
 * @date ${date} ${time}
 * @version V1.0
 */
class TweetsController : Controller() {

    internal var user: User? = null

    internal var tweets: Tweets? = null

    internal var tweetsComment: TweetsComment? = null

    companion object {
        internal var tweetsService = TweetsService()
    }

    fun index() {
        renderJsp("list.jsp")
    }

    fun list() {
        var page = Page(getParaToInt("p"), 10)
        var list = tweetsService.list(page, getPara("way"))
        renderJson(list)
    }

    fun detail() {
        val id = getParaToInt("id")
        val record = tweetsService.detail(id) // 动态

        // 评论
        val page = Page(1, 3)
        val list = tweetsService.loadTweetsComments(page, id)

        setAttr("list", list)
                .setAttr("tweets", record)
                .renderJsp("show.jsp")
    }

    fun add() {
        user = getSessionAttr(UserConstants.LOGIN_USER)
        tweets = getBean(Tweets::class.java, "")
        tweets!!.setUid(user?.id)
                .setUname(user?.nickname)
                .setTime(Date())
                .setComments(0).save()
        renderJsp("list.jsp")
    }

    // 添加评论
    fun addComment() {
        if (getBean(TweetsComment::class.java, "")
                .setPcid(0)
                .setType(0)
                .setTime(Date()).save()) {
            tweetsService.updateTweetsCommentCount(getParaToInt("cid")) // 更改评论数
            redirect("/tweets/detail?id=" + getPara("cid"), true)
        }
    }

    fun loadTweetsComments() {
        val p = getParaToInt("p")
        val page = Page(p, 3)
        val list = tweetsService.loadTweetsComments(page, getParaToInt("id"))
        renderJson(list)
    }

    /**
     * 评论的设计
     * cid -> 动态ID
     * uid -> 评论者ID
     * p_cid -> 回复的评论者ID -- 待定
     * type -> 评论/回复
     */
}
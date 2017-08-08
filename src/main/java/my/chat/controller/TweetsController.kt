package my.chat.controller

import com.jfinal.core.Controller
import com.xiaoleilu.hutool.db.Page
import my.chat.common.UserConstants
import my.chat.model.Tweets
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

    companion object {
        internal var tweetsService = TweetsService()
    }

    fun index() {
        renderJsp("list.jsp")
    }

    fun list() {
        var page = Page(getParaToInt("p"), 10)
        var list = tweetsService.list(page)
        renderJson(list)
    }

    fun add() {
        user = getSessionAttr(UserConstants.LOGIN_USER)
        tweets = getBean(Tweets::class.java, "")
        tweets!!.setUid(user!!.id)
                .setUname(user!!.nickname)
                .setTime(Date())
                .setComments(0).save()
        renderJsp("list.jsp")
    }

}
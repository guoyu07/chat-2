package my.chat.service

import com.jfinal.plugin.activerecord.Db
import com.jfinal.plugin.activerecord.Record
import com.xiaoleilu.hutool.db.Page
import my.chat.model.Tweets

/**
 * @Title: ${file_name}
 * @Description: ${todo}
 * @author lyu lyusantu@gmail.com
 * @date ${date} ${time}
 * @version V1.0
 */
class TweetsService {

    companion object {
        private val dao = Tweets().dao()
    }

    fun list(page: Page, way: String): com.jfinal.plugin.activerecord.Page<Record>? {
        val sqlPrifix = "SELECT t.*,u.picSummary ulogo"
        var order: String? = null
        when (way) {
            "hot" -> order = "ORDER BY comments DESC" // 最热按照评论加载,后续需考虑时间及点赞
            "new" -> order = "ORDER BY time DESC"
        }
        val sqlSuffix = "FROM tweets t,user u WHERE t.uid=u.id $order"
        return Db.paginate(page.pageNumber, page.numPerPage, sqlPrifix, sqlSuffix)
    }

    fun detail(id: Int): Record? {
        val sql = "SELECT t.*,u.picSummary ulogo FROM tweets t,user u WHERE t.uid=u.id AND t.id=$id"
        return Db.findFirst(sql)
    }

    fun updateTweetsCommentCount(id: Int) {
        Db.update("UPDATE tweets SET comments = comments + 1 WHERE id=?", id)
    }

    fun loadTweetsComments(page: Page, id: Int): com.jfinal.plugin.activerecord.Page<Record>? {
        val sqlPrefix = "SELECT t.*,u.picSummary ulogo,u.nickname uname"
        val sqlSuffix = "FROM tweets_comment t,user u WHERE t.uid=u.id AND t.cid=$id ORDER BY t.id ASC,t.time DESC"
        return Db.paginate(page.pageNumber, page.numPerPage, sqlPrefix, sqlSuffix)
    }
}
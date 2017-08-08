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

    fun list(page: Page): com.jfinal.plugin.activerecord.Page<Record>? {
        val sqlPrifix = "SELECT t.*,u.picSummary ulogo"
        val sqlSuffix = "FROM tweets t,user u WHERE t.uid=u.id ORDER BY t.id DESC"
        return Db.paginate(page.pageNumber, page.numPerPage, sqlPrifix, sqlSuffix)
    }
}
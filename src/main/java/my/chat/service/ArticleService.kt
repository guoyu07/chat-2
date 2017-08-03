package my.chat.service

import com.jfinal.plugin.activerecord.Db
import com.jfinal.plugin.activerecord.Page
import com.jfinal.plugin.activerecord.Record
import my.chat.model.Article
import java.util.*

/**
 * @Title: ${file_name}
 * @Description: ${todo}
 * @author lyu lyusantu@gmail.com
 * @date ${date} ${time}
 * @version V1.0
 */
class ArticleService {

    companion object {
        private val dao = Article().dao()
    }

    fun list(p: Int, size: Int, id: Int?): Page<Article>? {
        val sqlPrifix = "SELECT *"
        val name = if (Objects.isNull(id)) "" else " WHERE authorId=" + id
        val sqlSuffix = StringBuffer("FROM article $name ORDER BY id DESC")
        return dao.paginate(p, size, sqlPrifix, sqlSuffix.toString())
    }

    fun detail(id: Int): Article? {
        return dao.findById(id)
    }

    fun listComment(aid: Int, page: com.xiaoleilu.hutool.db.Page): Page<Record> {
        val sqlPrifix = "SELECT c.content content,c.time time,u.nickname name,u.picSummary pic"
        val sqlSuffix = "FROM article_comment c,user u WHERE c.uid=u.id AND c.aid=?"
        return Db.paginate(page.pageNumber, page.numPerPage, sqlPrifix, sqlSuffix, aid)
    }

    fun updateArticleCommentCount(id: Int) {
        Db.update("UPDATE article SET comments = comments + 1 WHERE id=?", id)
    }
}
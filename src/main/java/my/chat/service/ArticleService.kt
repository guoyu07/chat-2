package my.chat.service

import com.jfinal.plugin.activerecord.Page
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
        val sqlSuffix = StringBuffer("FROM article $name ORDER BY pubtime DESC")
        return dao.paginate(p, size, sqlPrifix, sqlSuffix.toString())
    }

    fun detail(id: Int): Article? {
        return dao.findById(id)
    }
}
package my.chat.service

import com.jfinal.plugin.activerecord.Page
import my.chat.model.Article

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

    fun list(p: Int, size: Int): Page<Article>? {
        val sqlPrifix = "SELECT *"
        val sqlSuffix = StringBuffer("FROM article ORDER BY pubtime DESC")
        return dao.paginate(p, size, sqlPrifix, sqlSuffix.toString())
    }

}
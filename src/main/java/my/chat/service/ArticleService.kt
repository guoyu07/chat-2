package my.chat.service

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

}
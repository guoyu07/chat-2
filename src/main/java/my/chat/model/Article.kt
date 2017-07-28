package my.chat.model

import my.chat.model.base.BaseArticle

/**
 * @author lyu lyusantu@gmail.com
 * *
 * @version V1.0
 * *
 * @Title: ${file_name}
 * *
 * @Description: ${todo}
 * *
 * @date ${date} ${time}
 */
class Article : BaseArticle<Article>() {
    companion object {
        val dao = Article().dao()
    }
}


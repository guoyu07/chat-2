package my.chat.model.base

import com.jfinal.plugin.activerecord.IBean
import com.jfinal.plugin.activerecord.Model

/**
 * Generated by JFinal, do not modify this file.
 */
abstract class BaseArticle<M : BaseArticle<M>> : Model<M>(), IBean {

    fun setId(id: Int?): M {
        set("id", id)
        return this as M
    }

    val id: Int?
        get() = get<Int>("id")

    fun setTitle(title: String?): M {
        set("title", title)
        return this as M
    }

    val title: String?
        get() = get("title")

    fun setKeywords(keywords: String?): M {
        set("keywords", keywords)
        return this as M
    }

    val keywords: String?
        get() = get("keywords")

    fun setContent(content: String?): M {
        set("content", content)
        return this as M
    }

    val content: String?
        get() = get("content")

    fun setPubtime(pubtime: java.util.Date): M {
        set("pubtime", pubtime)
        return this as M
    }

    val pubtime: java.util.Date
        get() = get("pubtime")

    fun setAuthorId(authorId: Int?): M {
        set("authorId", authorId)
        return this as M
    }

    val authorId: Int?
        get() = get<Int>("authorId")

    fun setAuthorName(authorName: String?): M {
        set("authorName", authorName)
        return this as M
    }

    val authorName: String?
        get() = get("authorName")

}
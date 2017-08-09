package my.chat.model.base

import com.jfinal.plugin.activerecord.IBean
import com.jfinal.plugin.activerecord.Model
import java.util.*

/**
 * Generated by JFinal, do not modify this file.
 */
abstract class BaseTweetsComment<M : BaseTweetsComment<M>> : Model<M>(), IBean {

    fun setId(id: Int?): M {
        set("id", id)
        return this as M
    }

    val id: Int?
        get() = get<Int>("id")

    fun setUid(uid: Int?): M {
        set("uid", uid)
        return this as M
    }

    val uid: Int?
        get() = get<Int>("uid")

    fun setCid(cid: Int?): M {
        set("cid", cid)
        return this as M
    }

    val cid: Int?
        get() = get<Int>("cid")

    fun setPcid(p_cid: Int?): M {
        set("p_cid", p_cid)
        return this as M
    }

    val p_cid: Int?
        get() = get<Int>("p_cid")

    fun setType(type: Int?): M {
        set("type", type)
        return this as M
    }

    val type: Int?
        get() = get<Int>("type")

    fun setContent(content: String?): M {
        set("content", content)
        return this as M
    }

    val content: String?
        get() = get("content")


    fun setTime(time: Date): M {
        set("time", time)
        return this as M
    }

    val time: Date
        get() = get("time")
}
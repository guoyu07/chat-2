package my.chat.model.base

import com.jfinal.plugin.activerecord.IBean
import com.jfinal.plugin.activerecord.Model

/**
 * Generated by JFinal, do not modify this file.
 */
abstract class BaseSingers<M : BaseSingers<M>> : Model<M>(), IBean {

    fun setId(id: Int?): M {
        set("id", id)
        return this as M
    }

    val id: Int?
        get() = get<Int>("id")

    fun setName(name: String?): M {
        set("name", name)
        return this as M
    }

    val name: String?
        get() = get("name")

    fun setMusic(music: String?): M {
        set("music", music)
        return this as M
    }

    val music: String?
        get() = get("music")

    fun setHomepage(homepage: String?): M {
        set("homepage", homepage)
        return this as M
    }

    val homepage: String?
        get() = get("homepage")

    fun setType(type: Int?): M {
        set("type", type)
        return this as M
    }

    val type: Int?
        get() = get<Int>("type")

    fun setInitials(initials: String?): M {
        set("initials", initials)
        return this as M
    }

    val initials: String?
        get() = get("initials")

    fun setSingerid(singerid: Int?): M {
        set("singerid", singerid)
        return this as M
    }

    val singerid: Int?
        get() = get<Int>("singerid")

}

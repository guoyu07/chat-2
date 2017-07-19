package my.chat.model.base

import com.jfinal.plugin.activerecord.IBean
import com.jfinal.plugin.activerecord.Model

/**
 * Generated by JFinal, do not modify this file.
 */
abstract class BaseAlbum<M : BaseAlbum<M>> : Model<M>(), IBean {

    fun setId(id: Int?): M {
        set("id", id)
        return this as M
    }

    val id: Int?
        get() = get<Int>("id")

    fun setSingerid(singerid: Int?): M {
        set("singerid", singerid)
        return this as M
    }

    val singerid: Int?
        get() = get<Int>("singerid")

    fun setAlbumname(albumname: String?): M {
        set("albumname", albumname)
        return this as M
    }

    val albumname: String?
        get() = get("albumname")

    fun setAlbumurl(albumurl: String?): M {
        set("albumurl", albumurl)
        return this as M
    }

    val albumurl: String?
        get() = get("albumurl")

    fun setAlbumdate(albumdate: String?): M {
        set("albumdate", albumdate)
        return this as M
    }

    val albumdate: String?
        get() = get("albumdate")

    fun setAlbumpic(albumpic: String?): M {
        set("albumpic", albumpic)
        return this as M
    }

    val albumpic: String?
        get() = get("albumpic")

}

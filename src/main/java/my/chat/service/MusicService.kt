package my.chat.service

import com.jfinal.plugin.activerecord.Page
import com.xiaoleilu.hutool.util.ObjectUtil
import my.chat.model.Songs

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
class MusicService {

    companion object {

        private val dao = Songs().dao()
    }

    fun listSongs(pageNumber: String?, pageSize: Int, queryName: String?, songs: String?, album: String?, singers: String?): Page<Songs>? {
        var queryName = queryName
        val sqlPrifix = "SELECT s.id,s.name,s.url,s.mvurl,s.alias,s.duration,a.albumname,a.albumurl,ss.name AS sname,ss.homepage"
        val sqlSuffix = StringBuffer("FROM songs s,album a,singers ss WHERE s.albumid=a.id AND a.singerid=ss.id")
        var page: Page<Songs>? = null
        queryName = if (ObjectUtil.isNull(queryName)) queryName else "%$queryName%"
        val p = if (pageNumber == null) 1 else Integer.parseInt(pageNumber)
        if (ObjectUtil.isNull(queryName))
            page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString())
        else {
            sqlSuffix.append(" AND (")
            if (songs == null && album == null && singers == null) {

            } else if (songs == null && album != null && singers == null) {
                sqlSuffix.append("a.albumname LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName)
            } else if (songs == null && album == null && singers != null) {
                sqlSuffix.append("ss.name LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName)
            } else if (songs == null && album != null && singers != null) {
                sqlSuffix.append("a.albumname LIKE ? OR ss.name LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName, queryName)
            } else if (songs != null && album != null && singers != null) {
                sqlSuffix.append("s.name LIKE ? OR a.albumname LIKE ? OR ss.name LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName, queryName, queryName)
            } else if (songs != null && album == null && singers == null) {
                sqlSuffix.append("s.name LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName)
            } else if (songs != null && album != null && singers == null) {
                sqlSuffix.append("s.name LIKE ? OR a.albumname LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName, queryName)
            } else if (songs != null && album == null && singers != null) {
                sqlSuffix.append("s.name LIKE ? OR ss.name LIKE ?)")
                page = dao.paginate(p, pageSize, sqlPrifix, sqlSuffix.toString(), queryName, queryName)
            }
        }
        return page
    }

}

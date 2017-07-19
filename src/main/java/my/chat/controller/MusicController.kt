package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.jfinal.plugin.activerecord.Page
import com.xiaoleilu.hutool.util.ObjectUtil
import my.chat.common.Constants
import my.chat.common.MusicConstants
import my.chat.common.ViewConstants
import my.chat.model.Songs
import my.chat.service.MusicService

import java.io.UnsupportedEncodingException

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
class MusicController : Controller() {

    companion object {
        internal var musicService = MusicService()
    }

    @Clear
    @Throws(UnsupportedEncodingException::class)
    fun listSongs() {
        val pageNumber = getPara("p")
        val queryName = getPara("q")
        var songs = getPara("songs")
        var album = getPara("album")
        var singers = getPara("singers")
        if (ObjectUtil.isNull(pageNumber) && ObjectUtil.isNull(queryName) && "GET".equals(request.method, ignoreCase = true)) {
            songs = ""
            album = ""
            singers = ""
        }
        val songsPage = musicService.listSongs(pageNumber, 15, queryName, songs, album, singers)
        setAttr(MusicConstants.SONGS_PAGE, songsPage).setAttr(MusicConstants.QUERY_NAME, queryName)
                .setAttr("songs", songs).setAttr("album", album).setAttr("singers", singers)
                .setAttr(Constants.TITLE, "music").renderJsp(ViewConstants.SONGS)
    }

}

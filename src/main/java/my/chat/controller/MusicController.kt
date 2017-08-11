package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.xiaoleilu.hutool.util.ObjectUtil
import my.chat.common.MusicConstants
import my.chat.model.Songs
import my.chat.plugin.ZXingCode
import my.chat.service.MusicService
import java.io.File
import java.io.FileInputStream
import java.net.URLEncoder

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
@Clear
class MusicController : Controller() {

    internal var song: Songs? = null

    companion object {
        internal var musicService = MusicService()
    }

    fun list() {
        val pageNumber = getPara("p")
        val queryName = getPara("q")
        var songs = getPara("songs")
        var album = getPara("album")
        var singers = getPara("singers")
        if (!ObjectUtil.isNull(queryName)) {
            songs = if (songs.equals("true")) songs else null
            album = if (album.equals("true")) album else null
            singers = if (singers.equals("true")) singers else null
        }
        val songsPage = musicService.listSongs(pageNumber, 15, queryName, songs, album, singers)
        if (ObjectUtil.isNull(queryName)) {
            songs = "1"
            album = "1"
            singers = "1"
        } else {
            songs = if (songs == null) null else "1"
            album = if (album == null) null else "1"
            singers = if (singers == null) null else "1"
        }
        setAttr("page", songsPage)
                .setAttr(MusicConstants.QUERY_NAME, queryName)
                .setAttr("songs", songs)
                .setAttr("album", album)
                .setAttr("singers", singers)
                .renderJsp("list.jsp")
    }

    fun addSong() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp("add.jsp")
        } else {
            getBean(Songs::class.java, "").save()
            setAttr("addMsg", "添加歌曲成功")
                    .renderJsp("add.jsp")
        }
    }

    fun showQRCode() {
        renderJsp("qrcode.jsp")
    }

    fun createQRCode() {
        ZXingCode.writeToStream("http://www.baidu.com", "content", "D:/111.jpg", response, session)
    }

    fun downloadQRCode() {
        val realpath = session.servletContext.getRealPath("/qrcode")
        val file = File(realpath)
        if (!file.exists()) {
            file.mkdir()
        }
        val fileName = System.currentTimeMillis().toString() + ".jpg"
        val path = realpath + "/" + fileName
//        EncoderImage.writeToFile("http://www.baidu.com", File(path), session)
        val url = "http://www.taobao.com"
        val content = "123456789"
        ZXingCode.writeToFile(url, content, "D:/111.jpg", File(path), session)
        val iS = FileInputStream(path)
        val os = response.outputStream
        response.addHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"))
        val byte = ByteArray(1024)
        var size = iS.read(byte)
        while (size > 0) {
            os.write(byte, 0, size)
            size = iS.read(byte)
        }
        iS.close()
        os.close()
        renderNull()
    }
}

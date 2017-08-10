package my.chat.controller

import com.jfinal.core.Controller
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

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
class SocialController : Controller() {

    private var url: URL? = null

    private var connection: HttpURLConnection? = null

    private val TULING_KEY = "33d9d03c00384cbea267a38992f5a276"

    fun index() {
        renderJsp("chat.jsp")
    }

    @Throws(IOException::class)
    fun robot() {
        if ("POST".equals(request.method, ignoreCase = true)) {
            val question = getPara("question")
            val url = "http://www.tuling123.com/openapi/api?key=$TULING_KEY&info=$question"
            renderJson(getJson(url))
        }else{
            renderJsp("robot.jsp")
        }
    }

    @Throws(IOException::class)
    fun getJson(url: String): String {
        this.url = URL(url)
        connection = this.url!!.openConnection() as HttpURLConnection
        connection!!.connect()
        val reader = BufferedReader(InputStreamReader(connection!!.inputStream))
        val sb = StringBuffer()
        reader.forEachLine {
            sb.append(it)
        }
        reader.close()
        connection!!.disconnect()
        return sb.toString()
    }
}

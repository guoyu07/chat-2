package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import my.chat.common.ViewConstants

import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import java.text.SimpleDateFormat
import java.util.Date

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
class APIController : Controller() {

    private var url: URL? = null

    private var line: String? = null

    private var connection: HttpURLConnection? = null

    private val MOB_KEY = "1f5ea010d1ff0"

    private val TULING_KEY = "33d9d03c00384cbea267a38992f5a276"

    fun robot() {
        renderJsp(ViewConstants.ROBOT)
    }

    @Throws(IOException::class)
    fun tuling() {
        val question = getPara("question")
        val url = "http://www.tuling123.com/openapi/api?key=$TULING_KEY&info=$question"
        renderJson(getJson(url))
    }

    @Throws(IOException::class)
    fun todayOnHistory() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp(ViewConstants.TODAYONHISTORY)
        } else {
            val url = "http://apicloud.mob.com/appstore/history/query?key=" + MOB_KEY + "&day=" + SimpleDateFormat("MMdd").format(Date())
            renderJson(getJson(url))
        }
    }

    @Throws(IOException::class)
    fun weather() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp(ViewConstants.WEATHER)
        } else {
            val url = "http://www.sojson.com/open/api/weather/json.shtml?city=" + getPara("city")
            renderJson(getJson(url))
        }
    }

    /*
		待用 -- 没获取到..
	 */
    @Throws(IOException::class)
    fun getWeather() {
        val url = "apicloud.mob.com/v1/weather/query?key=$MOB_KEY&city=深圳"
        renderJson(getJson(url))
    }

    /*
		获取手机号码信息
	 */
    @Throws(IOException::class)
    fun mobile() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp(ViewConstants.PHONE)
        } else {
            val url = "http://apicloud.mob.com/v1/mobile/address/query?key=" + MOB_KEY + "&phone=" + getPara("phone")
            renderJson(getJson(url))
        }
    }

    @Throws(IOException::class)
    fun luckyMobile() {
        val url = "http://apicloud.mob.com/appstore/lucky/mobile/query?key=" + MOB_KEY + "&mobile=" + getPara("phone")
        renderJson(getJson(url))
    }

    @Throws(IOException::class)
    fun dream() {
        if (request.method.equals("GET", ignoreCase = true)) {
            renderJsp(ViewConstants.DREAM)
        } else {
            val url = "http://apicloud.mob.com/appstore/dream/search?key=" + MOB_KEY + "&name=" + getPara("name")
            renderJson(getJson(url))
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

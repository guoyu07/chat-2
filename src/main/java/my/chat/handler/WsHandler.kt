package my.chat.handler

import com.jfinal.handler.Handler
import com.jfinal.kit.StrKit
import java.util.regex.Pattern
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

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
class WsHandler(filterUrlRegx: String) : Handler() {

    private val filterUrlRegxPattern: Pattern

    init {
        if (StrKit.isBlank(filterUrlRegx))
            throw IllegalArgumentException("The para filterUrlRegx can not be blank.")
        filterUrlRegxPattern = Pattern.compile(filterUrlRegx)
    }


    override fun handle(target: String, request: HttpServletRequest, response: HttpServletResponse, isHandled: BooleanArray) {
        if (filterUrlRegxPattern.matcher(target).find())
            return
        else
            next.handle(target, request, response, isHandled)
    }
}

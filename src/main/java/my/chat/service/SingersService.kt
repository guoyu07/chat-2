package my.chat.service

import com.jfinal.plugin.activerecord.Page
import my.chat.model.Singers

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
class SingersService {

    fun list(): Page<Singers> {
        val page = dao.paginate(1, 10, "select *", "from singers")
        return page
    }

    companion object {

        private val dao = Singers().dao()
    }
}

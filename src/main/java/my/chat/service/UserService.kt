package my.chat.service

import com.xiaoleilu.hutool.crypto.SecureUtil
import com.xiaoleilu.hutool.util.ObjectUtil
import com.xiaoleilu.hutool.util.ReUtil
import my.chat.model.User
import java.util.*

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
class UserService {

    fun register(user: User): Boolean {
        user.setStatus(0)
                .setRegisterTime(Date())
                .setPassword(SecureUtil.md5(user!!.password))
        try {
            user.save()
            return user!!.id != null
        } catch (e: Exception) {
            return false
        }

    }

    fun login(user: User, username: String): User {
        user.setPassword(SecureUtil.md5(user.password))
        val sb = StringBuffer()
        sb.append("select * from user where password = ? and")
        if (ReUtil.isMatch("((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}", username))
            sb.append(" phone = ?")
        else if (ReUtil.isMatch("[A-Za-z0-9.\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+", username))
            sb.append(" email = ?")
        else
            sb.append(" username = ?")
        return userDao.findFirst(sb.toString(), user.password, username)
    }


    fun activate(email: String): User? {
        val user = userDao.findFirst("select id,status,sessionStr from user where email = ?", email)
        return if (ObjectUtil.isNull(user)) null else user
    }

    fun checkEmail(email: String): Boolean {
        println(userDao.find("select id from user where email = ?", email).size)
        return userDao.find("select id from user where email = ?", email).size > 0
    }

    companion object {

        private val userDao = User().dao()
    }
}

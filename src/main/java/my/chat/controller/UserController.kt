package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.jfinal.upload.UploadFile
import com.jfplugin.mail.MailKit
import com.xiaoleilu.hutool.util.ObjectUtil
import my.chat.common.Constants
import my.chat.plugin.Mail
import my.chat.common.UserConstants
import my.chat.common.ViewConstants
import my.chat.model.User
import my.chat.service.UserService

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

class UserController : Controller() {

    internal var user: User? = null

    companion object {
        internal var userService = UserService()
    }

    @Clear
    fun register() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            setAttr(Constants.TITLE, "login").renderJsp(ViewConstants.REGISTER)
        } else {
            user = getModel(User::class.java).setSessionStr(session.id)
            if (userService.register(user!!)) {
                // 发送激活邮件
                MailKit.send(user!!.email, null, Mail.MAIL_TITLE, Mail.getMailText(user!!.email!!, user!!.sessionStr!!, url))
                redirect("/user/waitActivate?email=" + user!!.email, true)
            } else {
                setAttr(UserConstants.REG_ERR_MSG, UserConstants.MAIL_HAS_EXISTS).renderJsp(ViewConstants.REGISTER)
            }
        }
    }

    @Clear
    fun login() {
        if ("GET".equals(request.method, ignoreCase = true))
//            setAttr(UserConstants.LOGIN_ERR_MSG, getSessionAttr(UserConstants.NOT_LOGIN_ERR_MSG))
            setAttr(UserConstants.USERNAME, getPara("email"))
                    .removeSessionAttr(UserConstants.NOT_LOGIN_ERR_MSG)
                    .setAttr(Constants.TITLE, "login")
                    .renderJsp(ViewConstants.LOGIN)
        else {
            val username = getPara(UserConstants.USERNAME)
            user = userService.login(getBean(User::class.java), username)
            if (ObjectUtil.isNull(user)) {
                setAttr(UserConstants.USERNAME, username)
                        .setAttr(UserConstants.LOGIN_ERR_MSG, UserConstants.USER_NOT_EXISTS)
                        .renderJsp(ViewConstants.LOGIN)
            } else {
                if (user!!.status == 1) {
                    // 是否勾选记录用户? wait
                    user!!.setLastLoginTime(Date()).update() // 更改最后一次登录时间
                    setSessionAttr(UserConstants.LOGIN_USER, user).redirect("/")
                } else {
                    setAttr(UserConstants.LOGIN_ERR_MSG, (if (user!!.status == 0) UserConstants.ACCOUNT_NOT_ACTIVATED else UserConstants.ACCOUNT_HAS_BANNED))
                            .renderJsp(ViewConstants.LOGIN)
                }
            }
        }
    }

    @Clear
    fun activate() {
        val email = getPara("email")
        var activate_msg = ""
        user = userService.activate(email)
        if (ObjectUtil.isNull(user))
            activate_msg = UserConstants.ACCOUNT_NOT_EXISTS
        else if (user!!.status === 2)
            activate_msg = UserConstants.ACCOUNT_HAS_BANNED
        else if (user!!.status === 1)
            activate_msg = "该账户已属于激活状态&nbsp;<a href='/user/login?email=$email'>立即登录</a>"
        else if (user!!.status === 0 && user!!.sessionStr.equals(getPara(UserConstants.ACTIVATE_CODE), ignoreCase = true)) {
            activate_msg = if (user!!.setStatus(1).setActivateTime(Date()).update()) "<a href='/user/login?email=$email'>激活成功,立即登录吧</a>" else ""
        } else if (user!!.status === 0 && !user!!.sessionStr.equals(getPara(UserConstants.ACTIVATE_CODE), ignoreCase = true))
            activate_msg = UserConstants.MAIL_ACTIVE_FAILED
        setAttr(UserConstants.ACTIVATE_MSG, activate_msg).renderJsp(ViewConstants.ACTIVATE)
    }

    @Clear
    fun checkEmail() = renderText(if (userService.checkEmail(getPara("email"))) "true" else "false")

    @Clear
    fun waitActivate() = setAttr("email", getPara("email")).renderJsp(ViewConstants.WAITACTIVATE)

    fun exit() = removeSessionAttr(UserConstants.LOGIN_USER).redirect("/")

    fun my() = setAttr(Constants.TITLE, "个人信息").renderJsp(ViewConstants.MYINFO)

    // 修改头像
    fun modifyAvatar() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp("modifyAvatar.jsp");
        }
    }

    // 修改密码
    fun modifyPwd() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp("modifyPwd.jsp")
        }
    }

    fun update() {
        user = getModel(User::class.java)
        user!!.update()
        setSessionAttr(UserConstants.LOGIN_USER, user!!.findById(user!!.id)).redirect("/user/my")
    }

    fun updateAjax() {
        // 设置session user
        user = getModel(User::class.java)
        setAttr(UserConstants.AJAX_ERR_MSG, user!!.update()).setSessionAttr(UserConstants.LOGIN_USER, user!!.findById(user!!.id)).renderJson()
    }

    val url: String
        get() {
            val uri = request.requestURI
            val url = request.requestURL
            return url.substring(0, url.indexOf(uri))
        }

}

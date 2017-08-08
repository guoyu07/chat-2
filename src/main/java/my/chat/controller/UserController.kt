package my.chat.controller

import com.jfinal.aop.Clear
import com.jfinal.core.Controller
import com.jfinal.plugin.activerecord.Record
import com.jfplugin.mail.MailKit
import com.xiaoleilu.hutool.crypto.SecureUtil
import com.xiaoleilu.hutool.util.ObjectUtil
import my.chat.common.UserConstants
import my.chat.common.ViewConstants
import my.chat.model.User
import my.chat.plugin.Mail
import my.chat.service.UserService
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

class UserController : Controller() {

    internal var user: User? = null

    companion object {
        internal var userService = UserService()
    }

    @Clear
    fun register() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp(ViewConstants.REGISTER)
        } else {
            user = getModel(User::class.java).setSessionStr(session.id)
            if (userService.register(user!!)) {
                // 发送激活邮件
                MailKit.send(user!!.email, null, Mail.MAIL_TITLE_ACTIVE, Mail.getMailText(user!!.email!!, user!!.sessionStr!!, url))
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

    fun profile() = setAttr("way", "my").renderJsp(ViewConstants.PROFILE)

    // 修改个人信息
    fun modifyInfo() {
        if ("POST".equals(request.method, ignoreCase = true)) {
            user = getSessionAttr(UserConstants.LOGIN_USER)
            val modifyUser = getBean(User::class.java)
            user!!.setGender(modifyUser.gender)
                    .setDescription(modifyUser.description)
                    .setAddressDetails(modifyUser.addressDetails)
                    .update()
            setSessionAttr(UserConstants.LOGIN_USER, user)
                    .setAttr("way", "my")
                    .renderJsp(ViewConstants.PROFILE)
        }
    }

    // 修改头像
    fun modifyAvatar() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp("modifyAvatar.jsp")
        } else {
            val logo = getPara("logo")
            user = getSessionAttr(UserConstants.LOGIN_USER)
            user!!.setPicSummary(logo).update()
            setSessionAttr(UserConstants.LOGIN_USER, user)
                    .renderJsp("modifyAvatar.jsp")
        }
    }

    // 修改密码
    fun modifyPwd() {
        if ("POST".equals(request.method, ignoreCase = true)) {
            user = getSessionAttr(UserConstants.LOGIN_USER)
            user!!.setPassword(SecureUtil.md5(getPara("password"))).update()
            setSessionAttr(UserConstants.LOGIN_USER, user)
                    .setAttr("modifyPwdMsg", "修改密码成功")
                    .renderJsp(ViewConstants.MODIFY_PWD)
        } else {
            renderJsp(ViewConstants.MODIFY_PWD)
        }
    }

    @Clear
    fun modifyPwdAjax() {
        val id = getParaToInt("id")
        val pwd = getPara("pwd")
        var ret = "0"
        var msg = "修改密码成功"
        user = User().findById(id)
        if (!user!!.setPassword(SecureUtil.md5(pwd)).update()) {
            ret = "1"
            msg = "修改密码失败"
        }
        val json = Record()
        renderJson(json.set("ret", ret).set("msg", msg))
    }

    // 忘记密码
    @Clear
    fun forgetPwd() {
        if ("GET".equals(request.method, ignoreCase = true)) {
            renderJsp("forgetPwd.jsp")
        } else {
            renderJsp("login.jsp")
        }
    }

    // 检查邮箱是否存在
    @Clear
    fun verifyMailExists() {
        var id = 0
        var ret = "1"
        var msg = "您输入的邮箱不存在"
        val uuid = UUID.randomUUID().toString()
        val mail = getPara("mail")
        val list = userService.verifyMailExists(mail)
        if (list!!.size > 0) {
            user = list!!.get(0)
            when (user!!.status!!) {
                0 -> { // 未激活,输入标识码激活并更改密码
                    ret = "0"
                    msg = "您的账户未激活! 请输入标识码以激活您的账户并更改您的密码"
                    MailKit.send(mail, null, Mail.MAIL_TITLE_FORGET, Mail.getMailText(user!!.email!!, uuid, url))
                }
                1 -> {
                    //  发送标识码
                    ret = "0"
                    msg = "请输入标识码以更改您的密码"
                    MailKit.send(mail, null, Mail.MAIL_TITLE_FORGET, Mail.getMailText(user!!.email!!, uuid, url))
                }
                2 -> {
                    ret = "1"
                    msg = "您的账户已被禁封"
                }
            }
        }
        val map = Record()
        id = if (Objects.isNull(user)) 0 else user!!.id!!
        renderJson(map.set("ret", ret).set("msg", msg).set("uuid", uuid).set("id", id))
    }

    val url: String
        get() {
            val uri = request.requestURI
            val url = request.requestURL
            return url.substring(0, url.indexOf(uri))
        }

}

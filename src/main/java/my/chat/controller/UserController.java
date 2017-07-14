package my.chat.controller;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;
import com.jfplugin.mail.MailKit;
import com.xiaoleilu.hutool.util.ObjectUtil;
import my.chat.common.Constants;
import my.chat.common.Mail;
import my.chat.common.UserConstants;
import my.chat.model.User;
import my.chat.service.UserService;

import java.util.Date;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */

public class UserController extends Controller {

	static UserService userService = new UserService();

	User user = null;

	@Clear
	public void register() {
		if ("GET".equalsIgnoreCase(getRequest().getMethod())) {
			setAttr(Constants.TITLE,"login").renderJsp("register.jsp");
		} else {
			user = getModel(User.class).setSessionStr(getSession().getId());
			if (userService.register(user)) {
				// 发送激活邮件
				MailKit.send(user.getEmail(), null, Mail.MAIL_TITLE, Mail.getMailText(user.getEmail(), user.getSessionStr(), getUrl()));
				redirect("/user/waitActivate?email=" + user.getEmail(), true);
			} else {
				setAttr(UserConstants.REG_ERR_MSG, "该邮箱已存在！").renderJsp("register.jsp");
			}
		}
	}

	@Clear
	public void login() {
		if ("GET".equalsIgnoreCase(getRequest().getMethod()))
			setAttr(UserConstants.LOGIN_ERR_MSG, getSessionAttr(UserConstants.NOT_LOGIN_ERR_MSG))
					.setAttr(UserConstants.USERNAME, getPara("email"))
					.removeSessionAttr(UserConstants.NOT_LOGIN_ERR_MSG)
					.setAttr(Constants.TITLE,"login").renderJsp("login.jsp");
		else {
			String username = getPara(UserConstants.USERNAME);
			user = userService.login(getBean(User.class), username);
			if (ObjectUtil.isNull(user)) {
				setAttr(UserConstants.USERNAME, username).setAttr(UserConstants.LOGIN_ERR_MSG, "用户名不存在或密码错误").renderJsp("login.jsp");
			} else {
				if (user.getStatus() == 0)
					setAttr(UserConstants.LOGIN_ERR_MSG, "该账户还未激活").renderJsp("login.jsp");
				else if (user.getStatus() == 2)
					setAttr(UserConstants.LOGIN_ERR_MSG, "该账户已被禁封").renderJsp("login.jsp");
				else if (user.getStatus() == 1) {
					// 是否勾选记录用户? wait
					user.setLastLoginTime(new Date()).update();
					setSessionAttr(UserConstants.LOGIN_USER, user).redirect("/");
				}
			}
		}
	}

	@Clear
	public void activate() {
		String email = getPara("email");
		String activate_msg = "";
		user = userService.activate(email);
		if (ObjectUtil.isNull(user))
			activate_msg = "该账户不存在";
		else if (user.getStatus() == 2)
			activate_msg = "该账户已属于禁封状态";
		else if (user.getStatus() == 1)
			activate_msg = "该账户已属于激活状态&nbsp;<a href='/user/login?email=" + email + "'>立即登录</a>";
		else if (user.getStatus() == 0 && user.getSessionStr().equalsIgnoreCase(getPara(UserConstants.ACTIVATE_CODE))) {
			activate_msg = user.setStatus(1).setActivateTime(new Date()).update() ? "<a href='/user/login?email=" + email + "'>激活成功,立即登录吧</a>" : "";
		} else if (user.getStatus() == 0 && !user.getSessionStr().equalsIgnoreCase(getPara(UserConstants.ACTIVATE_CODE)))
			activate_msg = "激活失败,请不要随意更改您的激活链接";
		setAttr(UserConstants.ACTIVATE_MSG, activate_msg).renderJsp("activate.jsp");
	}

	@Clear
	public void checkEmail() {
		renderText(userService.checkEmail(getPara("email")) ? "true" : "false");
	}

	@Clear
	public void waitActivate() {
		setAttr("email", getPara("email")).renderJsp("waitActivate.jsp");
	}

	/*
		退出
	 */
	public void exit() {
		removeSessionAttr(UserConstants.LOGIN_USER).redirect("/");
	}

	public void my() {
		setAttr(Constants.TITLE, "个人信息").renderJsp("myinfo.jsp");
	}

	/*
		上传头像 ==
	 */
	public void uploadPic() {
		//第二个参数为a，则保存到upload/a文件夹下，自动创建文件夹
		user = getSessionAttr(UserConstants.LOGIN_USER);
		UploadFile file = getFile(getPara("picSummary"));
		redirect("/user/my");
	}

	public void update() {
		user = getModel(User.class);
		user.update();
		setSessionAttr(UserConstants.LOGIN_USER, user.findById(user.getId())).redirect("/user/my");
	}

	public void updateAjax() {
		// 设置session user
		user = getModel(User.class);
		setAttr(UserConstants.AJAX_ERR_MSG, user.update()).setSessionAttr(UserConstants.LOGIN_USER, user.findById(user.getId())).renderJson();
	}

	public String getUrl() {
		String uri = getRequest().getRequestURI();
		StringBuffer url = getRequest().getRequestURL();
		return url.substring(0, url.indexOf(uri));
	}
}

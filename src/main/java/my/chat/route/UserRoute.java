package my.chat.route;

import com.jfinal.config.Routes;
import my.chat.controller.UserController;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class UserRoute extends Routes {

	public void config() {
		setBaseViewPath("/WEB-INF/view");
		add("/user", UserController.class);
	}
}

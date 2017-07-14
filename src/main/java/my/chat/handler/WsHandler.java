package my.chat.handler;

import com.jfinal.handler.Handler;
import com.jfinal.kit.StrKit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class WsHandler extends Handler {

	private Pattern filterUrlRegxPattern;

	public WsHandler(String filterUrlRegx) {
		if (StrKit.isBlank(filterUrlRegx))
			throw new IllegalArgumentException("The para filterUrlRegx can not be blank.");
		filterUrlRegxPattern = Pattern.compile(filterUrlRegx);
	}


	@Override
	public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
		if (filterUrlRegxPattern.matcher(target).find())
			return;
		else
			next.handle(target, request, response, isHandled);
	}
}

package my.chat.controller;

import com.jfinal.core.Controller;
import my.chat.common.Constants;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class APIController extends Controller {

	private URL url = null;

	private String line = null;

	private HttpURLConnection connection = null;

	private final String MOB_KEY = "1f5ea010d1ff0";

	private final String TULING_KEY = "33d9d03c00384cbea267a38992f5a276";

	public void robot() {
		setAttr(Constants.TITLE, "robot").renderJsp("robot.jsp");
	}

	public void tuling() throws IOException {
		String question = getPara("question");
		String url = "http://www.tuling123.com/openapi/api?key=" + TULING_KEY + "&info=" + question;
		renderJson(getJson(url));
	}

	public void todayOnHistory() throws IOException {
		if (getRequest().getMethod().equalsIgnoreCase("GET")) {
			setAttr(Constants.TITLE, "历史上的今天").renderJsp("todayOnHistory.jsp");
		} else {
			String url = "http://apicloud.mob.com/appstore/history/query?key=" + MOB_KEY + "&day=" + new SimpleDateFormat("MMdd").format(new Date());
			renderJson(getJson(url));
		}
	}

	public void weather() throws IOException {
		if (getRequest().getMethod().equalsIgnoreCase("GET")) {
			setAttr(Constants.TITLE, "weather").renderJsp("weather.jsp");
		} else {
			String url = "http://www.sojson.com/open/api/weather/json.shtml?city=" + getPara("city");
			renderJson(getJson(url));
		}
	}

	/*
		待用 -- 没获取到..
	 */
	public void getWeather() throws IOException {
		String url = "apicloud.mob.com/v1/weather/query?key=" + MOB_KEY + "&city=深圳";
		renderJson(getJson(url));
	}

	/*
		获取手机号码信息
	 */
	public void mobile() throws IOException {
		if (getRequest().getMethod().equalsIgnoreCase("GET")) {
			setAttr(Constants.TITLE, "phone").renderJsp("phone.jsp");
		} else {
			String url = "http://apicloud.mob.com/v1/mobile/address/query?key=" + MOB_KEY + "&phone=" + getPara("phone");
			renderJson(getJson(url));
		}
	}

	public void luckyMobile() throws IOException {
		String url = "http://apicloud.mob.com/appstore/lucky/mobile/query?key=" + MOB_KEY + "&mobile=" + getPara("phone");
		renderJson(getJson(url));
	}

	public void dream() throws IOException {
		if (getRequest().getMethod().equalsIgnoreCase("GET")) {
			setAttr(Constants.TITLE, "周公解梦").renderJsp("dream.jsp");
		} else {
			String url = "http://apicloud.mob.com/appstore/dream/search?key=" + MOB_KEY + "&name=" + getPara("name");
			renderJson(getJson(url));
		}
	}

	public String getJson(String url) throws IOException {
		this.url = new URL(url);
		connection = (HttpURLConnection) this.url.openConnection();
		connection.connect();
		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		StringBuffer sb = new StringBuffer();
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		}
		reader.close();
		connection.disconnect();
		return sb.toString();
	}
}

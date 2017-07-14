package my.chat.config;

import com.alibaba.druid.filter.logging.Slf4jLogFilter;
import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.*;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.template.Engine;
import com.jfplugin.mail.MailPlugin;
import my.chat.Interceptor.LoginInterceptor;
import my.chat.controller.IndexController;
import my.chat.handler.WsHandler;
import my.chat.model._MappingKit;
import my.chat.route.APIRoute;
import my.chat.route.MusicRoute;
import my.chat.route.UserRoute;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class Config extends JFinalConfig {

	/**
	 * 配置常量
	 */
	public void configConstant(Constants constants) {
		// 加载少量必要配置，随后可用PropKit.get(...)获取值
		PropKit.use("config.txt");
		constants.setDevMode(PropKit.getBoolean("devMode", false));
		constants.setError404View("/WEB-INF/view/err/404.html");
		constants.setEncoding("UTF-8");
	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes routes) {
		routes.add("/", IndexController.class);
		routes.add(new UserRoute());
		routes.add(new MusicRoute());
		routes.add(new APIRoute());
	}

	public void configEngine(Engine engine) {

	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins plugins) {
		// 配置C3p0数据库连接池插件
		DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"), PropKit.get("driverClass"));
		plugins.add(druidPlugin);
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
		_MappingKit.mapping(arp); // 所有映射在 MappingKit 中自动化搞定
		plugins.add(arp);
		plugins.add(new MailPlugin(PropKit.use("mail.properties").getProperties())); // 配置邮箱插件
	}

	public static DruidPlugin createDruidPlugin() {
		DruidPlugin dp = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"), PropKit.get("driverClass"));
		dp.addFilter(new StatFilter()).addFilter(new Slf4jLogFilter());
		WallFilter wall = new WallFilter();
		wall.setDbType("mysql");
		dp.addFilter(wall);
		return dp;
	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors interceptors) {
		interceptors.add(new LoginInterceptor());
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers handlers) {
		handlers.add(new WsHandler("^/chat"));
	}

}

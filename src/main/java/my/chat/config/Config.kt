package my.chat.config

import com.alibaba.druid.filter.logging.Slf4jLogFilter
import com.alibaba.druid.filter.stat.StatFilter
import com.alibaba.druid.wall.WallFilter
import com.jfinal.config.*
import com.jfinal.kit.PropKit
import com.jfinal.plugin.activerecord.ActiveRecordPlugin
import com.jfinal.plugin.druid.DruidPlugin
import com.jfinal.template.Engine
import com.jfplugin.mail.MailPlugin
import my.chat.Interceptor.LoginInterceptor
import my.chat.controller.IndexController
import my.chat.handler.WsHandler
import my.chat.model._MappingKit
import my.chat.route.APIRoute
import my.chat.route.ArticleRoute
import my.chat.route.MusicRoute
import my.chat.route.UserRoute

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
class Config : JFinalConfig() {

    /**
     * 配置常量
     */
    override fun configConstant(constants: Constants) {
        // 加载少量必要配置，随后可用PropKit.get(...)获取值
        PropKit.use("config.txt")
        constants.devMode = PropKit.getBoolean("devMode", false)!!
        constants.setError404View("/WEB-INF/view/err/404.html")
        constants.setError500View("/WEB-INF/view/err/500.html")
        constants.encoding = "UTF-8"
    }

    /**
     * 配置路由
     */
    override fun configRoute(routes: Routes) {
        routes.add("/", IndexController::class.java)
        routes.add(UserRoute())
        routes.add(MusicRoute())
        routes.add(APIRoute())
        routes.add(ArticleRoute())
    }

    override fun configEngine(engine: Engine) {

    }

    /**
     * 配置插件
     */
    override fun configPlugin(plugins: Plugins) {
        // 配置C3p0数据库连接池插件
        val druidPlugin = DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"), PropKit.get("driverClass"))
        plugins.add(druidPlugin)
        // 配置ActiveRecord插件
        val arp = ActiveRecordPlugin(druidPlugin)
        _MappingKit.mapping(arp) // 所有映射在 MappingKit 中自动化搞定
        plugins.add(arp)
        plugins.add(MailPlugin(PropKit.use("mail.properties").properties)) // 配置邮箱插件
    }

    /**
     * 配置全局拦截器
     */
    override fun configInterceptor(interceptors: Interceptors) {
        interceptors.add(LoginInterceptor())
    }

    /**
     * 配置处理器
     */
    override fun configHandler(handlers: Handlers) {
        handlers.add(WsHandler("^/chat"))
    }

    companion object {

        fun createDruidPlugin(): DruidPlugin {
            val dp = DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password"), PropKit.get("driverClass"))
            dp.addFilter(StatFilter()).addFilter(Slf4jLogFilter())
            val wall = WallFilter()
            wall.dbType = "mysql"
            dp.addFilter(wall)
            return dp
        }
    }

}

package my.chat.controller

import java.io.IOException
import java.util.concurrent.CopyOnWriteArraySet
import javax.websocket.*
import javax.websocket.server.ServerEndpoint

/**
 * Created by lyu on 2017/7/3.
 */
@ServerEndpoint("/chat")
class WebSocketController {

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private var session: Session? = null

    /**
     * 连接建立成功调用的方法

     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    fun onOpen(session: Session) {
        this.session = session
        webSocketSet.add(this)     //加入set中
        addOnlineCount()           //在线数加1
        println("有新连接加入！当前在线人数为" + onlineCount)
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    fun onClose() {
        webSocketSet.remove(this)  //从set中删除
        subOnlineCount()           //在线数减1
        println("有一连接关闭！当前在线人数为" + onlineCount)
    }

    /**
     * 收到客户端消息后调用的方法

     * @param message 客户端发送过来的消息
     */
    @OnMessage
    fun onMessage(message: String) {
        println("来自客户端的消息:" + message)
        //群发消息
        for (item in webSocketSet) {
            try {
                item.sendMessage(message)
            } catch (e: IOException) {
                e.printStackTrace()
                continue
            }

        }
    }

    /**
     * 发生错误时调用

     * @param session
     * *
     * @param error
     */
    @OnError
    fun onError(session: Session, error: Throwable) {
        println("发生错误")
        error.printStackTrace()
    }

    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。

     * @param message
     * *
     * @throws IOException
     */
    @Throws(IOException::class)
    fun sendMessage(message: String) {
        this.session!!.basicRemote.sendText(message)
        //this.session.getAsyncRemote().sendText(message);
    }

    companion object {

        //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的
        var onlineCount = 0
            private set

        //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
        private val webSocketSet = CopyOnWriteArraySet<WebSocketController>()

        @Synchronized fun addOnlineCount() {
            WebSocketController.onlineCount++
        }

        @Synchronized fun subOnlineCount() {
            WebSocketController.onlineCount--
        }
    }
}

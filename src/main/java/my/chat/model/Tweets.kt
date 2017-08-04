package my.chat.model

import my.chat.model.base.BaseTweets

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
class Tweets : BaseTweets<Tweets>() {
    companion object {
        val dao = Tweets().dao()
    }
}


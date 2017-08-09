package my.chat.model

import my.chat.model.base.BaseTweetsComment

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
class TweetsComment : BaseTweetsComment<TweetsComment>() {
    companion object {
        val dao = TweetsComment().dao()
    }
}


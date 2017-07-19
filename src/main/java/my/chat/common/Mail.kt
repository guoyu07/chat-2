package my.chat.common

/**
 * Created by lyu on 2017/6/24.
 */
object Mail {

    val MAIL_TITLE = "chat:激活邮件,欢迎注册chat"

    fun getMailText(to: String, activeCode: String, url: String): String {
        val sb = StringBuffer()
        sb.append(
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 600px; border: 1px solid #ddd; border-radius: 3px; color: #555; font-family: 'Helvetica Neue Regular',Helvetica,Arial,Tahoma,'Microsoft YaHei','San Francisco','微软雅黑','Hiragino Sans GB',STHeitiSC-Light; font-size: 12px; height: auto; margin: auto; overflow: hidden; text-align: left; word-break: break-all; word-wrap: break-word;\">")
        sb.append("<tbody style=\"margin: 0; padding: 0;\">")
        sb.append("<tr style=\"background-color: #393D49; height: 60px; margin: 0; padding: 0;\">")
        sb.append("<td style=\"margin: 0; padding: 0;\">")
        sb.append("<div style=\"color: #5EB576; margin: 0; margin-left: 30px; padding: 0;\">")
        sb.append(
                "<a style=\"font-size: 14px; margin: 0; padding: 0; color: #5EB576; text-decoration: none;\" href=\"$url\" target=\"_blank\">chat - 致力于chat</a>")
        sb.append("</div>")
        sb.append("</td>")
        sb.append("</tr>")
        sb.append("<tr style=\"margin: 0; padding: 0;\">")
        sb.append("<td style=\"margin: 0; padding: 30px;\">")
        sb.append(
                "<p style=\"line-height: 20px; margin: 0; margin-bottom: 10px; padding: 0;\"> 伟大的程序员，<em style=\"font-weight: 700;\">"
                        + to
                        + "</em>： </p> <p style=\"line-height: 2; margin: 0; margin-bottom: 10px; padding: 0;\"> 欢迎你加入<em>chat</em>。<br/>请点击下面的按钮激活邮箱，邮件有效时间24小时。 </p>")
        sb.append("<div style=\"\"> <a href=\"" + url + "/user/activate?email=" + to + "&activateCode=" + activeCode
                + "\" style=\"background-color: #009E94; color: #fff; display: inline-block; height: 32px; line-height: 32px; margin: 0 15px 0 0; padding: 0 15px; text-decoration: none;\" target=\"_blank\">立即激活邮箱</a> </div>")
        sb.append(
                "<p style=\"line-height: 20px; margin-top: 20px; padding: 10px; background-color: #f2f2f2; font-size: 12px;\"> 如果该邮件不是由你本人操作，请勿进行激活！否则你的邮箱将会被他人绑定。 </p>")
        sb.append("</td>")
        sb.append("</tr>")
        sb.append(
                "<tr style=\"background-color: #fafafa; color: #999; height: 35px; margin: 0; padding: 0; text-align: center;\">")
        sb.append("<td style=\"margin: 0; padding: 0;\">系统邮件，请勿直接回复。</td>")
        sb.append("</tr>")
        sb.append("</tbody>")
        sb.append("</table>")
        return sb.toString()
    }


}

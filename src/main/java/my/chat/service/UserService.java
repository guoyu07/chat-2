package my.chat.service;

import com.xiaoleilu.hutool.crypto.SecureUtil;
import com.xiaoleilu.hutool.util.ObjectUtil;
import com.xiaoleilu.hutool.util.ReUtil;
import my.chat.model.User;

import java.util.Date;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class UserService {

    private static final User userDao = new User().dao();

    public boolean register(User user) {
        user.setStatus(0);
        user.setRegisterTime(new Date());
        user.setPassword(SecureUtil.md5(user.getPassword()));
        try {
            user.save();
            return user.getId() != null;
        } catch (Exception e) {
            return false;
        }
    }

    public User login(User user, String username) {
        user.setPassword(SecureUtil.md5(user.getPassword()));
        StringBuffer sb = new StringBuffer();
        sb.append("select * from user where password = ? and");
        if (ReUtil.isMatch("((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}", username))
            sb.append(" phone = ?");
        else if (ReUtil.isMatch("[A-Za-z0-9.\\u4e00-\\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+", username))
            sb.append(" email = ?");
        else
            sb.append(" username = ?");
        return userDao.findFirst(sb.toString(), user.getPassword(), username);
    }


    public User activate(String email) {
        User user = userDao.findFirst("select id,status,sessionStr from user where email = ?", email);
        return ObjectUtil.isNull(user) ? null : user;
    }

    public boolean checkEmail(String email) {
        System.out.println(userDao.find("select id from user where email = ?", email).size());
        return userDao.find("select id from user where email = ?", email).size() > 0;
    }
}

package my.chat.controller;

import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;

import java.util.HashMap;
import java.util.Map;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class FileUploadController extends Controller {

	/**
	 * ueditor上传
	 */
	public void upload() {
		if ("config".equals(getPara("action"))) {
			render("/ueditor/jsp/config.json");
			return;
		}
		UploadFile file = getFile("upfile"); // 获取文件
		String fileName = file.getFileName();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", "SUCCESS");
		map.put("url", fileName);// 其中jfinal_demo 是项目名
		map.put("title", fileName);
		map.put("original", file.getOriginalFileName());
		map.put("type",""); // 这里根据实际扩展名去写
		map.put("size", file.getFile().length());
		renderJson(map);
	}
}

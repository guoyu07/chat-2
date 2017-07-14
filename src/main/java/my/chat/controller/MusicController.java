package my.chat.controller;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.xiaoleilu.hutool.util.ObjectUtil;
import my.chat.common.Constants;
import my.chat.common.MusicConstants;
import my.chat.model.Songs;
import my.chat.service.MusicService;

import java.io.UnsupportedEncodingException;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class MusicController extends Controller {

	static MusicService musicService = new MusicService();

	@Clear
	public void listSongs() throws UnsupportedEncodingException {
		String pageNumber = getPara("p");
		String queryName = getPara("q");
		String songs = getPara("songs");
		String album = getPara("album");
		String singers = getPara("singers");
		if (ObjectUtil.isNull(pageNumber) && ObjectUtil.isNull(queryName) && "GET".equalsIgnoreCase(getRequest().getMethod()))
			singers = album = songs = "";
		Page<Songs> songsPage = musicService.listSongs(pageNumber, 15, queryName, songs, album, singers);
		setAttr(MusicConstants.SONGS_PAGE, songsPage).setAttr(MusicConstants.QUERY_NAME, queryName)
				.setAttr("songs", songs).setAttr("album", album).setAttr("singers", singers)
				.setAttr(Constants.TITLE, "music").renderJsp("songs.jsp");
	}
}

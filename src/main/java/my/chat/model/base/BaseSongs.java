package my.chat.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseSongs<M extends BaseSongs<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("id", id);
		return (M)this;
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public M setAlbumid(java.lang.Integer albumid) {
		set("albumid", albumid);
		return (M)this;
	}

	public java.lang.Integer getAlbumid() {
		return get("albumid");
	}

	public M setName(java.lang.String name) {
		set("name", name);
		return (M)this;
	}

	public java.lang.String getName() {
		return get("name");
	}

	public M setUrl(java.lang.String url) {
		set("url", url);
		return (M)this;
	}

	public java.lang.String getUrl() {
		return get("url");
	}

	public M setMvurl(java.lang.String mvurl) {
		set("mvurl", mvurl);
		return (M)this;
	}

	public java.lang.String getMvurl() {
		return get("mvurl");
	}

	public M setAlias(java.lang.String alias) {
		set("alias", alias);
		return (M)this;
	}

	public java.lang.String getAlias() {
		return get("alias");
	}

	public M setDuration(java.lang.Integer duration) {
		set("duration", duration);
		return (M)this;
	}

	public java.lang.Integer getDuration() {
		return get("duration");
	}

}

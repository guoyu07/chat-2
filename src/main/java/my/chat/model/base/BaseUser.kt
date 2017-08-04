package my.chat.model.base

import com.jfinal.plugin.activerecord.IBean
import com.jfinal.plugin.activerecord.Model

/**
 * Generated by JFinal, do not modify this file.
 */
abstract class BaseUser<M : BaseUser<M>> : Model<M>(), IBean {

    fun setId(id: Int?): M {
        set("id", id)
        return this as M
    }

    val id: Int?
        get() = get<Int>("id")

    fun setUsername(username: String?): M {
        set("username", username)
        return this as M
    }

    val username: String?
        get() = get("username")

    fun setPassword(password: String): M {
        set("password", password)
        return this as M
    }

    val password: String?
        get() = get("password")

    fun setEmail(email: String?): M {
        set("email", email)
        return this as M
    }

    val email: String?
        get() = get("email")

    fun setPhone(phone: String?): M {
        set("phone", phone)
        return this as M
    }

    val phone: String?
        get() = get("phone")

    fun setIdCard(idCard: String?): M {
        set("idCard", idCard)
        return this as M
    }

    val idCard: String?
        get() = get("idCard")

    fun setNickname(nickname: String?): M {
        set("nickname", nickname)
        return this as M
    }

    val nickname: String?
        get() = get("nickname")

    fun setBorndate(borndate: java.util.Date): M {
        set("borndate", borndate)
        return this as M
    }

    val borndate: java.util.Date
        get() = get("borndate")

    fun setGender(gender: Int?): M {
        set("gender", gender)
        return this as M
    }

    val gender: Int?
        get() = get<Int>("gender")

    fun setStatus(status: Int?): M {
        set("status", status)
        return this as M
    }

    val status: Int?
        get() = get<Int>("status")

    fun setSessionStr(sessionStr: String?): M {
        set("sessionStr", sessionStr)
        return this as M
    }

    val sessionStr: String?
        get() = get("sessionStr")

    fun setCountry(country: String?): M {
        set("country", country)
        return this as M
    }

    val country: String?
        get() = get("country")

    fun setProvince(province: String?): M {
        set("province", province)
        return this as M
    }

    val province: String?
        get() = get("province")

    fun setCity(city: String?): M {
        set("city", city)
        return this as M
    }

    val city: String?
        get() = get("city")

    fun setDistrict(district: String?): M {
        set("district", district)
        return this as M
    }

    val district: String?
        get() = get("district")

    fun setAddressDetails(addressDetails: String?): M {
        set("addressDetails", addressDetails)
        return this as M
    }

    val addressDetails: String?
        get() = get("addressDetails")

    fun setPicSummary(picSummary: String?): M {
        set("picSummary", picSummary)
        return this as M
    }

    val picSummary: String?
        get() = get("picSummary")

    fun setHomePagePic(homePagePic: String?): M {
        set("homePagePic", homePagePic)
        return this as M
    }

    val homePagePic: String?
        get() = get("homePagePic")


    fun setDescription(description: String?): M {
        set("description", description)
        return this as M
    }

    val description: String?
        get() = get("description")

    fun setRegisterTime(registerTime: java.util.Date): M {
        set("registerTime", registerTime)
        return this as M
    }

    val registerTime: java.util.Date
        get() = get("registerTime")

    fun setActivateTime(activateTime: java.util.Date): M {
        set("activateTime", activateTime)
        return this as M
    }

    val activateTime: java.util.Date
        get() = get("activateTime")

    fun setLastLoginTime(lastLoginTime: java.util.Date): M {
        set("lastLoginTime", lastLoginTime)
        return this as M
    }

    val lastLoginTime: java.util.Date
        get() = get("lastLoginTime")

}

package my.chat.model

import my.chat.model.base.BaseSingers

/**
 * Generated by JFinal.
 */
class Singers : BaseSingers<Singers>() {
    companion object {
        val dao = Singers().dao()
    }
}

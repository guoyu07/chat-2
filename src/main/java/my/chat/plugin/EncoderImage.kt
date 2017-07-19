package my.chat.plugin

import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.MultiFormatWriter
import com.google.zxing.WriterException
import com.google.zxing.common.BitMatrix
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel
import java.io.File
import java.io.IOException
import java.util.*
import javax.servlet.http.HttpServletResponse

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
object EncoderImage {

    @Throws(WriterException::class, IOException::class)
    fun encoderQRCode(content: String): BitMatrix {
        val width = 430 // 二维码图片宽度
        val height = 430 // 二维码图片高度
        val format = "jpg"// 二维码的图片格式
        val hints = Hashtable<EncodeHintType, Any>()
        // 指定纠错等级,纠错级别（L 7%、M 15%、Q 25%、H 30%）
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H)
        // 内容所使用字符集编码
        hints.put(EncodeHintType.CHARACTER_SET, "utf-8")
        //      hints.put(EncodeHintType.MAX_SIZE, 350);//设置图片的最大值
        //      hints.put(EncodeHintType.MIN_SIZE, 100);//设置图片的最小值
        hints.put(EncodeHintType.MARGIN, 1)//设置二维码边的空度，非负数
        val bitMatrix = MultiFormatWriter().encode(content, //要编码的内容
                //编码类型，目前zxing支持：Aztec 2D,CODABAR 1D format,Code 39 1D,Code 93 1D ,Code 128 1D,
                //Data Matrix 2D , EAN-8 1D,EAN-13 1D,ITF (Interleaved Two of Five) 1D,
                //MaxiCode 2D barcode,PDF417,QR Code 2D,RSS 14,RSS EXPANDED,UPC-A 1D,UPC-E 1D,UPC/EAN extension,UPC_EAN_EXTENSION
                BarcodeFormat.QR_CODE,
                width, //条形码的宽度
                height, //条形码的高度
                hints)//生成条形码时的一些配置,此项可选
        // 生成二维码
        return bitMatrix
    }

    @Throws(WriterException::class, IOException::class)
    fun writeToStream(content: String, response: HttpServletResponse) {
        MatrixToImageWriter.writeToStream(encoderQRCode(content), "jpg", response.outputStream)
    }

    @Throws(WriterException::class, IOException::class)
    fun writeToFile(content: String, file: File) {
        MatrixToImageWriter.writeToFile(encoderQRCode(content), "jpg", file)
    }
}

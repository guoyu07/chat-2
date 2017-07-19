package my.chat.plugin

import com.google.zxing.common.BitMatrix
import java.awt.image.BufferedImage
import java.io.File
import java.io.IOException
import java.io.OutputStream
import javax.imageio.ImageIO

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
object MatrixToImageWriter {
    private val BLACK = 0xFF000000.toInt()//用于设置图案的颜色
    private val WHITE = 0xFFFFFFFF.toInt() //用于背景色

    fun toBufferedImage(matrix: BitMatrix): BufferedImage {
        val width = matrix.width
        val height = matrix.height
        val image = BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)
        for (x in 0..width - 1) {
            for (y in 0..height - 1) {
                image.setRGB(x, y, if (matrix.get(x, y)) BLACK else WHITE)
            }
        }
        return image
    }

    @Throws(IOException::class)
    fun writeToFile(matrix: BitMatrix, format: String, file: File) {
        var image = toBufferedImage(matrix)
        //设置logo图标
        val logoConfig = LogoConfig()
        image = logoConfig.LogoMatrix(image)
        if (!ImageIO.write(image, format, file)) {
            throw IOException("Could not write an image of format $format to $file")
        } else {
            println("图片生成成功！")
        }
    }

    @Throws(IOException::class)
    fun writeToStream(matrix: BitMatrix, format: String, stream: OutputStream) {
        var image = toBufferedImage(matrix)
        //设置logo图标
        val logoConfig = LogoConfig()
        image = logoConfig.LogoMatrix(image)
        if (!ImageIO.write(image, format, stream)) {
            throw IOException("Could not write an image of format " + format)
        }
    }
}

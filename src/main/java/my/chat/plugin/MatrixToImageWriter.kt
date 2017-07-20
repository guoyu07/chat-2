package my.chat.plugin

import com.google.zxing.common.BitMatrix
import java.awt.BasicStroke
import java.awt.Color
import java.awt.geom.RoundRectangle2D
import java.awt.image.BufferedImage
import java.io.File
import java.io.IOException
import java.io.OutputStream
import javax.imageio.ImageIO
import javax.servlet.http.HttpSession

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
    fun writeToFile(matrix: BitMatrix, format: String, file: File, session: HttpSession) {
        var image = toBufferedImage(matrix)
        //设置logo图标
        image = LogoMatrix(image, session)
        if (!ImageIO.write(image, format, file)) {
            throw IOException("Could not write an image of format $format to $file")
        } else {
            println("二维码生成成功！")
        }
    }

    @Throws(IOException::class)
    fun writeToStream(matrix: BitMatrix, format: String, stream: OutputStream, session: HttpSession) {
        var image = toBufferedImage(matrix)
        //设置logo图标
        image = LogoMatrix(image, session)
        if (!ImageIO.write(image, format, stream)) {
            throw IOException("Could not write an image of format " + format)
        }
    }

    /**
     * 设置 logo

     * @param matrixImage 源二维码图片
     * *
     * @return 返回带有logo的二维码图片
     * *
     * @throws IOException
     * *
     * @author Administrator sangwenhao
     */
    @Throws(IOException::class)
    fun LogoMatrix(matrixImage: BufferedImage, session: HttpSession): BufferedImage {
        // 读取二维码图片，并构建绘图对象
        val g2 = matrixImage.createGraphics()
        val matrixWidth = matrixImage.width
        val matrixHeigh = matrixImage.height
        //读取Logo图片
        val logo = ImageIO.read(File(session.servletContext.getRealPath("/") + "images/emoji.png"))
        //开始绘制图片
        g2.drawImage(logo, matrixWidth / 5 * 2, matrixHeigh / 5 * 2, matrixWidth / 5, matrixHeigh / 5, null)//绘制
        val stroke = BasicStroke(5f, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND)
        g2.stroke = stroke// 设置笔画对象
        //指定弧度的圆角矩形
        val round = RoundRectangle2D.Float((matrixWidth / 5 * 2).toFloat(), (matrixHeigh / 5 * 2).toFloat(), (matrixWidth / 5).toFloat(), (matrixHeigh / 5).toFloat(), 20f, 20f)
        g2.color = Color.white
        g2.draw(round)// 绘制圆弧矩形
        //设置logo 有一道灰色边框
        val stroke2 = BasicStroke(1f, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND)
        g2.stroke = stroke2// 设置笔画对象
        val round2 = RoundRectangle2D.Float((matrixWidth / 5 * 2 + 2).toFloat(), (matrixHeigh / 5 * 2 + 2).toFloat(), (matrixWidth / 5 - 4).toFloat(), (matrixHeigh / 5 - 4).toFloat(), 20f, 20f)
        g2.color = Color(128, 128, 128)
        g2.draw(round2)// 绘制圆弧矩形
        g2.dispose()
        matrixImage.flush()
        return matrixImage
    }
}

package my.chat.plugin;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author lyu lyusantu@gmail.com
 * @version V1.0
 * @Title: ${file_name}
 * @Description: ${todo}
 * @date ${date} ${time}
 */
public class ZXingCode {
	private static final int QRCOLOR = 0xFF000000;   //默认是黑色
	private static final int BGWHITE = 0xFFFFFFFF;   //背景颜色

	/**
	 * 生成带logo的二维码图片
	 */
	public static BufferedImage getLogoQRCode(String url, String logoPath, String productName) {
		String content = url;
		try {
			ZXingCode zp = new ZXingCode();
			BufferedImage bim = zp.getQR_CODEBufferedImage(content, BarcodeFormat.QR_CODE, 400, 400, zp.getDecodeHintType());
			return zp.addLogo_QRCode(bim, new File(logoPath), productName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 给二维码图片添加Logo
	 */
	public BufferedImage addLogo_QRCode(BufferedImage bim, File logoPic, String productName) {
		try {
			/**
			 * 读取二维码图片，并构建绘图对象
			 */
			BufferedImage image = bim;
			Graphics2D g = image.createGraphics();

			/**
			 * 读取Logo图片
			 */
			BufferedImage logo = ImageIO.read(logoPic);
			/**
			 * 设置logo的大小,本人设置为二维码图片的20%,因为过大会盖掉二维码
			 */
			int widthLogo = logo.getWidth(null) > image.getWidth() * 3 / 10 ? (image.getWidth() * 3 / 10) : logo.getWidth(null),
					heightLogo = logo.getHeight(null) > image.getHeight() * 3 / 10 ? (image.getHeight() * 3 / 10) : logo.getWidth(null);

			/**
			 * logo放在中心
			 */
			int x = (image.getWidth() - widthLogo) / 2;
			int y = (image.getHeight() - heightLogo) / 2;
			/**
			 * logo放在右下角
			 *  int x = (image.getWidth() - widthLogo);
			 *  int y = (image.getHeight() - heightLogo);
			 */
			//开始绘制图片
			g.drawImage(logo, x, y, widthLogo, heightLogo, null);
			g.dispose();
			//加名称
			if (productName != null && !productName.equals("")) {
				//新的图片，把带logo的二维码下面加上文字
				BufferedImage outImage = new BufferedImage(400, 445, BufferedImage.TYPE_4BYTE_ABGR);
				Graphics2D outg = outImage.createGraphics();
				//画二维码到新的面板
				outg.drawImage(image, 0, 0, image.getWidth(), image.getHeight(), null);
				//画文字到新的面板
				outg.setColor(Color.BLACK);
				outg.setFont(new Font("宋体", Font.BOLD, 30)); //字体、字型、字号
				int strWidth = outg.getFontMetrics().stringWidth(productName);
				if (strWidth > 399) {
//                  //长度过长就截取前面部分
//                  outg.drawString(productName, 0, image.getHeight() + (outImage.getHeight() - image.getHeight())/2 + 5 ); //画文字
					//长度过长就换行
					String productName1 = productName.substring(0, productName.length() / 2);
					String productName2 = productName.substring(productName.length() / 2, productName.length());
					int strWidth1 = outg.getFontMetrics().stringWidth(productName1);
					int strWidth2 = outg.getFontMetrics().stringWidth(productName2);
					outg.drawString(productName1, 200 - strWidth1 / 2, image.getHeight() + (outImage.getHeight() - image.getHeight()) / 2 + 12);
					BufferedImage outImage2 = new BufferedImage(400, 485, BufferedImage.TYPE_4BYTE_ABGR);
					Graphics2D outg2 = outImage2.createGraphics();
					outg2.drawImage(outImage, 0, 0, outImage.getWidth(), outImage.getHeight(), null);
					outg2.setColor(Color.BLACK);
					outg2.setFont(new Font("宋体", Font.BOLD, 30)); //字体、字型、字号
					outg2.drawString(productName2, 200 - strWidth2 / 2, outImage.getHeight() + (outImage2.getHeight() - outImage.getHeight()) / 2 + 5);
					outg2.dispose();
					outImage2.flush();
					outImage = outImage2;
				} else {
					outg.drawString(productName, 200 - strWidth / 2, image.getHeight() + (outImage.getHeight() - image.getHeight()) / 2 + 12); //画文字
				}
				outg.dispose();
				outImage.flush();
				image = outImage;
			}
			logo.flush();
			image.flush();
			return image;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void writeToFile(String url, String content, String logoPath, File file, HttpSession session) throws IOException {
		BufferedImage bf = getLogoQRCode(url, logoPath, content);
		if (!ImageIO.write(bf, "png", file)) {
			throw new IOException("Could not write an image of format $format to $file");
		} else {
			System.out.println("下载二维码成功");
		}
	}

	public static void writeToStream(String url, String content, String logoPath, HttpServletResponse response, HttpSession session) throws IOException {
		BufferedImage bf = getLogoQRCode(url, logoPath, content);
		if (!ImageIO.write(bf, "png", response.getOutputStream())) {
			throw new IOException("Could not write an image of format $format to $file");
		} else {
			System.out.println("生成二维码成功");
		}
	}

	/**
	 * 生成二维码bufferedImage图片
	 *
	 * @param content       编码内容
	 * @param barcodeFormat 编码类型
	 * @param width         图片宽度
	 * @param height        图片高度
	 * @param hints         设置参数
	 * @return
	 */
	public BufferedImage getQR_CODEBufferedImage(String content, BarcodeFormat barcodeFormat, int width, int height, Map<EncodeHintType, ?> hints) {
		MultiFormatWriter multiFormatWriter = null;
		BitMatrix bm = null;
		BufferedImage image = null;
		try {
			multiFormatWriter = new MultiFormatWriter();
			// 参数顺序分别为：编码内容，编码类型，生成图片宽度，生成图片高度，设置参数
			bm = multiFormatWriter.encode(content, barcodeFormat, width, height, hints);
			int w = bm.getWidth();
			int h = bm.getHeight();
			image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);

			// 开始利用二维码数据创建Bitmap图片，分别设为黑（0xFFFFFFFF）白（0xFF000000）两色
			for (int x = 0; x < w; x++) {
				for (int y = 0; y < h; y++) {
					image.setRGB(x, y, bm.get(x, y) ? QRCOLOR : BGWHITE);
				}
			}
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return image;
	}

	/**
	 * 设置二维码的格式参数
	 *
	 * @return
	 */
	public Map<EncodeHintType, Object> getDecodeHintType() {
		// 用于设置QR二维码参数
		Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		// 设置QR二维码的纠错级别（H为最高级别）具体级别信息
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
		// 设置编码方式
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		hints.put(EncodeHintType.MARGIN, 0);
		hints.put(EncodeHintType.MAX_SIZE, 350);
		hints.put(EncodeHintType.MIN_SIZE, 100);

		return hints;
	}
}

class LogoConfig {
	// logo默认边框颜色
	public static final Color DEFAULT_BORDERCOLOR = Color.WHITE;
	// logo默认边框宽度
	public static final int DEFAULT_BORDER = 2;
	// logo大小默认为照片的1/5
	public static final int DEFAULT_LOGOPART = 5;

	private final int border = DEFAULT_BORDER;
	private final Color borderColor;
	private final int logoPart;


	public LogoConfig() {
		this(DEFAULT_BORDERCOLOR, DEFAULT_LOGOPART);
	}

	public LogoConfig(Color borderColor, int logoPart) {
		this.borderColor = borderColor;
		this.logoPart = logoPart;
	}

	public Color getBorderColor() {
		return borderColor;
	}

	public int getBorder() {
		return border;
	}

	public int getLogoPart() {
		return logoPart;
	}
}
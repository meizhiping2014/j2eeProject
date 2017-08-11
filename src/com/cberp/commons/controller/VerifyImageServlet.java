package com.cberp.commons.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Locale;
import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.plugins.jpeg.JPEGImageWriteParam;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cberp.commons.utils.CookieUtils;
import com.cberp.commons.utils.VerifyImageUtils;
import com.cberp.commons.utils.constants.CookieConstants;
import com.octo.captcha.service.image.ImageCaptchaService;

/**
 * @描叙：验证码Servlet
 * @版本：1.0
 */
public class VerifyImageServlet extends HttpServlet {

	private static final long serialVersionUID = -3015454800957108107L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. set verify code cookie id
		String visitorId = CookieUtils.getCookieValue(request, CookieConstants.KEY_VISITOR_ID);

		ImageCaptchaService verifyImageService = VerifyImageUtils.getImageCaptchaService();

		BufferedImage verifyImage = verifyImageService.getImageChallengeForID(visitorId, request.getLocale());

		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");

		writeImage(verifyImage, response.getOutputStream(), request.getLocale());

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public final static void writeImage(BufferedImage in, OutputStream out, Locale locale) throws IOException {
		ImageWriter writer = (ImageWriter) ImageIO.getImageWritersByFormatName("jpg").next();
		ImageOutputStream ios = null;
		ios = ImageIO.createImageOutputStream(out);
		writer.setOutput(ios);
		ImageWriteParam param = new JPEGImageWriteParam(locale);
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(1.0f);// 0-1
		writer.write(null, new IIOImage(in, null, null), param);
		ios.flush();
		writer.dispose();
		ios.close();
	}

}

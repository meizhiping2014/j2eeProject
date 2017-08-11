package com.cberp.commons.utils;

import java.awt.Color;
import java.awt.Font;

import com.cberp.commons.utils.constants.VerifyImageConstants;
import com.octo.captcha.component.image.backgroundgenerator.BackgroundGenerator;
import com.octo.captcha.component.image.backgroundgenerator.GradientBackgroundGenerator;
import com.octo.captcha.component.image.color.RandomRangeColorGenerator;
import com.octo.captcha.component.image.fontgenerator.FontGenerator;
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator;
import com.octo.captcha.component.image.textpaster.RandomTextPaster;
import com.octo.captcha.component.image.textpaster.TextPaster;
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage;
import com.octo.captcha.component.image.wordtoimage.WordToImage;
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator;
import com.octo.captcha.component.word.wordgenerator.WordGenerator;
import com.octo.captcha.engine.image.ListImageCaptchaEngine;
import com.octo.captcha.image.gimpy.GimpyFactory;

/**
 * @描叙：Verify Image Engine
 * @版本：1.0
 */
public class VerifyImageEngine extends ListImageCaptchaEngine {

	@Override
	protected void buildInitialFactories() {
		// Random Words configure
		WordGenerator wgen = new RandomWordGenerator(VerifyImageConstants.randomWords);
		RandomRangeColorGenerator cgen = new RandomRangeColorGenerator(new int[] { 0, 150 }, new int[] { 0, 150 }, new int[] { 0, 150 });

		// Verify Code length
		TextPaster textPaster = new RandomTextPaster(VerifyImageConstants.minWordsLength, VerifyImageConstants.maxWordsLength, cgen, true);

		// Image Size
		BackgroundGenerator backgroundGenerator = new GradientBackgroundGenerator(VerifyImageConstants.imageWidth, VerifyImageConstants.imageHight, new Color(204, 229, 245), new Color(204, 229, 245));

		// Font style
		Font[] fontsList = new Font[] { new Font("Arial", Font.BOLD, VerifyImageConstants.maxFontSize), new Font("Tahoma", Font.BOLD, VerifyImageConstants.maxFontSize), new Font("Verdana", Font.BOLD, VerifyImageConstants.maxFontSize), };

		// Font Size
		FontGenerator fontGenerator = new RandomFontGenerator(VerifyImageConstants.minFontSize, VerifyImageConstants.maxFontSize, fontsList);

		WordToImage wordToImage = new ComposedWordToImage(fontGenerator, backgroundGenerator, textPaster);

		this.addFactory(new GimpyFactory(wgen, wordToImage));
	}

}

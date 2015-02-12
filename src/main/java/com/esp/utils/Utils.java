/**
 * 
 */
package com.esp.utils;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * @author Administrator
 *
 */
public class Utils {

	public static String print(Object obj) {
		return ToStringBuilder.reflectionToString(obj, ToStringStyle.DEFAULT_STYLE);
	}
}

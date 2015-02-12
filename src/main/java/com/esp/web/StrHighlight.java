/**
 * 
 */
package com.esp.web;

/**
 * @author Administrator
 *
 */
public class StrHighlight
{
	public static String highlight(String str, String kw, String prefix, String sufix)
	{
		String rst = "";
		String left_str = str;
		int ind = left_str.toLowerCase().indexOf(kw.toLowerCase());
		while (ind >= 0) {
			rst += left_str.substring(0, ind);
			rst += prefix + left_str.substring(ind, ind+kw.length()) + sufix;
			
			left_str = left_str.substring(ind + kw.length(), left_str.length());
			ind = left_str.toLowerCase().indexOf(kw.toLowerCase());
		}
		rst += left_str;
		
		return rst;
	}
	
	public static void main(String[] args)
	{
		String word = "The U.S. Senate has passed a proposal that cuts $23 billion in nutrition programs " +
				"and subsidies to American farmers. It's part of a huge, " +
				"five-year bill that includes about $500 billion in farm and food aid programs. " +
				"But critics say the bill merely replaces one subsidy with another - " +
				"one that may cause more problems in global markets. VOA's Steve Baragona has more.";
		
		System.out.println(StrHighlight.highlight(word, "th", "<font color='orange'>", "</font color>"));
	}
}

package util;

public class CalUtil {

	public static String two(String msg){
		return msg.trim().length()<2?"0"+msg.trim():msg.trim();
	}
}

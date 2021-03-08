package webShop.Util;
import java.util.*;

public class MyCalendar {
	Calendar curr;
	Calendar prev;
	Calendar next;
	public MyCalendar() {
		prev = Calendar.getInstance();
		curr = Calendar.getInstance();
		next = Calendar.getInstance();
	}
	
	public void setCalendar(String date) { //�޷� ����, 1���� 0����
		int year = Integer.parseInt(date.substring(0, 4));
		int month = Integer.parseInt(date.substring(5, 7));
		int day = Integer.parseInt(date.substring(8, 10));
		
		curr.set(Calendar.YEAR, year);
        curr.set(Calendar.MONTH, month-1);
        curr.set(Calendar.DATE, day);
        prev.set(Calendar.YEAR, year);
        prev.set(Calendar.MONTH, month-2);
        prev.set(Calendar.DATE, day);
        next.set(Calendar.YEAR, year);
        next.set(Calendar.MONTH, month);
        next.set(Calendar.DATE, day);
	}
	public String currYM() {
		return YM(this.curr);
	}
	public String prevYM() {
		return YM(this.prev);
	}
	public String nextYM() {
		return YM(this.next);
	}
	private String YM(Calendar cal) {
		String ret = "";
		ret = ret + Integer.toString(cal.get(Calendar.YEAR))+ "-";
		String temp = Integer.toString(cal.get(Calendar.MONTH)+1);
		if(temp.length()==1) ret = ret + "0"+temp;
		else ret = ret + temp;
		return ret;
	}
}

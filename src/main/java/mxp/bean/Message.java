package mxp.bean;

import java.util.HashMap;
import java.util.Map;

public class Message {
	private int code;
	private String message;
	private Map<String, Object> extend = new HashMap<String, Object>();
	
	public static Message success() {
		Message msg = new Message();
		msg.setCode(100);
		msg.setMessage("处理成功");
		return msg;
	}
	
	public static Message fail() {
		Message msg = new Message();
		msg.setCode(200);
		msg.setMessage("处理失败");
		return msg;
	}
	
	public Message add(String key, Object value) {
		extend.put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
}

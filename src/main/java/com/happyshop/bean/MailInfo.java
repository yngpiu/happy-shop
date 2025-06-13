package com.happyshop.bean;

/**
 * ===== BEAN THÔNG TIN EMAIL =====
 * 
 * Class bean lưu trữ thông tin email:
 * - Thông tin người gửi, người nhận
 * - Thông tin CC, BCC recipients
 * - Nội dung email (subject, body)
 * - Danh sách file đính kèm
 * 
 * Tính năng:
 * - Support multiple constructors
 * - Full getter/setter methods
 * - File attachments support
 * - Email template data container
 * 
 * Author: Development Team
 * Version: 1.0 - Email Data Transfer Object
 */
public class MailInfo {
	
	// ================= THUỘC TÍNH EMAIL =================
	
	String  from;		// Địa chỉ email người gửi
	String to;			// Địa chỉ email người nhận
	String cc;			// Địa chỉ email CC (Carbon Copy)
	String bcc;			// Địa chỉ email BCC (Blind Carbon Copy)
	String subject;		// Tiêu đề email
	String body;		// Nội dung email (HTML)
	String files;		// Đường dẫn file đính kèm (phân cách bởi dấu ;)
	
	// ================= CONSTRUCTORS =================
	
	/**
	 * Constructor mặc định
	 */
	public MailInfo() {
		super();
	}
	
	/**
	 * Constructor đầy đủ tham số
	 * @param from địa chỉ email người gửi
	 * @param to địa chỉ email người nhận
	 * @param cc địa chỉ email CC
	 * @param bcc địa chỉ email BCC
	 * @param subject tiêu đề email
	 * @param body nội dung email
	 * @param files file đính kèm
	 */
	public MailInfo(String from, String to, String cc, String bcc, String subject, String body, String files) {
		super();
		this.from = from;
		this.to = to;
		this.cc = cc;
		this.bcc = bcc;
		this.subject = subject;
		this.body = body;
		this.files = files;
	}
	
	/**
	 * Constructor đơn giản (từ, đến, tiêu đề, nội dung)
	 * @param from địa chỉ email người gửi
	 * @param to địa chỉ email người nhận
	 * @param subject tiêu đề email
	 * @param body nội dung email
	 */
	public MailInfo(String from, String to, String subject, String body) {
		super();
		this.from = from;
		this.to = to;
		this.subject = subject;
		this.body = body;
	}

	// ================= GETTERS & SETTERS =================

	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getBcc() {
		return bcc;
	}
	public void setBcc(String bcc) {
		this.bcc = bcc;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
}

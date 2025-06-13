package com.happyshop.service;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.happyshop.bean.MailInfo;

/**
 * ===== DỊCH VỤ QUẢN LÝ EMAIL =====
 * 
 * Service xử lý các chức năng liên quan đến email:
 * - Gửi email HTML với encoding UTF-8
 * - Hỗ trợ CC, BCC recipients
 * - Hỗ trợ file đính kèm
 * - Sử dụng template email tùy chỉnh
 * 
 * Tính năng:
 * - Gửi email thông báo đến khách hàng
 * - Gửi email xác nhận đơn hàng
 * - Gửi email báo cáo cho admin
 * - Hỗ trợ multiple file attachments
 * 
 * Author: Development Team
 * Version: 1.0 - Email Management Service
 */
@Service
public class MailService {
	
	// ================= DEPENDENCY INJECTION =================
	
	@Autowired
	JavaMailSender mailer;
	
	// ================= EMAIL OPERATIONS =================
	
	/**
	 * Gửi email với thông tin từ MailInfo object
	 * @param mail thông tin email cần gửi (MailInfo)
	 * @throws MessagingException nếu có lỗi trong quá trình gửi email
	 */
	public void send(MailInfo mail) throws MessagingException {
		MimeMessage message=mailer.createMimeMessage();
		MimeMessageHelper helper=new  MimeMessageHelper(message,true,"utf-8");
		
		// Thiết lập thông tin email cơ bản
		helper.setFrom(mail.getFrom());
		helper.setTo(mail.getTo());
		helper.setSubject(mail.getSubject());
		helper.setText(mail.getBody(),true);
		helper.setReplyTo(mail.getFrom());
		
		// Thiết lập CC nếu có
		if(mail.getCc() != null) {
			helper.setCc(mail.getCc());
		}
		
		// Thiết lập BCC nếu có
		if(mail.getBcc() != null) {
			helper.setBcc(mail.getBcc());
		}
		
		// Thêm file đính kèm nếu có
		if(mail.getFiles() != null) {
			String[] paths = mail.getFiles().split(";");
			for(String path: paths) {
				File file=new File(path);
				helper.addAttachment(file.getName(), file);
			}
		}
		
		// Gửi email
		mailer.send(message);
	}
}

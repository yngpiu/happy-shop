package com.happyshop.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * ===== ENTITY NGƯỜI DÙNG =====
 * 
 * Entity đại diện cho bảng Users trong database:
 * - Thông tin cá nhân người dùng
 * - Thông tin đăng nhập và phân quyền
 * - Validation dữ liệu đầu vào
 * - Liên kết với đơn hàng của người dùng
 * 
 * Tính năng:
 * - Quản lý thông tin tài khoản
 * - Phân quyền admin/user
 * - Tính năng kích hoạt/cấm tài khoản
 * - Lưu trữ thông tin liên hệ
 * 
 * Author: Development Team
 * Version: 1.0 - User Management Entity
 */
@Entity
@Table(name = "Users")
public class User {
	
	// ================= THUỘC TÍNH CHÍNH =================
	
	@Id
	@NotEmpty
	@Column(name = "Id")
	String id;					// ID người dùng (username)
	
	@NotEmpty
	@Length(min=6)
	@Column(name = "Password")
	String password;			// Mật khẩu (tối thiểu 6 ký tự)
	
	@NotEmpty
	@Column(name = "Fullname")
	String fullname;			// Họ và tên đầy đủ
	
	@NotEmpty
	@Column(name = "Telephone", length = 50)
	String telephone;			// Số điện thoại liên hệ
	
	@NotEmpty
	@Email
	@Column(name = "Email")
	String email;				// Địa chỉ email
	
	// ================= THUỘC TÍNH PROFILE =================
	
	@Column(name = "Photo")
	String photo;				// Đường dẫn ảnh đại diện
	
	// ================= THUỘC TÍNH QUYỀN =================
	
	@Column(name = "Activated")
	Boolean activated;			// Trạng thái kích hoạt tài khoản
	
	@Column(name = "Admin")
	Boolean admin;				// Phân quyền admin
	
	@Column(name = "isBanned")
	Boolean isBanned;			// Trạng thái cấm tài khoản

	// ================= QUAN HỆ ENTITY =================
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	List<Order> orders;			// Danh sách đơn hàng của người dùng

	// ================= GETTERS & SETTERS =================

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Boolean getActivated() {
		return activated;
	}

	public void setActivated(Boolean activated) {
		this.activated = activated;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
	
	public Boolean getIsBanned() {
		return isBanned;
	}
	
	public void setIsBanned(Boolean isBanned) {
		this.isBanned = isBanned;
	}
}
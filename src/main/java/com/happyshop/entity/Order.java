package com.happyshop.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * ===== ENTITY ĐƠN HÀNG =====
 * 
 * Entity đại diện cho bảng Orders trong database:
 * - Thông tin đơn hàng cơ bản
 * - Thông tin giao hàng (địa chỉ, SĐT)
 * - Trạng thái và giá trị đơn hàng
 * - Liên kết với người dùng và chi tiết đơn hàng
 * 
 * Tính năng:
 * - Quản lý thông tin đơn hàng
 * - Theo dõi trạng thái đơn hàng
 * - Lưu trữ thông tin giao hàng
 * - Tính tổng giá trị đơn hàng
 * 
 * Author: Development Team
 * Version: 1.0 - Order Management Entity
 */
@Entity
@Table(name = "Orders")
public class Order {
	
	// ================= THUỘC TÍNH CHÍNH =================
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;					// ID đơn hàng (tự động tăng)
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	Date orderDate;				// Ngày đặt hàng
	
	// ================= THÔNG TIN GIAO HÀNG =================
	
	String telephone;			// Số điện thoại nhận hàng
	String address;				// Địa chỉ giao hàng
	
	// ================= THÔNG TIN ĐỚN HÀNG =================
	
	Double amount;				// Tổng giá trị đơn hàng
	String description;			// Ghi chú đơn hàng
	Integer status;				// Trạng thái đơn hàng (-1: Hủy, 0: Chờ, 1: Xử lý, 2: Giao, 3: Hoàn thành)
	
	// ================= QUAN HỆ ENTITY =================
	
	@ManyToOne
	@JoinColumn(name="userId")
	User user;					// Người dùng đặt hàng
	
	@OneToMany(mappedBy = "order")
	List<OrderDetail> orderDetails;	// Chi tiết sản phẩm trong đơn hàng

	// ================= GETTERS & SETTERS =================

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
}
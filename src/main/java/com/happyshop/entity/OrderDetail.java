package com.happyshop.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * ===== ENTITY CHI TIẾT ĐƠN HÀNG =====
 * 
 * Entity đại diện cho bảng OrderDetails trong database:
 * - Thông tin chi tiết sản phẩm trong đơn hàng
 * - Liên kết giữa Order và Product
 * - Lưu trữ giá, số lượng, giảm giá
 * - Tính toán thành tiền cho từng item
 * 
 * Tính năng:
 * - Quản lý chi tiết đơn hàng
 * - Lưu trữ thông tin giá tại thời điểm mua
 * - Tính toán discount và thành tiền
 * - Liên kết với Order và Product
 * 
 * Author: Development Team
 * Version: 1.0 - Order Detail Management Entity
 */
@Entity
@Table(name = "OrderDetails")
public class OrderDetail {
	
	// ================= THUỘC TÍNH CHÍNH =================
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;				// ID chi tiết đơn hàng (tự động tăng)
	
	// ================= THÔNG TIN SẢN PHẨM =================
	
	Double unitPrice;		// Giá đơn vị tại thời điểm mua
	Integer quantity;		// Số lượng sản phẩm
	Double discount;		// Phần trăm giảm giá
	
	// ================= QUAN HỆ ENTITY =================
	
	@ManyToOne
	@JoinColumn(name="orderId")
	Order order;			// Đơn hàng chứa chi tiết này
	
	@ManyToOne
	@JoinColumn(name="productId")
	Product product;		// Sản phẩm trong chi tiết đơn hàng

	// ================= GETTERS & SETTERS =================

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
}

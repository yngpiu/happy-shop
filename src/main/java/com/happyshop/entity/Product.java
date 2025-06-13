package com.happyshop.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * Entity đại diện cho bảng Products trong database
 * Quản lý thông tin sản phẩm với tính năng soft delete
 */
@Entity
@Table(name = "products")
public class Product {
	
	// ================= THUỘC TÍNH CHÍNH =================
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;  // ID tự động tăng
	
	@Column(name = "name")
	String name;  // Tên sản phẩm
	
	@Column(name = "unit_price")
	Double unitPrice;  // Giá bán
	
	@Column(name = "image")
	String image;  // Đường dẫn hình ảnh
	
	@Column(name = "product_date")
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date productDate;  // Ngày sản xuất
	
	@Column(name = "available")
	Boolean available;  // Còn hàng hay không
	
	@Column(name = "quantity")
	Integer quantity;  // Số lượng tồn kho
	
	@Column(name = "description")
	String description;  // Mô tả sản phẩm
	
	@Column(name = "discount")
	Double discount;  // Phần trăm giảm giá
	
	@Column(name = "view_count")
	Integer viewCount;  // Số lượt xem
	
	@Column(name = "special")
	Boolean special;  // Sản phẩm đặc biệt
	
	// ================= THUỘC TÍNH SOFT DELETE =================
	
	@Column(name = "created_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date createdAt;  // Thời gian tạo
	
	@Column(name = "updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date updatedAt;  // Thời gian cập nhật lần cuối
	
	@Column(name = "deleted_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date deletedAt;  // Thời gian xóa (soft delete) - null nếu chưa xóa
	
	// ================= QUAN HỆ VỚI ENTITY KHÁC =================
	
	@ManyToOne
	@JoinColumn(name="category_id")
	Category category;  // Thuộc loại sản phẩm nào
	
	@OneToMany(mappedBy = "product")
	List<OrderDetail> orderDetails;  // Danh sách chi tiết đơn hàng có sản phẩm này

	// ================= LIFECYCLE HOOKS =================
	
	/**
	 * Tự động set thời gian tạo và cập nhật khi tạo mới
	 */
	@PrePersist
	protected void onCreate() {
		createdAt = new Date();
		updatedAt = new Date();
		if (viewCount == null) {
			viewCount = 0;
		}
		if (available == null) {
			available = true;
		}
		if (special == null) {
			special = false;
		}
		if (discount == null) {
			discount = 0.0;
		}
	}

	/**
	 * Tự động cập nhật thời gian sửa đổi khi update
	 */
	@PreUpdate
	protected void onUpdate() {
		updatedAt = new Date();
	}

	// ================= GETTERS & SETTERS =================

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getProductDate() {
		return productDate;
	}

	public void setProductDate(Date productDate) {
		this.productDate = productDate;
	}

	public Boolean getAvailable() {
		return available;
	}

	public void setAvailable(Boolean available) {
		this.available = available;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getDiscount() {
		return discount;
	}

	public void setDiscount(Double discount) {
		this.discount = discount;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public Boolean getSpecial() {
		return special;
	}

	public void setSpecial(Boolean special) {
		this.special = special;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Date getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Date deletedAt) {
		this.deletedAt = deletedAt;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	
	// ================= HELPER METHODS =================
	
	/**
	 * Kiểm tra xem sản phẩm đã bị xóa (soft delete) chưa
	 * @return true nếu đã bị xóa, false nếu còn hoạt động
	 */
	public boolean isDeleted() {
		return deletedAt != null;
	}
	
	/**
	 * Kiểm tra xem sản phẩm có đang hoạt động không
	 * @return true nếu đang hoạt động, false nếu đã bị xóa
	 */
	public boolean isActive() {
		return deletedAt == null;
	}
	
	/**
	 * Tính số ngày đã trôi qua kể từ khi bị xóa (soft delete)
	 * Dùng cho tính năng thùng rác - tự động xóa vĩnh viễn sau 30 ngày
	 * @return số ngày kể từ khi xóa, 0 nếu chưa bị xóa
	 */
	public Long getDaysSinceDeleted() {
		if (deletedAt == null) {
			return 0L;
		}
		long diffInMillies = new Date().getTime() - deletedAt.getTime();
		return diffInMillies / (24 * 60 * 60 * 1000); // Chuyển milliseconds thành ngày
	}
	
	/**
	 * Tính giá sau khi áp dụng giảm giá
	 * @return giá cuối cùng sau khi trừ discount
	 */
	public Double getFinalPrice() {
		if (discount == null || discount == 0) {
			return unitPrice;
		}
		return unitPrice * (1 - discount / 100);
	}
	
	/**
	 * Kiểm tra xem sản phẩm có đang giảm giá không
	 * @return true nếu có giảm giá > 0
	 */
	public boolean isOnSale() {
		return discount != null && discount > 0;
	}
}

package com.happyshop.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity đại diện cho bảng Categories trong database
 * Quản lý thông tin loại sản phẩm với tính năng soft delete
 */
@Entity
@Table(name = "Categories")
public class Category {
	
	// ================= THUỘC TÍNH =================
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;  // ID tự động tăng
	
	@Column(name = "name")
	String name;  // Tên loại sản phẩm
	
	@Column(name = "created_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date createdAt;  // Thời gian tạo
	
	@Column(name = "updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date updatedAt;  // Thời gian cập nhật lần cuối
	
	@Column(name = "deleted_at")
	@Temporal(TemporalType.TIMESTAMP)
	Date deletedAt;  // Thời gian xóa (soft delete) - null nếu chưa xóa
	
	@OneToMany(mappedBy="category")
	List<Product> products;  // Danh sách sản phẩm thuộc loại này

	// ================= LIFECYCLE HOOKS =================
	
	/**
	 * Tự động set thời gian tạo và cập nhật khi tạo mới
	 */
	@PrePersist
	protected void onCreate() {
		createdAt = new Date();
		updatedAt = new Date();
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

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	// ================= HELPER METHODS =================
	
	/**
	 * Kiểm tra xem loại sản phẩm đã bị xóa (soft delete) chưa
	 * @return true nếu đã bị xóa, false nếu còn hoạt động
	 */
	public boolean isDeleted() {
		return deletedAt != null;
	}
	
	/**
	 * Kiểm tra xem loại sản phẩm có đang hoạt động không
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
}

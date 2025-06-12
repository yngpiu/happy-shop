package com.happyshop.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happyshop.entity.OrderDetail;
import com.happyshop.entity.Product;

/**
 * Implementation của ProductDAO sử dụng Hibernate
 * Cung cấp các chức năng CRUD và soft delete cho sản phẩm
 */
@Transactional
@Repository
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	SessionFactory factory;

	// ================= CRUD OPERATIONS =================

	/**
	 * Tạo mới sản phẩm
	 */
	@Override
	public void create(Product entity) {
		Session session = factory.getCurrentSession();
		session.save(entity);
	}

	/**
	 * Cập nhật thông tin sản phẩm
	 */
	@Override
	public void update(Product entity) {
		Session session = factory.getCurrentSession();
		session.update(entity);
	}

	/**
	 * Tìm sản phẩm theo ID (bao gồm cả đã xóa)
	 */
	@Override
	public Product findById(Integer id) {
		Session session = factory.getCurrentSession();
		return session.find(Product.class, id);
	}

	/**
	 * Lấy tất cả sản phẩm (bao gồm cả đã xóa)
	 */
	@Override
	public List<Product> findAll() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product ORDER BY id DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		return query.getResultList();
	}

	/**
	 * Lấy danh sách sản phẩm đang hoạt động
	 */
	@Override
	public List<Product> findAllActive() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NULL ORDER BY id DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		return query.getResultList();
	}

	/**
	 * Lấy danh sách sản phẩm đã bị xóa
	 */
	@Override
	public List<Product> findAllDeleted() {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NOT NULL ORDER BY deletedAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		return query.getResultList();
	}

	// ================= SOFT DELETE OPERATIONS =================

	/**
	 * Xóa sản phẩm (backward compatibility - thực hiện soft delete)
	 */
	@Override
	public void delete(Integer id) {
		softDelete(id); // Chuyển hướng tới soft delete để đảm bảo tính nhất quán
	}

	/**
	 * Xóa mềm sản phẩm (chuyển vào thùng rác)
	 */
	@Override
	public void softDelete(Integer id) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE Product SET deletedAt = :deletedAt WHERE id = :id";
		Query<?> query = session.createQuery(hql);
		query.setParameter("deletedAt", new Date());
		query.setParameter("id", id);
		query.executeUpdate();
	}

	/**
	 * Khôi phục sản phẩm từ thùng rác
	 */
	@Override
	public void restore(Integer id) {
		Session session = factory.getCurrentSession();
		String hql = "UPDATE Product SET deletedAt = NULL WHERE id = :id";
		Query<?> query = session.createQuery(hql);
		query.setParameter("id", id);
		query.executeUpdate();
	}

	/**
	 * Xóa vĩnh viễn sản phẩm khỏi database
	 */
	@Override
	public void permanentDelete(Integer id) {
		Session session = factory.getCurrentSession();
		Product entity = session.find(Product.class, id);
		if (entity != null) {
			session.delete(entity);
		}
	}

	// ================= STATISTICS & COUNTS =================

	/**
	 * Đếm tổng số sản phẩm
	 */
	@Override
	public Long countAll() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Product";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	/**
	 * Đếm số sản phẩm đang hoạt động
	 */
	@Override
	public Long countActive() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Product WHERE deletedAt IS NULL";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	/**
	 * Đếm số sản phẩm đã bị xóa
	 */
	@Override
	public Long countDeleted() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Product WHERE deletedAt IS NOT NULL";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	/**
	 * Đếm số sản phẩm còn hàng
	 */
	@Override
	public Long countAvailable() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Product WHERE deletedAt IS NULL AND available = true";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	/**
	 * Đếm số sản phẩm đặc biệt
	 */
	@Override
	public Long countSpecial() {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(*) FROM Product WHERE deletedAt IS NULL AND special = true";
		Query<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	/**
	 * Đếm số đơn hàng có chứa sản phẩm này
	 */
	@Override
	public Long countOrdersByProduct(Integer productId) {
		Session session = factory.getCurrentSession();
		String hql = "SELECT COUNT(DISTINCT od.order.id) FROM OrderDetail od WHERE od.product.id = :productId";
		Query<Long> query = session.createQuery(hql, Long.class);
		query.setParameter("productId", productId);
		return query.getSingleResult();
	}

	/**
	 * Xóa tất cả OrderDetails liên quan đến sản phẩm
	 */
	@Override
	public int deleteOrderDetailsByProduct(Integer productId) {
		Session session = factory.getCurrentSession();
		String hql = "DELETE FROM OrderDetail WHERE product.id = :productId";
		Query<?> query = session.createQuery(hql);
		query.setParameter("productId", productId);
		return query.executeUpdate();
	}

	// ================= FILTER BY CATEGORY =================

	/**
	 * Lấy sản phẩm theo loại sản phẩm
	 */
	@Override
	public List<Product> findByCategory(Integer categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE category.id = :categoryId ORDER BY id DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("categoryId", categoryId);
		return query.getResultList();
	}

	/**
	 * Lấy sản phẩm active theo loại sản phẩm
	 */
	@Override
	public List<Product> findActiveByCategoryId(Integer categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE category.id = :categoryId AND deletedAt IS NULL ORDER BY id DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("categoryId", categoryId);
		return query.getResultList();
	}

	// ================= FRONTEND SUPPORT METHODS =================

	/**
	 * Lấy sản phẩm đặc biệt với số lượng giới hạn
	 */
	@Override
	public List<Product> findSpecialProducts(int limit) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NULL AND special = true AND available = true ORDER BY createdAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setMaxResults(limit);
		return query.getResultList();
	}

	/**
	 * Lấy sản phẩm đang hoạt động với số lượng giới hạn
	 */
	@Override
	public List<Product> findActiveProducts(int limit) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NULL AND available = true ORDER BY createdAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setMaxResults(limit);
		return query.getResultList();
	}

	/**
	 * Lấy sản phẩm theo category ID (cho frontend)
	 */
	@Override
	public List<Product> findByCategoryId(Integer categoryId) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NULL AND category.id = :categoryId AND available = true ORDER BY createdAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("categoryId", categoryId);
		return query.getResultList();
	}

	/**
	 * Tìm sản phẩm theo từ khóa
	 */
	@Override
	public List<Product> findByKeywords(String keywords) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Product WHERE deletedAt IS NULL AND available = true " +
		            "AND (LOWER(name) LIKE :keywords OR LOWER(description) LIKE :keywords) " +
		            "ORDER BY createdAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("keywords", "%" + keywords.toLowerCase() + "%");
		return query.getResultList();
	}

	/**
	 * Tìm sản phẩm theo danh sách ID (phân cách bởi dấu phẩy)
	 */
	@Override
	public List<Product> findByIds(String ids) {
		Session session = factory.getCurrentSession();
		
		if (ids == null || ids.trim().isEmpty()) {
			return new java.util.ArrayList<>();
		}

		// Chuyển đổi chuỗi ID thành list Integer
		String[] idArray = ids.split(",");
		java.util.List<Integer> idList = new java.util.ArrayList<>();
		for (String id : idArray) {
			try {
				idList.add(Integer.parseInt(id.trim()));
			} catch (NumberFormatException e) {
				// Bỏ qua ID không hợp lệ
			}
		}

		if (idList.isEmpty()) {
			return new java.util.ArrayList<>();
		}

		String hql = "FROM Product WHERE deletedAt IS NULL AND id IN (:ids) ORDER BY createdAt DESC";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("ids", idList);
		return query.getResultList();
	}

	// ================= AUTO CLEANUP =================

	/**
	 * Tìm sản phẩm đã hết hạn (đã bị xóa quá 30 ngày)
	 */
	@Override
	public List<Product> findExpiredProducts() {
		Session session = factory.getCurrentSession();
		
		// Tính ngày 30 ngày trước
		long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);
		Date expiryDate = new Date(thirtyDaysAgo);
		
		String hql = "FROM Product WHERE deletedAt IS NOT NULL AND deletedAt < :expiryDate";
		Query<Product> query = session.createQuery(hql, Product.class);
		query.setParameter("expiryDate", expiryDate);
		return query.getResultList();
	}

	/**
	 * Tự động xóa vĩnh viễn sản phẩm đã hết hạn
	 */
	@Override
	public int autoDeleteExpiredProducts() {
		Session session = factory.getCurrentSession();
		
		// Tính ngày 30 ngày trước
		long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);
		Date expiryDate = new Date(thirtyDaysAgo);
		
		String hql = "DELETE FROM Product WHERE deletedAt IS NOT NULL AND deletedAt < :expiryDate";
		Query<?> query = session.createQuery(hql);
		query.setParameter("expiryDate", expiryDate);
		return query.executeUpdate();
	}



}

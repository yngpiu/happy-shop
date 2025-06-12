package com.happyshop.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happyshop.entity.Category;

/**
 * Implementation của CategoryDAO
 * Xử lý các thao tác database liên quan đến Category
 */
@Transactional
@Repository
public class CategoryDAOImpl implements CategoryDAO{

	@Autowired
	SessionFactory factory;
	
	@Override
	public Category findById(Integer id) {
		Session session=factory.getCurrentSession();
		Category entity=session.find(Category.class, id);
		return entity;
	}

	@Override
	public List<Category> findAll() {
		String hql="FROM Category ORDER BY id ASC";
		Session session=factory.getCurrentSession();
		TypedQuery<Category> query=session.createQuery(hql,Category.class);
		List<Category> list=query.getResultList();
		return list;
	}
	
	@Override
	public List<Category> findAllActive() {
		String hql="FROM Category WHERE deletedAt IS NULL ORDER BY id ASC";
		Session session=factory.getCurrentSession();
		TypedQuery<Category> query=session.createQuery(hql,Category.class);
		List<Category> list=query.getResultList();
		return list;
	}
	
	@Override
	public List<Category> findAllDeleted() {
		String hql="FROM Category WHERE deletedAt IS NOT NULL ORDER BY deletedAt DESC";
		Session session=factory.getCurrentSession();
		TypedQuery<Category> query=session.createQuery(hql,Category.class);
		List<Category> list=query.getResultList();
		return list;
	}
	
	@Override
	public Category create(Category entity) {
		Session session=factory.getCurrentSession();
		session.save(entity);
		return null;
	}

	@Override
	public void update(Category entity) {
		Session session=factory.getCurrentSession();
		session.update(entity);
	}

	@Override
	public Category delete(Integer id) {
		Session session=factory.getCurrentSession();
		Category entity=session.find(Category.class, id);
		session.delete(entity);
		return entity;
	}

	@Override
	public void softDelete(Integer id) {
		Session session=factory.getCurrentSession();
		Category entity=session.find(Category.class, id);
		if (entity != null) {
			entity.setDeletedAt(new Date());
			session.update(entity);
		}
	}

	@Override
	public void restore(Integer id) {
		Session session=factory.getCurrentSession();
		Category entity=session.find(Category.class, id);
		if (entity != null) {
			entity.setDeletedAt(null);
			session.update(entity);
		}
	}

	@Override
	public void permanentDelete(Integer id) {
		Session session=factory.getCurrentSession();
		Category entity=session.find(Category.class, id);
		if (entity != null) {
			session.delete(entity);
		}
	}

	@Override
	public Long countProductsByCategory(Integer categoryId) {
		String hql = "SELECT COUNT(p) FROM Product p WHERE p.category.id = :categoryId";
		Session session = factory.getCurrentSession();
		TypedQuery<Long> query = session.createQuery(hql, Long.class);
		query.setParameter("categoryId", categoryId);
		return query.getSingleResult();
	}

	@Override
	public Long countAll() {
		String hql = "SELECT COUNT(c) FROM Category c";
		Session session = factory.getCurrentSession();
		TypedQuery<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	@Override
	public Long countActive() {
		String hql = "SELECT COUNT(c) FROM Category c WHERE c.deletedAt IS NULL";
		Session session = factory.getCurrentSession();
		TypedQuery<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	@Override
	public Long countDeleted() {
		String hql = "SELECT COUNT(c) FROM Category c WHERE c.deletedAt IS NOT NULL";
		Session session = factory.getCurrentSession();
		TypedQuery<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	@Override
	public Long countWithProducts() {
		String hql = "SELECT COUNT(DISTINCT c) FROM Category c JOIN c.products p WHERE c.deletedAt IS NULL";
		Session session = factory.getCurrentSession();
		TypedQuery<Long> query = session.createQuery(hql, Long.class);
		return query.getSingleResult();
	}

	// ================= TỰ ĐỘNG DỌN DẸP =================
	
	/**
	 * Tìm các category đã bị xóa mềm quá 30 ngày
	 * @return List<Category> danh sách category hết hạn
	 */
	@Override
	public List<Category> findExpiredCategories() {
		Session session = factory.getCurrentSession();
		// Tính ngày 30 ngày trước
		long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);
		Date cutoffDate = new Date(thirtyDaysAgo);
		
		String hql = "FROM Category WHERE deletedAt IS NOT NULL AND deletedAt <= :cutoffDate";
		TypedQuery<Category> query = session.createQuery(hql, Category.class);
		query.setParameter("cutoffDate", cutoffDate);
		
		List<Category> expiredCategories = query.getResultList();
		return expiredCategories;
	}
	
	/**
	 * Tự động xóa vĩnh viễn các category đã ở thùng rác quá 30 ngày
	 * @return int số lượng category đã bị xóa
	 */
	@Override
	public int autoDeleteExpiredCategories() {
		Session session = factory.getCurrentSession();
		// Tính ngày 30 ngày trước
		long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);
		Date cutoffDate = new Date(thirtyDaysAgo);
		
		// Xóa vĩnh viễn các category hết hạn
		String hql = "DELETE FROM Category WHERE deletedAt IS NOT NULL AND deletedAt <= :cutoffDate";
		org.hibernate.query.Query query = session.createQuery(hql);
		query.setParameter("cutoffDate", cutoffDate);
		
		int deletedCount = query.executeUpdate();
		return deletedCount;
	}
}

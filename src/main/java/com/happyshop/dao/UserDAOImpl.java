package com.happyshop.dao;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happyshop.entity.User;

/**
 * ===== IMPLEMENTATION DAO QUẢN LÝ NGƯỜI DÙNG =====
 * 
 * Triển khai các chức năng UserDAO sử dụng Hibernate:
 * - CRUD operations cho User entity
 * - Hỗ trợ phân trang dữ liệu
 * - Tìm kiếm và lọc người dùng
 * - Quản lý session và transaction
 * 
 * Tính năng:
 * - Tạo, sửa, xóa, tìm kiếm người dùng
 * - Phân trang danh sách người dùng
 * - Đếm tổng số người dùng
 * - Transaction management tự động
 * 
 * Author: Development Team
 * Version: 1.0 - User Data Access Implementation
 */
@Transactional
@Repository
public class UserDAOImpl implements UserDAO{

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	SessionFactory factory;
	
	// ================= CRUD OPERATIONS =================
	
	/**
	 * Tìm người dùng theo ID
	 * @param id ID của người dùng
	 * @return User entity hoặc null nếu không tìm thấy
	 */
	@Override
	public User findById(String id) {
		Session session=factory.getCurrentSession();
		User entity=session.find(User.class, id);
		return entity;
	}

	/**
	 * Lấy tất cả người dùng trong hệ thống
	 * @return List<User> danh sách tất cả người dùng
	 */
	@Override
	public List<User> findAll() {
		String hql="FROM User";
		Session session=factory.getCurrentSession();
		TypedQuery<User> query=session.createQuery(hql,User.class);
		List<User> list=query.getResultList();
		return list;
	}

	/**
	 * Tạo người dùng mới
	 * @param entity User entity cần tạo
	 * @return User entity đã được tạo
	 */
	@Override
	public User create(User entity) {
		Session session=factory.getCurrentSession();
		session.save(entity);
		return null;
	}

	/**
	 * Cập nhật thông tin người dùng
	 * @param entity User entity với thông tin mới
	 */
	@Override
	public void update(User entity) {
		Session session=factory.getCurrentSession();
		session.update(entity);
	}

	/**
	 * Xóa người dùng theo ID
	 * @param id ID của người dùng cần xóa
	 * @return User entity đã bị xóa
	 */
	@Override
	public User delete(String id) {
		Session session=factory.getCurrentSession();
		User entity=session.find(User.class, id);
		session.delete(entity);
		return entity;
	}

	// ================= PAGINATION OPERATIONS =================

	/**
	 * Tính tổng số trang dựa trên kích thước trang
	 * @param pageSize số lượng record trên mỗi trang
	 * @return tổng số trang
	 */
	@Override
	public long getPageCount(int pageSize) {
		String hql="SELECT count(c) FROM User c";
		Session session=factory.getCurrentSession();
		TypedQuery<Long> query=session.createQuery(hql,Long.class);
		Long rowCount=query.getSingleResult();
		long pageCount= (long) Math.ceil(1.0*rowCount/pageSize);
		return pageCount;
	}

	/**
	 * Lấy dữ liệu người dùng theo trang
	 * @param pageNo số thứ tự trang (bắt đầu từ 0)
	 * @param pageSize số lượng record trên mỗi trang
	 * @return List<User> danh sách người dùng trong trang
	 */
	@Override
	public List<User> getPage(int pageNo, int pageSize) {
		String hql="FROM User";
		Session session=factory.getCurrentSession();
		TypedQuery<User> query=session.createQuery(hql,User.class);
		query.setFirstResult(pageNo * pageSize);
		query.setMaxResults(pageSize);
		List<User> list=query.getResultList();
		return list;
	}
}

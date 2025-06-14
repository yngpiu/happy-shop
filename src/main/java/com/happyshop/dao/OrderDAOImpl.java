 package com.happyshop.dao;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happyshop.entity.Order;
import com.happyshop.entity.OrderDetail;
import com.happyshop.entity.Product;
import com.happyshop.entity.User;

@Transactional
@Repository
public class OrderDAOImpl implements OrderDAO{

	@Autowired
	SessionFactory factory;
	
	@Override
	public Order findById(Integer id) {
		Session session=factory.getCurrentSession();
		Order entity=session.find(Order.class, id);
		return entity;
	}

	@Override
	public List<Order> findAll() {
		String hql="FROM Order";
		Session session=factory.getCurrentSession();
		TypedQuery<Order> query=session.createQuery(hql,Order.class);
		List<Order> list=query.getResultList();
		return list;
	}

	@Override
	public Order create(Order entity) {
		Session session=factory.getCurrentSession();
		session.save(entity);
		return entity;
	}

	@Override
	public void update(Order entity) {
		Session session=factory.getCurrentSession();
		session.update(entity);
		
	}

	@Override
	public Order delete(Integer id) {
		Session session=factory.getCurrentSession();
		Order entity=session.find(Order.class, id);
		session.delete(entity);
		return entity;
	}

	@Override
	public void create(Order order, List<OrderDetail> details) {
		Session session=factory.getCurrentSession();
		session.save(order);
		for(OrderDetail detail : details) {
			session.save(detail);
			
			// Cập nhật số lượng tồn kho của sản phẩm
			Product cartProduct = detail.getProduct();
			if (cartProduct != null) {
				// Lấy sản phẩm từ database để có số lượng tồn kho chính xác
				Product dbProduct = session.find(Product.class, cartProduct.getId());
				if (dbProduct != null && dbProduct.getQuantity() != null) {
					int currentQuantity = dbProduct.getQuantity();
					int orderedQuantity = detail.getQuantity();
					
					System.out.println("=== INVENTORY UPDATE DEBUG ===");
					System.out.println("Product ID: " + dbProduct.getId());
					System.out.println("Product Name: " + dbProduct.getName());
					System.out.println("Current Stock: " + currentQuantity);
					System.out.println("Ordered Quantity: " + orderedQuantity);
					
					// Giảm số lượng tồn kho
					int newQuantity = currentQuantity - orderedQuantity;
					
					// Đảm bảo số lượng không âm
					if (newQuantity < 0) {
						newQuantity = 0;
					}
					
					System.out.println("New Stock: " + newQuantity);
					System.out.println("===============================");
					
					dbProduct.setQuantity(newQuantity);
					
					// Nếu hết hàng, đánh dấu không còn available
					if (newQuantity == 0) {
						dbProduct.setAvailable(false);
					}
					
					session.update(dbProduct);
				}
			}
		}
	}

	@Override
	public List<Order> findByUser(User user) {
		String hql="FROM Order o WHERE o.user.id=:uid ORDER BY o.orderDate DESC";
		Session session=factory.getCurrentSession();
		TypedQuery<Order> query=session.createQuery(hql,Order.class);
		query.setParameter("uid", user.getId());
		List<Order> list=query.getResultList();
		return list;
	}

	@Override
	public List<Product> findItemsByUser(User user) {
		String hql="SELECT DISTINCT d.product FROM OrderDetail d WHERE d.order.user.id=:uid";
		Session session=factory.getCurrentSession();
		TypedQuery<Product> query=session.createQuery(hql,Product.class);
		query.setParameter("uid", user.getId());
		List<Product> list=query.getResultList();
		return list;
	}

}

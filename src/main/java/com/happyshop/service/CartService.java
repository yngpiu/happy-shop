package com.happyshop.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Product;

/**
 * ===== DỊCH VỤ GIỎ HÀNG =====
 * 
 * Service quản lý giỏ hàng trong session:
 * - Thêm/xóa sản phẩm khỏi giỏ hàng
 * - Cập nhật số lượng sản phẩm
 * - Tính toán tổng tiền và số lượng
 * - Quản lý session-based cart
 * 
 * Tính năng:
 * - Session-scoped cart management
 * - Product quantity calculation
 * - Total amount calculation với discount
 * - Cart operations (add, remove, update, clear)
 * 
 * Author: Development Team
 * Version: 1.0 - Shopping Cart Service
 */
@SessionScope //Name: scopedTarget.cartService
@Service
public class CartService {

	// ================= DEPENDENCY INJECTION =================

	@Autowired
	ProductDAO dao;

	// ================= CART DATA =================

	Map<Integer, Product> map = new HashMap<>();

	// ================= CART OPERATIONS =================

	/**
	 * Thêm sản phẩm vào giỏ hàng
	 * Nếu sản phẩm đã có, tăng số lượng lên 1
	 * @param id ID của sản phẩm cần thêm
	 */
	public void add(Integer id) {
		Product p = map.get(id);
		if (p == null) {
			p = dao.findById(id);
			p.setQuantity(1);
			map.put(id, p);
		} else {
			p.setQuantity(p.getQuantity() + 1);
		}
	}

	/**
	 * Xóa sản phẩm khỏi giỏ hàng
	 * @param id ID của sản phẩm cần xóa
	 */
	public void remove(Integer id) {
		map.remove(id);
	}

	/**
	 * Cập nhật số lượng sản phẩm trong giỏ hàng
	 * @param id ID của sản phẩm
	 * @param qty Số lượng mới
	 */
	public void update(Integer id, int qty) {
		Product p = map.get(id);
		p.setQuantity(qty);
	}

	/**
	 * Xóa tất cả sản phẩm trong giỏ hàng
	 */
	public void clear() {
		map.clear();
	}

	// ================= CALCULATION METHODS =================

	/**
	 * Tính tổng số lượng sản phẩm trong giỏ hàng
	 * @return int tổng số lượng items
	 */
	public int getCount() {
		Collection<Product> ps = this.getItems();
		int count = 0;
		for (Product p : ps) {
			count += p.getQuantity();
		}
		return count;
	}

	/**
	 * Tính tổng giá trị giỏ hàng (đã tính discount)
	 * @return double tổng tiền cần thanh toán
	 */
	public double getAmount() {
		Collection<Product> ps = this.getItems();
		double amount = 0;
		for (Product p : ps) {
			amount += p.getQuantity() * p.getUnitPrice() * (1 - p.getDiscount() / 100.0);
		}
		return amount;
	}

	/**
	 * Lấy tất cả sản phẩm trong giỏ hàng
	 * @return Collection<Product> danh sách sản phẩm
	 */
	public Collection<Product> getItems() {
		return map.values();
	}
}

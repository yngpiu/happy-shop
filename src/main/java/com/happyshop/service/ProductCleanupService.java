package com.happyshop.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.happyshop.dao.ProductDAO;
import com.happyshop.entity.Product;

/**
 * Service tự động dọn dẹp sản phẩm đã hết hạn (>30 ngày trong thùng rác)
 * Chạy hoàn toàn tự động hàng ngày vào lúc 2:30 AM
 * KHÔNG có chức năng thủ công - chỉ tự động xóa
 */
@Service
@Transactional
public class ProductCleanupService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductCleanupService.class);
	
	@Autowired
	private ProductDAO productDAO;
	
	/**
	 * Tự động xóa vĩnh viễn các sản phẩm đã hết hạn (>30 ngày trong thùng rác)
	 * Chạy mỗi ngày lúc 2:30 AM (khác thời gian với CategoryCleanupService để tránh xung đột)
	 * Cron pattern: giây phút giờ ngày tháng thứ
	 */
	@Scheduled(cron = "0 30 2 * * ?")
	public void cleanupExpiredProducts() {
		logger.info("=== BẮT ĐẦU DỌNG DẸP SẢN PHẨM TỰ ĐỘNG ===");
		
		try {
			// Tìm các sản phẩm hết hạn trước khi xóa (để log)
			List<Product> expiredProducts = productDAO.findExpiredProducts();
			
			if (expiredProducts.isEmpty()) {
				logger.info("Không có sản phẩm nào hết hạn cần xóa");
				return;
			}
			
			// Log thông tin các sản phẩm sẽ bị xóa
			logger.info("Tìm thấy {} sản phẩm hết hạn sẽ bị xóa vĩnh viễn:", expiredProducts.size());
			for (Product product : expiredProducts) {
				long daysDeleted = product.getDaysSinceDeleted();
				logger.info("- ID: {}, Tên: '{}', Đã xóa {} ngày", 
						product.getId(), product.getName(), daysDeleted);
			}
			
			// Thực hiện xóa vĩnh viễn
			int deletedCount = productDAO.autoDeleteExpiredProducts();
			
			if (deletedCount > 0) {
				logger.info("✅ ĐÃ XÓA THÀNH CÔNG {} sản phẩm hết hạn", deletedCount);
			} else {
				logger.warn("⚠️ Không xóa được sản phẩm nào (có thể đã bị xóa bởi tiến trình khác)");
			}
			
		} catch (Exception e) {
			logger.error("❌ LỖI KHI DỌNG DẸP SẢN PHẨM TỰ ĐỘNG: {}", e.getMessage(), e);
		}
		
		logger.info("=== KẾT THÚC DỌNG DẸP SẢN PHẨM TỰ ĐỘNG ===");
	}
	
	/**
	 * Lấy danh sách sản phẩm sắp hết hạn (25-30 ngày) để cảnh báo
	 * @return List<Product> danh sách sản phẩm sắp hết hạn
	 */
	public List<Product> getExpiringSoonProducts() {
		return productDAO.findExpiredProducts();
	}
} 
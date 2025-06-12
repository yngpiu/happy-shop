package com.happyshop.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.happyshop.dao.CategoryDAO;
import com.happyshop.entity.Category;

/**
 * Service tự động dọn dẹp category đã hết hạn (>30 ngày trong thùng rác)
 * Chạy hoàn toàn tự động hàng ngày vào lúc 2:00 AM
 * KHÔNG có chức năng thủ công - chỉ tự động xóa
 */
@Service
@Transactional
public class CategoryCleanupService {
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryCleanupService.class);
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	/**
	 * Tự động xóa vĩnh viễn các category đã hết hạn (>30 ngày trong thùng rác)
	 * Chạy mỗi ngày lúc 2:00 AM
	 * Cron pattern: giây phút giờ ngày tháng thứ
	 */
	@Scheduled(cron = "0 0 2 * * ?")
	public void cleanupExpiredCategories() {
		logger.info("=== BẮT ĐẦU DỌNG DẸP TỰ ĐỘNG ===");
		
		try {
			// Tìm các category hết hạn trước khi xóa (để log)
			List<Category> expiredCategories = categoryDAO.findExpiredCategories();
			
			if (expiredCategories.isEmpty()) {
				logger.info("Không có category nào hết hạn cần xóa");
				return;
			}
			
			// Log thông tin các category sẽ bị xóa
			logger.info("Tìm thấy {} category hết hạn sẽ bị xóa vĩnh viễn:", expiredCategories.size());
			for (Category category : expiredCategories) {
				long daysDeleted = category.getDaysSinceDeleted();
				logger.info("- ID: {}, Tên: '{}', Đã xóa {} ngày", 
						category.getId(), category.getName(), daysDeleted);
			}
			
			// Thực hiện xóa vĩnh viễn
			int deletedCount = categoryDAO.autoDeleteExpiredCategories();
			
			if (deletedCount > 0) {
				logger.info("✅ ĐÃ XÓA THÀNH CÔNG {} category hết hạn", deletedCount);
			} else {
				logger.warn("⚠️ Không xóa được category nào (có thể đã bị xóa bởi tiến trình khác)");
			}
			
		} catch (Exception e) {
			logger.error("❌ LỖI KHI DỌNG DẸP TỰ ĐỘNG: {}", e.getMessage(), e);
		}
		
		logger.info("=== KẾT THÚC DỌNG DẸP TỰ ĐỘNG ===");
	}
	

	
	/**
	 * Lấy danh sách category sắp hết hạn (25-30 ngày) để cảnh báo
	 * @return List<Category> danh sách category sắp hết hạn
	 */
	public List<Category> getExpiringSoonCategories() {
		return categoryDAO.findExpiredCategories();
	}
} 
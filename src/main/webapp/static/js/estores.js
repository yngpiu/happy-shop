// ================= MODERN ESTORE JAVASCRIPT =================
// Bootstrap 5 + Modern UI Interactions
// Author: Development Team
// Version: 2.0 - Bootstrap 5 Compatible

$(document).ready(function () {
  // ================= CART MANAGEMENT =================

  /**
   * Add product to cart with modern UI feedback
   */
  $(document).on('click', '.btn-add-to-cart, .btn-add-cart', function (e) {
    e.preventDefault();
    const button = $(this);

    // Try multiple ways to get product ID
    let productId = button.data('id');
    if (!productId) {
      productId = button.attr('data-id');
    }
    if (!productId) {
      productId = this.getAttribute('data-id');
    }

    // Stop if no product ID found
    if (!productId) {
      console.error('No product ID found!');
      showToast('Lỗi!', 'Không tìm thấy ID sản phẩm', 'error');
      return;
    }

    // Disable button and show loading
    button.prop('disabled', true);
    const originalText = button.html();
    button.html('<i class="bi bi-arrow-repeat spin me-2"></i>Đang thêm...');

    // Add loading class to card
    button
      .closest('.product-card, .special-product-card, .simple-product-card')
      .addClass('loading');

    // AJAX call to add to cart
    $.ajax({
      url: '/cart/add/' + productId,
      type: 'GET',
      success: function (response) {
        if (response.success) {
          // Success animation
          button.removeClass('btn-primary btn-special').addClass('btn-success');
          button.html('<i class="bi bi-check-circle me-2"></i>Đã thêm vào giỏ');

          // Update cart count in header
          updateCartCount();

          // Show success toast
          showToast(
            'Thành công!',
            response.message || 'Sản phẩm đã được thêm vào giỏ hàng',
            'success'
          );

          // Reset button after 2 seconds
          setTimeout(function () {
            button.addClass('btn-primary').removeClass('btn-success');
            button.html(originalText);
            button.prop('disabled', false);
            button
              .closest(
                '.product-card, .special-product-card, .simple-product-card'
              )
              .removeClass('loading');
          }, 2000);
        } else {
          // Handle server-side validation error
          button.removeClass('btn-primary btn-special').addClass('btn-warning');
          button.html(
            '<i class="bi bi-exclamation-triangle me-2"></i>Không đủ hàng'
          );

          showToast(
            'Cảnh báo!',
            response.message || 'Không thể thêm sản phẩm vào giỏ hàng',
            'warning'
          );

          // Reset button
          setTimeout(function () {
            button.addClass('btn-primary').removeClass('btn-warning');
            button.html(originalText);
            button.prop('disabled', false);
            button
              .closest(
                '.product-card, .special-product-card, .simple-product-card'
              )
              .removeClass('loading');
          }, 3000);
        }
      },
      error: function (xhr) {
        let errorMessage = 'Không thể thêm sản phẩm vào giỏ hàng';

        if (xhr.responseJSON && xhr.responseJSON.message) {
          errorMessage = xhr.responseJSON.message;
        }

        // Error handling
        button.removeClass('btn-primary btn-special').addClass('btn-danger');
        button.html('<i class="bi bi-x-circle me-2"></i>Lỗi');

        showToast('Lỗi!', errorMessage, 'error');

        // Reset button
        setTimeout(function () {
          button.addClass('btn-primary').removeClass('btn-danger');
          button.html(originalText);
          button.prop('disabled', false);
          button
            .closest(
              '.product-card, .special-product-card, .simple-product-card'
            )
            .removeClass('loading');
        }, 3000);
      },
    });
  });

  /**
   * Update cart count in header
   */
  function updateCartCount() {
    $.ajax({
      url: '/cart/count',
      type: 'GET',
      success: function (count) {
        $('.cart-count').text(count);
        $('.cart-badge').text(count);

        // Animate cart icon
        $('.cart-icon').addClass('animate__animated animate__pulse');
        setTimeout(function () {
          $('.cart-icon').removeClass('animate__animated animate__pulse');
        }, 1000);
      },
    });
  }

  // ================= WISHLIST MANAGEMENT =================

  /**
   * Add/Remove from wishlist
   */
  $(document).on('click', '.btn-wishlist', function (e) {
    e.preventDefault();
    const button = $(this);

    // Try multiple ways to get product ID
    let productId = button.data('id');
    if (!productId) {
      productId = button.attr('data-id');
    }
    if (!productId) {
      productId = this.getAttribute('data-id');
    }

    if (!productId) {
      console.error('No product ID found for wishlist!');
      showToast('Lỗi!', 'Không tìm thấy ID sản phẩm', 'error');
      return;
    }

    const icon = button.find('i');

    // Toggle heart icon
    if (icon.hasClass('bi-heart')) {
      // Add to wishlist
      $.ajax({
        url: '/product/add-to-favo/' + productId,
        type: 'GET',
        success: function (response) {
          if (response === 'true') {
            icon.removeClass('bi-heart').addClass('bi-heart-fill');
            button.addClass('text-danger wishlist-active');

            // Animation
            button.addClass('wishlist-animation');
            setTimeout(function () {
              button.removeClass('wishlist-animation');
            }, 600);

            showToast(
              'Yêu thích!',
              'Đã thêm vào danh sách yêu thích',
              'success'
            );
          } else {
            showToast(
              'Thông báo',
              'Sản phẩm đã có trong danh sách yêu thích',
              'info'
            );
          }
        },
      });
    } else {
      // Remove from wishlist (client-side toggle)
      icon.removeClass('bi-heart-fill').addClass('bi-heart');
      button.removeClass('text-danger wishlist-active');
      showToast('Đã xóa', 'Đã xóa khỏi danh sách yêu thích', 'info');
    }
  });

  // ================= PRODUCT INTERACTIONS =================

  /**
   * Quick view functionality
   */
  $(document).on('click', '.btn-quick-view, .btn-view', function (e) {
    e.preventDefault();
    const productId = $(this).data('id');

    // Show loading modal
    showQuickViewModal(productId);
  });

  /**
   * Buy now functionality
   */
  $(document).on('click', '.btn-buy-now', function (e) {
    e.preventDefault();
    const productId = $(this).data('id');

    // Add to cart and redirect to checkout
    $.ajax({
      url: '/cart/add/' + productId,
      type: 'GET',
      success: function () {
        window.location.href = '/cart/view';
      },
    });
  });

  /**
   * Compare functionality
   */
  $(document).on('click', '.btn-compare', function (e) {
    e.preventDefault();
    const button = $(this);
    const productId = button.data('id');

    // Toggle compare state
    if (button.hasClass('compare-active')) {
      button.removeClass('compare-active text-success');
      showToast('Đã xóa', 'Đã xóa khỏi danh sách so sánh', 'info');
    } else {
      button.addClass('compare-active text-success');
      showToast('So sánh', 'Đã thêm vào danh sách so sánh', 'success');
    }
  });

  // ================= SEARCH FUNCTIONALITY =================

  /**
   * Enhanced search with suggestions
   */
  $('#searchInput').on('input', function () {
    const query = $(this).val();
    if (query.length >= 2) {
      // Show search suggestions
      showSearchSuggestions(query);
    } else {
      hideSearchSuggestions();
    }
  });

  /**
   * Search form submission
   */
  $('#searchForm').on('submit', function (e) {
    e.preventDefault();
    const keywords = $('#searchInput').val().trim();
    if (keywords) {
      window.location.href =
        '/product/list-by-keywords?keywords=' + encodeURIComponent(keywords);
    }
  });

  // ================= UI ENHANCEMENTS =================

  /**
   * Smooth scroll to top
   */
  $(window).scroll(function () {
    if ($(this).scrollTop() > 300) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  $('.scroll-to-top').click(function () {
    $('html, body').animate({ scrollTop: 0 }, 800);
    return false;
  });

  /**
   * Lazy loading for product images
   */
  if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          img.src = img.dataset.src;
          img.classList.remove('lazy');
          imageObserver.unobserve(img);
        }
      });
    });

    document.querySelectorAll('img[data-src]').forEach(img => {
      imageObserver.observe(img);
    });
  }

  /**
   * Product card hover effects
   */
  $('.product-card, .special-product-card, .simple-product-card').hover(
    function () {
      $(this).find('.product-actions, .quick-actions').addClass('show');
    },
    function () {
      $(this).find('.product-actions, .quick-actions').removeClass('show');
    }
  );

  // ================= UTILITY FUNCTIONS =================

  /**
   * Show toast notification
   */
  function showToast(title, message, type = 'info') {
    const toastId = 'toast-' + Date.now();
    const iconClass =
      {
        success: 'bi-check-circle-fill text-success',
        error: 'bi-x-circle-fill text-danger',
        warning: 'bi-exclamation-triangle-fill text-warning',
        info: 'bi-info-circle-fill text-info',
      }[type] || 'bi-info-circle-fill text-info';

    const toastHtml = `
            <div id="${toastId}" class="toast align-items-center border-0" role="alert">
                <div class="d-flex">
                    <div class="toast-body d-flex align-items-center">
                        <i class="bi ${iconClass} me-2"></i>
                        <div>
                            <strong>${title}</strong><br>
                            <small>${message}</small>
                        </div>
                    </div>
                    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        `;

    // Add to toast container
    if (!$('.toast-container').length) {
      $('body').append(
        '<div class="toast-container position-fixed top-0 end-0 p-3"></div>'
      );
    }

    $('.toast-container').append(toastHtml);

    // Show toast
    const toast = new bootstrap.Toast(document.getElementById(toastId));
    toast.show();

    // Remove after hide
    document
      .getElementById(toastId)
      .addEventListener('hidden.bs.toast', function () {
        $(this).remove();
      });
  }

  /**
   * Show search suggestions
   */
  function showSearchSuggestions(query) {
    // Implementation for search suggestions
    // This would typically make an AJAX call to get suggestions
    console.log('Searching for:', query);
  }

  /**
   * Hide search suggestions
   */
  function hideSearchSuggestions() {
    $('.search-suggestions').hide();
  }

  /**
   * Show quick view modal
   */
  function showQuickViewModal(productId) {
    // Implementation for quick view modal
    // This would load product details in a modal
    console.log('Quick view for product:', productId);
    showToast('Tính năng', 'Xem nhanh sẽ được cập nhật sớm', 'info');
  }

  // ================= INITIALIZATION =================

  /**
   * Initialize tooltips
   */
  const tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  /**
   * Initialize popovers
   */
  const popoverTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="popover"]')
  );
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl);
  });

  /**
   * Auto-hide alerts
   */
  $('.auto-hide-alert').each(function () {
    const alert = $(this);
    setTimeout(function () {
      alert.fadeOut();
    }, 5000);
  });

  console.log('🎉 Modern EStore JavaScript initialized successfully!');
});

// ================= CSS ANIMATIONS =================

// Add CSS for animations
const animationCSS = `
<style>
/* Spinning animation */
.spin {
    animation: spin 1s linear infinite;
}

@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

/* Pulse animation */
.pulse {
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

/* Bounce animation */
.bounce {
    animation: bounce 1s infinite;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-10px); }
    60% { transform: translateY(-5px); }
}

/* Fade in animation */
.fade-in {
    animation: fadeIn 0.5s ease-in;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Slide in animation */
.slide-in {
    animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
    from { transform: translateX(-100%); }
    to { transform: translateX(0); }
}

/* Heart beat animation */
.heartbeat {
    animation: heartbeat 1.5s ease-in-out infinite;
}

@keyframes heartbeat {
    0% { transform: scale(1); }
    14% { transform: scale(1.3); }
    28% { transform: scale(1); }
    42% { transform: scale(1.3); }
    70% { transform: scale(1); }
}

/* Scroll to top button */
.scroll-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: white;
    border: none;
    border-radius: 50%;
    display: none;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 15px rgba(0,123,255,0.3);
    transition: all 0.3s ease;
    z-index: 1000;
}

.scroll-to-top:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(0,123,255,0.4);
    color: white;
}

/* Toast styling */
.toast {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.toast-body {
    padding: 1rem;
}

/* Loading states */
.loading {
    pointer-events: none;
    opacity: 0.7;
}

.loading .product-image {
    filter: blur(1px);
}

/* Wishlist active state */
.wishlist-active {
    background: rgba(220, 53, 69, 0.1) !important;
    border-color: #dc3545 !important;
}

/* Compare active state */
.compare-active {
    background: rgba(40, 167, 69, 0.1) !important;
    border-color: #28a745 !important;
}

/* Search suggestions */
.search-suggestions {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    border: 1px solid #ddd;
    border-top: none;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    z-index: 1000;
    max-height: 300px;
    overflow-y: auto;
}

.search-suggestion-item {
    padding: 10px 15px;
    border-bottom: 1px solid #f0f0f0;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.search-suggestion-item:hover {
    background-color: #f8f9fa;
}

.search-suggestion-item:last-child {
    border-bottom: none;
}

/* Product actions show state */
.product-actions.show,
.quick-actions.show {
    opacity: 1 !important;
    transform: translateX(0) !important;
}

/* Responsive improvements */
@media (max-width: 767.98px) {
    .scroll-to-top {
        bottom: 20px;
        right: 20px;
        width: 45px;
        height: 45px;
    }
    
    .toast-container {
        padding: 1rem !important;
    }
}
</style>
`;

// Inject CSS
$('head').append(animationCSS);

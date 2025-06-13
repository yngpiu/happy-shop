<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Slider Section (Bootstrap 5) -->
<div class="container" style="padding-top: 20px">
  <div
    id="carouselSlider"
    class="carousel slide carousel-fade"
    data-bs-ride="carousel"
    data-bs-interval="4000"
  >
    <!-- Indicators -->
    <div class="carousel-indicators">
      <button
        type="button"
        data-bs-target="#carouselSlider"
        data-bs-slide-to="0"
        class="active"
      ></button>
      <button
        type="button"
        data-bs-target="#carouselSlider"
        data-bs-slide-to="1"
      ></button>
      <button
        type="button"
        data-bs-target="#carouselSlider"
        data-bs-slide-to="2"
      ></button>
      <button
        type="button"
        data-bs-target="#carouselSlider"
        data-bs-slide-to="3"
      ></button>
    </div>

    <!-- Slides -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img
          src="/static/images/slideshow/slide1.jpg"
          class="d-block w-100"
          alt="Slide 1"
          style="height: 400px; object-fit: cover; border-radius: 10px"
        />
        <div class="carousel-caption d-none d-md-block">
          <h5 class="fw-bold">Khuyến Mãi Đặc Biệt</h5>
          <p>Giảm giá lên đến 50% cho tất cả sản phẩm</p>
        </div>
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide2.jpg"
          class="d-block w-100"
          alt="Slide 2"
          style="height: 400px; object-fit: cover; border-radius: 10px"
        />
        <div class="carousel-caption d-none d-md-block">
          <h5 class="fw-bold">Sản Phẩm Mới Nhất</h5>
          <p>Cập nhật những sản phẩm công nghệ mới nhất</p>
        </div>
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide3.jpg"
          class="d-block w-100"
          alt="Slide 3"
          style="height: 400px; object-fit: cover; border-radius: 10px"
        />
        <div class="carousel-caption d-none d-md-block">
          <h5 class="fw-bold">Chất Lượng Đảm Bảo</h5>
          <p>Bảo hành chính hãng, uy tín hàng đầu</p>
        </div>
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide4.jpg"
          class="d-block w-100"
          alt="Slide 4"
          style="height: 400px; object-fit: cover; border-radius: 10px"
        />
        <div class="carousel-caption d-none d-md-block">
          <h5 class="fw-bold">Giao Hàng Toàn Quốc</h5>
          <p>Miễn phí giao hàng cho đơn hàng trên 500k</p>
        </div>
      </div>
    </div>

    <!-- Controls -->
    <button
      class="carousel-control-prev"
      type="button"
      data-bs-target="#carouselSlider"
      data-bs-slide="prev"
    >
      <span class="carousel-control-prev-icon"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button
      class="carousel-control-next"
      type="button"
      data-bs-target="#carouselSlider"
      data-bs-slide="next"
    >
      <span class="carousel-control-next-icon"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
</div>

<!-- Featured Products Section -->
<div class="container my-5">
  <div class="products-section">
    <div class="section-header text-center mb-4">
      <h3 class="section-title">
        <i class="bi bi-star-fill text-warning me-2"></i>
        SẢN PHẨM NỔI BẬT
      </h3>
      <p class="section-subtitle text-muted">
        Những sản phẩm được lựa chọn đặc biệt với ưu đãi hấp dẫn
      </p>
    </div>

    <div class="products-container">
      <jsp:include page="../product/list_special.jsp" />
    </div>

    <div class="text-center mt-4">
      <a
        href="/product/list-by-special/4"
        class="btn btn-lg btn-primary-outline"
      >
        <i class="bi bi-grid-3x3-gap me-2"></i>
        Xem tất cả sản phẩm nổi bật
        <i class="bi bi-arrow-right ms-2"></i>
      </a>
    </div>
  </div>
</div>

<!-- Second Banner -->
<div class="container my-5">
  <div class="rounded-3 shadow overflow-hidden">
    <img
      src="/static/images/banner2.png"
      alt="Banner 2"
      class="img-fluid w-100"
      style="max-height: 150px; object-fit: cover"
    />
  </div>
</div>

<!-- Latest Products Section -->
<div class="container my-5">
  <div class="products-section">
    <div class="section-header text-center mb-4">
      <h3 class="section-title">
        <i class="bi bi-lightning-fill text-warning me-2"></i>
        SẢN PHẨM MỚI NHẤT
      </h3>
      <p class="section-subtitle text-muted">
        Khám phá những sản phẩm mới nhất với công nghệ tiên tiến
      </p>
    </div>

    <div class="products-container">
      <jsp:include page="../product/list-by-new.jsp" />
    </div>

    <div class="text-center mt-4">
      <a href="/product/list-by-new/0" class="btn btn-lg btn-primary-outline">
        <i class="bi bi-grid-3x3-gap me-2"></i>
        Xem tất cả sản phẩm mới
        <i class="bi bi-arrow-right ms-2"></i>
      </a>
    </div>
  </div>
</div>

<!-- Slider JavaScript (Bootstrap 5) -->
<script>
  $(document).ready(function () {
    // Bootstrap 5 carousel initialization
    const carousel = new bootstrap.Carousel('#carouselSlider', {
      interval: 4000,
      ride: 'carousel',
      pause: 'hover',
      wrap: true,
      touch: true,
    });

    // Add smooth scroll effect for carousel captions
    $('#carouselSlider').on('slide.bs.carousel', function (e) {
      // Add fade effect for captions
      $('.carousel-caption').fadeOut(200);
    });

    $('#carouselSlider').on('slid.bs.carousel', function (e) {
      // Fade in new caption
      $(e.relatedTarget).find('.carousel-caption').fadeIn(300);
    });
  });

  // Working cart and wishlist functions for home page
  window.testAddToCart = function (productId) {
    const button = event.target;
    addToCartWorking(productId, button);
    return false;
  };

  window.testWishlist = function (productId) {
    const button = event.target;
    addToWishlistWorking(productId, button);
    return false;
  };

  window.addToCartWorking = function (productId, button) {
    console.log('Adding to cart, Product ID:', productId);

    // Disable button and show loading
    $(button).prop('disabled', true);
    const originalText = $(button).html();
    $(button).html('<i class="bi bi-arrow-repeat spin me-1"></i>Đang thêm...');

    // AJAX call to add to cart
    $.ajax({
      url: '/cart/add/' + productId,
      type: 'GET',
      success: function (response) {
        console.log('Cart add success:', response);

        // Success animation
        $(button).removeClass('btn-primary').addClass('btn-success');
        $(button).html(
          '<i class="bi bi-check-circle me-1"></i>Đã thêm vào giỏ'
        );

        // Show toast notification
        showToast(
          'Thành công!',
          'Sản phẩm đã được thêm vào giỏ hàng',
          'success'
        );

        // Reset button after 2 seconds
        setTimeout(function () {
          $(button).addClass('btn-primary').removeClass('btn-success');
          $(button).html(originalText);
          $(button).prop('disabled', false);
        }, 2000);
      },
      error: function (xhr, status, error) {
        console.log('Cart add error:', xhr, status, error);

        // Error handling
        $(button).removeClass('btn-primary').addClass('btn-danger');
        $(button).html('<i class="bi bi-x-circle me-1"></i>Lỗi');

        showToast('Lỗi!', 'Không thể thêm sản phẩm vào giỏ hàng', 'error');

        // Reset button
        setTimeout(function () {
          $(button).addClass('btn-primary').removeClass('btn-danger');
          $(button).html(originalText);
          $(button).prop('disabled', false);
        }, 2000);
      },
    });
  };

  window.addToWishlistWorking = function (productId, button) {
    console.log('Adding to wishlist, Product ID:', productId);

    const icon = $(button).find('i');

    $.ajax({
      url: '/product/add-to-favo/' + productId,
      type: 'GET',
      success: function (response) {
        console.log('Wishlist success:', response);

        if (response === 'true') {
          // Change icon only, keep button style
          if (icon.length > 0) {
            icon.removeClass('bi-heart').addClass('bi-heart-fill');
            icon.css('color', '#dc3545'); // Red color for filled heart
          }

          // Animation
          $(button).addClass('wishlist-animation');
          setTimeout(function () {
            $(button).removeClass('wishlist-animation');
          }, 600);

          showToast('Yêu thích!', 'Đã thêm vào danh sách yêu thích', 'success');
        } else {
          showToast(
            'Thông báo',
            'Sản phẩm đã có trong danh sách yêu thích',
            'info'
          );
        }
      },
      error: function (xhr, status, error) {
        console.log('Wishlist error:', xhr, status, error);
        showToast('Lỗi!', 'Không thể thêm vào danh sách yêu thích', 'error');
      },
    });
  };

  // Toast notification function (simple version)
  window.showToast = function (title, message, type) {
    const alertClass =
      {
        success: 'alert-success',
        error: 'alert-danger',
        info: 'alert-info',
        warning: 'alert-warning',
      }[type] || 'alert-info';

    const toastHtml = `
      <div class="alert ${alertClass} alert-dismissible fade show position-fixed" 
           style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
        <strong>${title}</strong> ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    `;

    $('body').append(toastHtml);

    // Auto remove after 3 seconds
    setTimeout(function () {
      $('.alert').fadeOut(function () {
        $(this).remove();
      });
    }, 3000);
  };
</script>

<style>
  /* Unified Products Section Styling */
  .products-section {
    padding: 2rem 0;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-radius: 15px;
    margin: 2rem 0;
  }

  .section-header {
    position: relative;
  }

  .section-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 0.5rem;
  }

  .section-subtitle {
    font-size: 1rem;
    max-width: 500px;
    margin: 0 auto;
  }

  .products-container {
    padding: 0 1rem;
  }

  /* View All Button */
  .btn-primary-outline {
    background: linear-gradient(135deg, #007bff, #0056b3);
    border: none;
    color: white;
    font-weight: 600;
    padding: 12px 24px;
    border-radius: 25px;
    transition: all 0.3s ease;
    text-decoration: none;
  }

  .btn-primary-outline:hover {
    background: linear-gradient(135deg, #0056b3, #004085);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3);
    color: white;
    text-decoration: none;
  }

  /* Responsive Design */
  @media (max-width: 767.98px) {
    .products-section {
      padding: 1.5rem 1rem;
    }

    .section-title {
      font-size: 1.5rem;
    }

    .products-container {
      padding: 0 0.5rem;
    }
  }

  @media (max-width: 575.98px) {
    .products-section {
      margin: 1rem 0;
    }
  }
  @font-face {
    font-family: 'icomoon';
    src: url('../fonts/icomoon.eot');
    src: url('../fonts/icomoon.eot?#iefix') format('embedded-opentype'),
      url('../fonts/icomoon.svg#icomoon') format('svg'),
      url('../fonts/icomoon.woff') format('woff'),
      url('../fonts/icomoon.ttf') format('truetype');
    font-weight: normal;
    font-style: normal;
  }

  /* Slider Enhancements (Bootstrap 5) */
  #carouselSlider {
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
  }

  #carouselSlider .carousel-item img {
    transition: transform 0.3s ease;
  }

  #carouselSlider:hover .carousel-item img {
    transform: scale(1.02);
  }

  .carousel-control-prev,
  .carousel-control-next {
    width: 5%;
    opacity: 0.8;
    transition: opacity 0.3s ease;
  }

  .carousel-control-prev:hover,
  .carousel-control-next:hover {
    opacity: 1;
  }

  .carousel-control-prev-icon,
  .carousel-control-next-icon {
    width: 2.5rem;
    height: 2.5rem;
  }

  .carousel-indicators button {
    width: 15px;
    height: 15px;
    border-radius: 50%;
    margin: 0 4px;
    background-color: rgba(255, 255, 255, 0.6);
    border: 2px solid rgba(255, 255, 255, 0.8);
    transition: all 0.3s ease;
  }

  .carousel-indicators button.active {
    background-color: #ffffff;
    border-color: #ffffff;
    transform: scale(1.2);
  }

  .carousel-caption {
    background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
    border-radius: 10px;
    padding: 20px;
    bottom: 20px;
  }

  .carousel-caption h5 {
    font-size: 1.5rem;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  }

  .carousel-caption p {
    font-size: 1rem;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
  }

  /* Needed for a fluid height: */
  html,
  body,
  .container,
  .main {
    height: 100%;
  }

  /* main wrapper */
  .btn-change {
    width: 30px;
    height: 30px;
    position: absolute;
    margin-top: -250px;
    transform: translateY(-100%);
  }

  #next {
    right: 10px;
  }

  #prev {
    left: 10px;
  }

  .imgs {
    height: 100%;
    width: 100%;
  }

  .cbp-contentslider {
    width: 100%;
    height: 100%;
    margin: 1em auto;
    position: relative;
    border: 1px solid rgb(214, 214, 214);
  }

  .cbp-contentslider > ul {
    list-style: none;
    height: 85%;
    width: 100%;
    overflow: hidden;
    position: relative;
    padding: 0;
    margin: 0;
  }

  .cbp-contentslider > ul li {
    position: absolute;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
    background: #fff;
  }

  /* Whithout JS, we use :target */
  .cbp-contentslider > ul li:target {
    z-index: 100;
  }

  .cbp-contentslider nav {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 3.313em;
    z-index: 1000;
    border-top: 1px solid rgb(243, 239, 233);
    overflow: hidden;
  }

  .cbp-contentslider nav button {
    float: left;
    display: block;
    width: 20%;
    height: 100%;
    font-weight: 400;
    letter-spacing: 0.1em;
    overflow: hidden;
    color: #47a3da;
    background: rgb(255, 255, 255);
    outline: none;
    text-align: center;
    line-height: 3;
    position: relative;
    padding-left: 3.125em;
    text-transform: uppercase;
    -webkit-transition: color 0.2s ease-in-out,
      background-color 0.2s ease-in-out;
    -moz-transition: color 0.2s ease-in-out, background-color 0.2s ease-in-out;
    transition: color 0.2s ease-in-out, background-color 0.2s ease-in-out;
  }

  .cbp-contentslider nav button span {
    display: block;
  }

  .cbp-contentslider nav button:last-child {
    border: none;
    box-shadow: 1px 0 #47a3da; /* fills gap caused by rounding */
  }

  .cbp-contentslider nav button:hover {
    text-decoration: none;
    border-bottom: 4px solid #47a3da;
  }

  .cbp-contentslider nav button.rc-active {
    background-color: #47a3da;
    color: #fff;
  }

  /* Iconfont for navigation and headings */
  .cbp-contentslider [class^='icon-']:before,
  .cbp-contentslider [class*=' icon-']:before {
    font-family: 'icomoon';
    font-style: normal;
    text-align: center;
    speak: none;
    font-weight: normal;
    line-height: 2.5;
    font-size: 2em;
    position: absolute;
    left: 10%;
    top: 50%;
    margin: -1.25em 0 0 0;
    height: 2.5em;
    width: 2.5em;
    color: rgba(0, 0, 0, 0.1);
    -webkit-font-smoothing: antialiased;
  }

  /* Media queries */
  @media screen and (max-width: 70em) {
    .cbp-contentslider p {
      font-size: 100%;
    }
  }

  @media screen and (max-width: 67.75em) {
    .cbp-contentslider {
      font-size: 85%;
    }
    .cbp-contentslider nav a[class^='icon-']:before,
    .cbp-contentslider nav a[class*=' icon-']:before {
      left: 50%;
      margin-left: -1.25em;
    }
    .cbp-contentslider nav a span {
      display: none;
    }
  }

  @media screen and (max-width: 43em) {
    .cbp-contentslider h3 {
      font-size: 2em;
    }
    .cbp-contentslider .cbp-content {
      -webkit-column-count: 1;
      -moz-column-count: 1;
      -o-column-count: 1;
      column-count: 1;
    }
    .cbp-contentslider li > div {
      top: 5em;
    }
  }

  @media screen and (max-width: 25em) {
    .cbp-contentslider nav a {
      padding: 0;
    }
    .cbp-contentslider h3[class^='icon-']:before,
    .cbp-contentslider h3[class*=' icon-']:before {
      display: none;
    }
  }
</style>

<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Slider Section -->
<div class="container" style="padding-top: 20px">
  <div
    id="carouselSlider"
    class="carousel slide"
    data-ride="carousel"
    data-interval="4000"
  >
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#carouselSlider" data-slide-to="0" class="active"></li>
      <li data-target="#carouselSlider" data-slide-to="1"></li>
      <li data-target="#carouselSlider" data-slide-to="2"></li>
      <li data-target="#carouselSlider" data-slide-to="3"></li>
    </ol>

    <!-- Slides -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img
          src="/static/images/slideshow/slide1.jpg"
          class="d-block w-100"
          alt="Slide 1"
          style="height: 400px; object-fit: cover"
        />
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide2.jpg"
          class="d-block w-100"
          alt="Slide 2"
          style="height: 400px; object-fit: cover"
        />
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide3.jpg"
          class="d-block w-100"
          alt="Slide 3"
          style="height: 400px; object-fit: cover"
        />
      </div>
      <div class="carousel-item">
        <img
          src="/static/images/slideshow/slide4.jpg"
          class="d-block w-100"
          alt="Slide 4"
          style="height: 400px; object-fit: cover"
        />
      </div>
    </div>

    <!-- Controls -->
    <a
      class="carousel-control-prev"
      href="#carouselSlider"
      role="button"
      data-slide="prev"
    >
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a
      class="carousel-control-next"
      href="#carouselSlider"
      role="button"
      data-slide="next"
    >
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<!-- Banner Section -->
<div class="container" style="margin: 30px auto">
  <img
    src="https://hoanghamobile.com/Uploads/2022/04/21/macbook-air-m1-gdn-hotsale.jpg"
    alt="MacBook Sale Banner"
    class="img-fluid"
    style="width: 100%; border-radius: 8px"
  />
</div>

<!-- Featured Products Section -->
<div class="container">
  <div class="gia-soc" style="margin-top: 30px">
    <div
      style="
        background-color: rgb(206, 18, 18);
        width: 100%;
        height: 65px;
        font-weight: bold;
        padding: 13px;
        border-radius: 8px 8px 0 0;
      "
    >
      <span style="color: #fff; text-align: left; font-size: 26px">
        SẢN PHẨM NỔI BẬT
      </span>
      <span style="color: #fff; float: right; font-size: 16px; padding: 8px">
        <a
          href="/product/list-by-special/4"
          style="color: #fff; text-decoration: none"
        >
          Xem tất cả
        </a>
      </span>
    </div>

    <div style="padding: 20px; background: #f8f9fa; border-radius: 0 0 8px 8px">
      <jsp:include page="../product/list_special.jsp" />
    </div>
  </div>
</div>

<!-- Second Banner -->
<div class="container" style="margin: 30px auto">
  <img
    src="/static/images/banner2.png"
    alt="Banner 2"
    class="img-fluid"
    style="width: 100%; border-radius: 8px"
  />
</div>

<!-- Latest Products Section -->
<div class="container">
  <div class="gia-soc" style="margin-top: 30px">
    <div
      style="
        background-color: rgb(206, 18, 18);
        width: 100%;
        height: 65px;
        font-weight: bold;
        padding: 13px;
        border-radius: 8px 8px 0 0;
      "
    >
      <span style="color: #fff; text-align: left; font-size: 26px">
        SẢN PHẨM MỚI NHẤT
      </span>
      <span style="color: #fff; float: right; font-size: 16px; padding: 8px">
        <a
          href="/product/list-by-new/0"
          style="color: #fff; text-decoration: none"
        >
          Xem tất cả
        </a>
      </span>
    </div>
    <div style="padding: 20px; background: #f8f9fa; border-radius: 0 0 8px 8px">
      <jsp:include page="../product/list-by-new.jsp" />
    </div>
  </div>
</div>

<!-- Slider JavaScript -->
<script>
  $(document).ready(function () {
    // Initialize carousel
    $('#carouselSlider').carousel({
      interval: 4000,
      ride: 'carousel',
    });

    // Add smooth transitions
    $('#carouselSlider').on('slide.bs.carousel', function (e) {
      $(this).find('.carousel-item').removeClass('slideInRight slideInLeft');
      if (e.direction === 'left') {
        $(e.relatedTarget).addClass('slideInRight');
      } else {
        $(e.relatedTarget).addClass('slideInLeft');
      }
    });
  });
</script>

<style>
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

  /* Slider Enhancements */
  #carouselSlider {
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
    background: rgba(0, 0, 0, 0.2);
    border-radius: 0 5px 5px 0;
  }

  .carousel-control-next {
    border-radius: 5px 0 0 5px;
  }

  .carousel-indicators li {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background-color: rgba(255, 255, 255, 0.5);
  }

  .carousel-indicators .active {
    background-color: #fff;
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

<%@ page pageEncoding="utf-8"%>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" href="/static/images/icon/favicon.ico" />

<!-- jQuery 3.6.0 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap 5.3.0 -->
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
  rel="stylesheet"
/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Font Awesome 6.4.0 -->
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
/>

<!-- Bootstrap Icons -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css"
/>

<!-- Google Fonts -->
<link
  href="https://fonts.googleapis.com/css2?family=Nunito:wght@200;300;400;600;700;800;900&display=swap"
  rel="stylesheet"
/>

<!-- jQuery UI -->
<link href="/static/jqueryui/jquery-ui.min.css" rel="stylesheet" />
<script src="/static/jqueryui/jquery-ui.min.js"></script>

<!-- CKEditor -->
<script src="/ckeditor/ckeditor.js"></script>

<!-- Custom CSS -->
<link href="/static/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="/static/css/dac_biet.css" />
<link rel="stylesheet" href="/static/css/tintuc_sk.css" />

<!-- Custom JS -->
<script src="/static/js/index.js"></script>
<script src="/static/js/scoll.js"></script>
<script src="/static/js/estores.js"></script>

<script>
  $(document).ready(function () {
    $('.danh_muc').click(function () {
      $('.list_danh_muc').slideToggle(200);
    });
  });
</script>

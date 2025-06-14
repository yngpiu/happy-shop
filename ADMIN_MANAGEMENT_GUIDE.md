# 📋 Hướng Dẫn Quản Lý Admin - HappyShop

## 📑 Mục Lục

- [1. Quản Lý Loại Sản Phẩm (Category Management)](#1-quản-lý-loại-sản-phẩm-category-management)
- [2. Quản Lý Sản Phẩm (Product Management)](#2-quản-lý-sản-phẩm-product-management)
- [3. Tính Năng Chung](#3-tính-năng-chung)
- [4. Hướng Dẫn Sử Dụng](#4-hướng-dẫn-sử-dụng)

---

## 1. Quản Lý Loại Sản Phẩm (Category Management)

### 🎯 Tổng Quan

Module quản lý loại sản phẩm cho phép admin tạo, chỉnh sửa, xóa và khôi phục các danh mục sản phẩm trong hệ thống.

### 📍 URL Truy Cập

- **Trang chính**: `/admin/category/index`
- **Thùng rác**: `/admin/category/trash`

### 🔧 Các Chức Năng Chính

#### 1.1 Xem Danh Sách Loại Sản Phẩm

- **Endpoint**: `GET /admin/category/index`
- **Mô tả**: Hiển thị tất cả loại sản phẩm đang hoạt động
- **Tính năng**:
  - ✅ Hiển thị danh sách với thông tin: ID, Tên, Số sản phẩm, Ngày tạo
  - ✅ Thống kê tổng quan: Tổng số loại, Đang hoạt động, Đã xóa, Có sản phẩm
  - ✅ Bộ lọc: Tất cả, Đang hoạt động, Đã xóa
  - ✅ Tìm kiếm theo tên
  - ✅ Sắp xếp theo các tiêu chí

#### 1.2 Thêm Loại Sản Phẩm Mới

- **Endpoint**:
  - `GET /admin/category/insert` - Hiển thị form
  - `POST /admin/category/insert` - Xử lý thêm mới
- **Dữ liệu cần thiết**:
  - `name` (String, required): Tên loại sản phẩm
- **Validation**:
  - ❌ Tên không được để trống
  - ❌ Tên không được trùng lặp
- **Kết quả**:
  - ✅ Thành công: Redirect về danh sách với thông báo
  - ❌ Lỗi: Hiển thị thông báo lỗi

#### 1.3 Chỉnh Sửa Loại Sản Phẩm

- **Endpoint**:
  - `GET /admin/category/edit/{id}` - Hiển thị form chỉnh sửa
  - `POST /admin/category/update` - Xử lý cập nhật
- **Dữ liệu có thể chỉnh sửa**:
  - `name` (String): Tên loại sản phẩm
- **Tính năng**:
  - ✅ Hiển thị số lượng sản phẩm thuộc loại này
  - ✅ Giữ nguyên thông tin timestamp
  - ✅ Validation tương tự như thêm mới

#### 1.4 Xóa Mềm (Soft Delete)

- **Endpoint**: `POST /admin/category/delete/{id}`
- **Mô tả**: Chuyển loại sản phẩm vào thùng rác thay vì xóa vĩnh viễn
- **Điều kiện**:
  - ⚠️ Kiểm tra loại sản phẩm có đang được sử dụng không
  - ⚠️ Cảnh báo nếu có sản phẩm thuộc loại này
- **Kết quả**:
  - ✅ Chuyển vào thùng rác
  - ✅ Có thể khôi phục sau này

#### 1.5 Quản Lý Thùng Rác

- **Endpoint**: `GET /admin/category/trash`
- **Tính năng**:
  - 👁️ Xem danh sách loại sản phẩm đã xóa
  - 🔄 Khôi phục từng loại: `POST /admin/category/restore/{id}`
  - 🗑️ Xóa vĩnh viễn: `POST /admin/category/permanent-delete/{id}`
  - 🧹 Dọn sạch thùng rác: `POST /admin/category/empty-trash`

### 📊 Thống Kê Hiển Thị

- **Tổng số loại sản phẩm**: Tất cả loại trong hệ thống
- **Đang hoạt động**: Loại sản phẩm có thể sử dụng
- **Đã xóa**: Loại sản phẩm trong thùng rác
- **Có sản phẩm**: Loại sản phẩm đang chứa sản phẩm

---

## 2. Quản Lý Sản Phẩm (Product Management)

### 🎯 Tổng Quan

Module quản lý sản phẩm là tính năng cốt lõi cho phép admin quản lý toàn bộ catalog sản phẩm của cửa hàng.

### 📍 URL Truy Cập

- **Trang chính**: `/admin/product/index`
- **Thùng rác**: `/admin/product/trash`

### 🔧 Các Chức Năng Chính

#### 2.1 Xem Danh Sách Sản Phẩm

- **Endpoint**: `GET /admin/product/index`
- **Mô tả**: Hiển thị tất cả sản phẩm đang hoạt động
- **Thông tin hiển thị**:
  - 🏷️ ID, Tên sản phẩm, Hình ảnh
  - 💰 Giá gốc, Giá khuyến mãi, % Giảm giá
  - 📦 Số lượng tồn kho, Trạng thái
  - 📂 Loại sản phẩm
  - 📅 Ngày tạo, Ngày cập nhật
  - 📊 Số đơn hàng đã bán

#### 2.2 Thêm Sản Phẩm Mới

- **Endpoint**:
  - `GET /admin/product/insert` - Hiển thị form
  - `POST /admin/product/insert` - Xử lý thêm mới
- **Dữ liệu cần thiết**:
  ```
  - name (String, required): Tên sản phẩm
  - unitPrice (Double, required): Giá gốc
  - discount (Integer, 0-100): Phần trăm giảm giá
  - quantity (Integer, required): Số lượng tồn kho
  - description (Text): Mô tả chi tiết
  - category (Category, required): Loại sản phẩm
  - imageFile (MultipartFile): Hình ảnh sản phẩm
  - available (Boolean): Trạng thái bán
  - special (Boolean): Sản phẩm đặc biệt
  ```
- **Validation**:
  - ❌ Tên sản phẩm không được để trống
  - ❌ Giá phải > 0
  - ❌ Số lượng phải >= 0
  - ❌ Discount phải trong khoảng 0-100
  - ❌ Phải chọn loại sản phẩm

#### 2.3 Chỉnh Sửa Sản Phẩm

- **Endpoint**:
  - `GET /admin/product/edit/{id}` - Hiển thị form chỉnh sửa
  - `POST /admin/product/edit/{id}` - Xử lý cập nhật
- **Tính năng đặc biệt**:
  - 🖼️ Upload hình ảnh mới (giữ ảnh cũ nếu không upload)
  - 📊 Hiển thị số đơn hàng đã bán
  - ⚠️ Cảnh báo khi thay đổi sản phẩm đã có đơn hàng
  - 🔄 Tự động cập nhật timestamp

#### 2.4 Quản Lý Hình Ảnh

- **Upload**: Hỗ trợ các định dạng JPG, PNG, GIF
- **Lưu trữ**: `/static/images/products/`
- **Xử lý**:
  - ✅ Tự động đổi tên file tránh trùng lặp
  - ✅ Validation định dạng và kích thước
  - ✅ Xóa ảnh cũ khi upload ảnh mới
  - ✅ Giữ ảnh mặc định nếu không upload

#### 2.5 Xóa Mềm và Thùng Rác

- **Xóa mềm**: `POST /admin/product/delete/{id}`
  - ⚠️ Kiểm tra sản phẩm có trong đơn hàng chưa hoàn thành
  - ✅ Chuyển vào thùng rác thay vì xóa vĩnh viễn
- **Thùng rác**: `GET /admin/product/trash`
  - 🔄 Khôi phục: `POST /admin/product/restore/{id}`
  - 🗑️ Xóa vĩnh viễn: `POST /admin/product/permanent-delete/{id}`
  - 🧹 Dọn sạch: `POST /admin/product/empty-trash`

### 📊 Thống Kê Sản Phẩm

- **Tổng sản phẩm**: Tất cả sản phẩm trong hệ thống
- **Đang bán**: Sản phẩm available = true
- **Hết hàng**: Sản phẩm quantity = 0
- **Sản phẩm đặc biệt**: Sản phẩm special = true
- **Trong thùng rác**: Sản phẩm đã xóa mềm
- **Tổng giá trị kho**: Tính theo quantity × unitPrice

---

## 3. Tính Năng Chung

### 🔐 Bảo Mật

- **Phân quyền**: Chỉ admin mới truy cập được
- **Session**: Kiểm tra `sessionScope.user.admin = true`
- **CSRF Protection**: Sử dụng Spring Security tokens
- **Input Validation**: Validate tất cả dữ liệu đầu vào

### 🎨 Giao Diện

- **Responsive**: Tương thích mobile, tablet, desktop
- **Bootstrap 5**: UI framework hiện đại
- **Icons**: Bootstrap Icons và Font Awesome
- **Theme**: Dark/Light mode support
- **Notifications**: Toast messages cho feedback

### 📱 Trải Nghiệm Người Dùng

- **Loading States**: Hiển thị trạng thái đang tải
- **Confirmation Dialogs**: Xác nhận trước khi xóa
- **Bulk Actions**: Thao tác hàng loạt
- **Search & Filter**: Tìm kiếm và lọc nhanh
- **Pagination**: Phân trang cho danh sách lớn

### 🔄 Tích Hợp

- **Inventory Management**: Tự động cập nhật tồn kho
- **Order System**: Liên kết với hệ thống đơn hàng
- **Statistics**: Báo cáo và thống kê real-time
- **Audit Trail**: Lưu lại lịch sử thay đổi

---

## 4. Hướng Dẫn Sử Dụng

### 🚀 Bắt Đầu

1. **Đăng nhập** với tài khoản admin
2. **Truy cập Dashboard** từ dropdown tài khoản
3. **Chọn module** cần quản lý từ sidebar

### 📂 Quản Lý Loại Sản Phẩm

```
1. Vào "Quản lý loại sản phẩm"
2. Thêm loại mới:
   - Nhấn "Thêm mới"
   - Nhập tên loại sản phẩm
   - Nhấn "Lưu"
3. Chỉnh sửa:
   - Nhấn icon "Sửa" trên dòng cần chỉnh sửa
   - Cập nhật thông tin
   - Nhấn "Cập nhật"
4. Xóa:
   - Nhấn icon "Xóa"
   - Xác nhận trong dialog
   - Loại sẽ chuyển vào thùng rác
```

### 🛍️ Quản Lý Sản Phẩm

```
1. Vào "Quản lý sản phẩm"
2. Thêm sản phẩm mới:
   - Nhấn "Thêm sản phẩm"
   - Điền đầy đủ thông tin:
     * Tên sản phẩm
     * Giá gốc
     * Giảm giá (nếu có)
     * Số lượng
     * Mô tả
     * Chọn loại sản phẩm
     * Upload hình ảnh
   - Nhấn "Lưu sản phẩm"
3. Chỉnh sửa sản phẩm:
   - Nhấn "Sửa" trên sản phẩm cần chỉnh sửa
   - Cập nhật thông tin cần thiết
   - Upload ảnh mới (nếu cần)
   - Nhấn "Cập nhật"
4. Quản lý tồn kho:
   - Cập nhật số lượng trong form chỉnh sửa
   - Đánh dấu "Hết hàng" nếu quantity = 0
   - Bật/tắt trạng thái "Đang bán"
```

### 🗑️ Quản Lý Thùng Rác

```
1. Vào trang "Thùng rác"
2. Khôi phục item:
   - Nhấn "Khôi phục" trên item cần khôi phục
   - Xác nhận trong dialog
3. Xóa vĩnh viễn:
   - Nhấn "Xóa vĩnh viễn"
   - Xác nhận (không thể hoàn tác)
4. Dọn sạch thùng rác:
   - Nhấn "Dọn sạch thùng rác"
   - Xác nhận xóa tất cả
```

### ⚠️ Lưu Ý Quan Trọng

- **Backup**: Luôn backup dữ liệu trước khi thao tác lớn
- **Kiểm tra**: Xem trước thay đổi trước khi lưu
- **Dependencies**: Cẩn thận khi xóa loại sản phẩm có chứa sản phẩm
- **Images**: Đảm bảo hình ảnh có chất lượng tốt và kích thước phù hợp
- **SEO**: Sử dụng tên sản phẩm và mô tả tối ưu cho SEO

### 🆘 Xử Lý Lỗi Thường Gặp

- **Lỗi upload ảnh**: Kiểm tra định dạng và kích thước file
- **Lỗi validation**: Đảm bảo điền đầy đủ thông tin bắt buộc
- **Lỗi xóa**: Kiểm tra dependencies trước khi xóa
- **Lỗi quyền**: Đảm bảo đăng nhập với tài khoản admin

---

## 📞 Hỗ Trợ

- **Email**: admin@happyshop.vn
- **Hotline**: 0987.654.321
- **Documentation**: Xem thêm tài liệu kỹ thuật
- **Training**: Liên hệ để được đào tạo sử dụng

---

_Tài liệu này được cập nhật thường xuyên. Phiên bản hiện tại: v2.0_

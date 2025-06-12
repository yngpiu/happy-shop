# Hệ thống quản lý người dùng

## Tổng quan

Đã thiết kế thành công hệ thống quản lý người dùng với UI giống hệt quản lý sản phẩm nhưng có các tính năng đặc biệt phù hợp với quản lý user.

## Các tính năng chính

### ✅ Tính năng đã triển khai:

1. **Xem danh sách người dùng** - Hiển thị với bộ lọc và thống kê
2. **Tạo tài khoản người dùng mới** - Form đầy đủ với validation
3. **Chỉnh sửa thông tin người dùng** - Cập nhật mọi thông tin trừ username
4. **Cấm người dùng** - Vô hiệu hóa tài khoản (thay vì xóa)
5. **Mở cấm người dùng** - Kích hoạt lại tài khoản

### ❌ Tính năng không có (theo yêu cầu):

- Xóa người dùng
- Thùng rác
- Xóa vĩnh viễn

## Cấu trúc file đã tạo

### 1. Controller

```
src/main/java/com/happyshop/admin/controller/UserManagerController.java
```

- Controller chính xử lý tất cả request
- Các endpoint: `/admin/user/index`, `/admin/user/insert`, `/admin/user/edit/{id}`, `/admin/user/ban/{id}`, `/admin/user/unban/{id}`
- Xử lý upload avatar, validation, error handling

### 2. Views

```
src/main/webapp/WEB-INF/views/admin/user/
├── index.jsp           # Trang danh sách người dùng
├── insert-new.jsp      # Trang thêm người dùng mới (đổi tên thành insert.jsp)
└── edit-new.jsp        # Trang chỉnh sửa người dùng (đổi tên thành edit.jsp)
```

## Tính năng UI chi tiết

### Trang danh sách (index.jsp)

- **Thống kê**: 5 card hiển thị tổng user, active, admin, regular, banned
- **Bộ lọc**: Có thể lọc theo trạng thái (active/all/banned)
- **2 chế độ xem**: Table view và Card view
- **Hành động**: Sửa, Cấm/Mở cấm cho từng user
- **Tìm kiếm**: Có thể mở rộng thêm tính năng search

### Trang thêm mới (insert.jsp)

- **Form đầy đủ**: Username, password, fullname, email, phone
- **Upload avatar**: Với preview trước khi submit
- **Cài đặt**: Kích hoạt tài khoản, quyền admin
- **Validation**: Client-side và server-side
- **Help panel**: Hướng dẫn và cảnh báo bảo mật

### Trang chỉnh sửa (edit.jsp)

- **Username readonly**: Không cho phép thay đổi
- **Mật khẩu optional**: Để trống nếu không đổi
- **Avatar hiện tại**: Hiển thị ảnh đang dùng
- **Quick actions**: Cấm/mở cấm, reset password nhanh
- **Info panel**: Thông tin chi tiết và hướng dẫn

## Tính năng đặc biệt

### 1. Cơ chế cấm/mở cấm

- Thay vì xóa user, sử dụng field `isBanned` để control
- User bị cấm (`isBanned = true`) không thể đăng nhập nhưng dữ liệu vẫn được bảo toàn
- Có thể mở cấm bất cứ lúc nào bằng cách set `isBanned = false`

### 2. Phân quyền rõ ràng

- **Admin**: Có thể truy cập trang quản trị
- **User thường**: Chỉ có thể sử dụng tính năng mua hàng

### 3. Upload avatar

- Hỗ trợ preview trước khi upload
- Tự động resize và tối ưu
- Fallback về ảnh mặc định nếu lỗi

### 4. Validation toàn diện

- Client-side validation với Bootstrap
- Server-side validation trong controller
- Kiểm tra trùng username
- Validate email format, password length

## Cách sử dụng

### 1. Setup

- Đảm bảo `UserDAO` và `User` entity đã được config đúng
- Upload các view files vào đúng thư mục
- Thêm controller vào package

### 2. Truy cập

- **Danh sách**: `/admin/user/index`
- **Thêm mới**: `/admin/user/insert`
- **Chỉnh sửa**: `/admin/user/edit/{userId}`

### 3. Permissions

- Chỉ admin mới có thể truy cập các trang này
- Cần setup security filter phù hợp

## Responsive Design

- Tương thích mobile và tablet
- UI responsive với Bootstrap 5
- Icons sử dụng Bootstrap Icons
- Dark/Light theme ready

## Security Features

- CSRF protection với Spring Security
- Input validation và sanitization
- Secure file upload
- Password hashing (cần implement ở tầng service)

## Tương lai có thể mở rộng

1. **Bulk actions**: Cấm/mở cấm nhiều user cùng lúc
2. **Advanced search**: Tìm kiếm theo nhiều tiêu chí
3. **User activity log**: Theo dõi hoạt động của user
4. **Role management**: Phân quyền chi tiết hơn
5. **Export/Import**: Xuất danh sách user ra Excel
6. **Email notification**: Thông báo khi tài khoản bị cấm/mở cấm

## Notes

- File `insert-new.jsp` và `edit-new.jsp` cần đổi tên thành `insert.jsp` và `edit.jsp`
- Cần test kỹ integration với existing UserDAO
- Avatar upload path cần config phù hợp với server setup
- Có thể cần adjust CSS cho phù hợp với theme hiện tại của admin panel

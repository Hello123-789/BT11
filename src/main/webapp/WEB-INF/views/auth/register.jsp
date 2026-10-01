<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Đăng Ký Tài Khoản</title>
</head>
<body>
    <div class="row justify-content-center py-4">
        <div class="col-md-6">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-success text-white text-center py-3">
                    <h4 class="mb-0 fw-bold">ĐĂNG KÝ TÀI KHOẢN</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control" placeholder="Nhập tên tài khoản" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ Email</label>
                            <input type="email" name="email" class="form-control" placeholder="Nhập email để nhận mã xác thực" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" placeholder="Nhập họ và tên đầy đủ" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại liên hệ">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 py-2 fw-bold">Tiếp Tục & Nhận Mã OTP</button>
                    </form>

                    <div class="text-center mt-3">
                        <span class="text-muted small">Đã có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

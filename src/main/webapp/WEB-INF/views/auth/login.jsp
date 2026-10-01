<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Đăng Nhập</title>
</head>
<body>
    <div class="row justify-content-center py-4">
        <div class="col-md-5">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0 fw-bold">ĐĂNG NHẬP</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty param.message and param.message == 'active_success'}">
                        <div class="alert alert-success">Kích hoạt tài khoản thành công. Vui lòng đăng nhập.</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required autofocus>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Đăng Nhập</button>
                    </form>

                    <div class="text-center mt-3">
                        <span class="text-muted small">Chưa có tài khoản?</span>
                        <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none">Đăng ký ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

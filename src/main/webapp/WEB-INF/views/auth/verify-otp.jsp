<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Xác Thực OTP</title>
</head>
<body>
    <div class="row justify-content-center py-4">
        <div class="col-md-5">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-warning text-dark text-center py-3">
                    <h4 class="mb-0 fw-bold">XÁC THỰC MÃ OTP</h4>
                </div>
                <div class="card-body p-4">
                    <p class="text-muted text-center small mb-3">Mã xác thực 6 chữ số đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư.</p>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Email</label>
                            <input type="email" name="email" class="form-control" value="${not empty sessionScope.pendingEmail ? sessionScope.pendingEmail : email}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mã xác thực</label>
                            <input type="text" name="otp" class="form-control text-center fs-4 fw-bold" maxlength="6" placeholder="Nhập 6 số OTP" required autofocus>
                        </div>
                        <button type="submit" class="btn btn-warning w-100 py-2 fw-bold">Kích Hoạt Tài Khoản</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

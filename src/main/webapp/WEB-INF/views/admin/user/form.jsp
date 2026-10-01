<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${user == null ? 'Thêm Người Dùng Mới' : 'Cập Nhật Người Dùng'}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-person-fill me-2"></i>${user == null ? 'Thêm Người Dùng Mới' : 'Cập Nhật Người Dùng'}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/users" method="post">
                        <input type="hidden" name="userId" value="${user.userId}"/>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Tên Đăng Nhập</label>
                                <input type="text" name="username" class="form-control" value="${user.username}" required placeholder="Tên tài khoản" ${user != null ? 'readonly' : ''}>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Địa Chỉ Email</label>
                                <input type="email" name="email" class="form-control" value="${user.email}" required placeholder="Email">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Mật Khẩu</label>
                                <input type="password" name="password" class="form-control" value="${user.password}" required placeholder="Mật khẩu">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Họ và Tên</label>
                                <input type="text" name="fullname" class="form-control" value="${user.fullname}" required placeholder="Họ và tên">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số Điện Thoại</label>
                                <input type="text" name="phone" class="form-control" value="${user.phone}" placeholder="Số điện thoại">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Ảnh Đại Diện</label>
                                <input type="text" name="images" class="form-control" value="${user.images}" placeholder="Đường dẫn ảnh">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Vai Trò</label>
                                <select name="roleId" class="form-select" required>
                                    <c:forEach var="r" items="${roles}">
                                        <option value="${r.roleId}" ${user.role.roleId == r.roleId ? 'selected' : ''}>${r.roleName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Cửa Hàng Liên Kết</label>
                                <select name="sellerId" class="form-select">
                                    <option value="0">Không liên kết</option>
                                    <c:forEach var="s" items="${sellers}">
                                        <option value="${s.sellerId}" ${user.seller.sellerId == s.sellerId ? 'selected' : ''}>${s.sellername}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Trạng Thái</label>
                                <select name="status" class="form-select">
                                    <option value="1" ${user.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                    <option value="0" ${user.status == 0 ? 'selected' : ''}>Chưa kích hoạt</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="bi bi-save me-1"></i>${user == null ? 'Lưu Người Dùng' : 'Lưu Thay Đổi'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quản Lý Người Dùng</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="text-dark fw-bold mb-0"><i class="bi bi-people-fill text-warning me-2"></i>Quản Lý Người Dùng</h3>
            <small class="text-muted">Danh sách tài khoản trong hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-success fw-bold shadow-sm">
            <i class="bi bi-person-plus-fill me-1"></i>+ Thêm Người Dùng
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 50px;" class="text-center">STT</th>
                        <th style="width: 70px;" class="text-center">Ảnh</th>
                        <th>Tên Đăng Nhập</th>
                        <th>Họ và Tên</th>
                        <th>Email</th>
                        <th>Số Điện Thoại</th>
                        <th>Vai Trò</th>
                        <th>Cửa Hàng</th>
                        <th style="width: 130px;" class="text-center">Trạng Thái</th>
                        <th style="width: 150px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}">
                        <tr>
                            <td class="text-center fw-bold">${u.userId}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${not empty u.images}">
                                        <img src="${u.images.startsWith('http') ? u.images : pageContext.request.contextPath.concat('/').concat(u.images)}" 
                                             width="45" height="45" class="rounded-circle border shadow-sm" style="object-fit: cover;"/>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-circle fs-3 text-secondary"></i>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="fw-bold text-primary">${u.username}</td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td>
                                <span class="badge ${u.role.roleName == 'ADMIN' ? 'bg-danger' : (u.role.roleName == 'SELLER' ? 'bg-warning text-dark' : 'bg-primary')}">
                                    ${u.role.roleName}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty u.seller}">
                                        <span class="badge bg-info text-dark">${u.seller.sellername}</span>
                                    </c:when>
                                    <c:otherwise><span class="text-muted small">Không</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${u.status == 1}"><span class="badge bg-success px-2 py-1">Hoạt động</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary px-2 py-1">Chưa kích hoạt</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.userId}" class="btn btn-sm btn-primary me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.userId}" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr><td colspan="10" class="text-center text-muted py-4">Chưa có người dùng nào</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</body>
</html>

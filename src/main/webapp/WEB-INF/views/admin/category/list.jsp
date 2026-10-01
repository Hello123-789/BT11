<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Quản Lý Danh Mục</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="text-dark fw-bold mb-0"><i class="bi bi-tags-fill text-warning me-2"></i>Quản Lý Danh Mục</h3>
            <small class="text-muted">Danh sách các nhóm sản phẩm</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success fw-bold shadow-sm">
            <i class="bi bi-plus-circle me-1"></i>+ Thêm Danh Mục
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 80px;" class="text-center">STT</th>
                        <th>Tên Danh Mục</th>
                        <th style="width: 120px;" class="text-center">Hình Ảnh</th>
                        <th style="width: 140px;" class="text-center">Trạng Thái</th>
                        <th style="width: 160px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${categoryList}">
                        <tr>
                            <td class="text-center fw-bold">${c.categoryId}</td>
                            <td class="fw-semibold text-primary">${c.categoryName}</td>
                            <td class="text-center">
                                <img src="${c.images.startsWith('http') ? c.images : pageContext.request.contextPath.concat('/').concat(c.images)}" 
                                     width="55" height="55" class="rounded border shadow-sm" style="object-fit: contain; background: #fff;" alt="${c.categoryName}"/>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${c.status == 1}"><span class="badge bg-success px-3 py-2">Hoạt động</span></c:when>
                                    <c:otherwise><span class="badge bg-danger px-3 py-2">Khóa</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${c.categoryId}" class="btn btn-sm btn-primary me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${c.categoryId}" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categoryList}">
                        <tr><td colspan="5" class="text-center text-muted py-4">Chưa có danh mục nào</td></tr>
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
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</body>
</html>

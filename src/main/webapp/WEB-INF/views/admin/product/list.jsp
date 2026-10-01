<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Quản Lý Sản Phẩm</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="text-dark fw-bold mb-0"><i class="bi bi-box-seam text-warning me-2"></i>Quản Lý Sản Phẩm</h3>
            <small class="text-muted">Danh sách toàn bộ sản phẩm trong hệ thống</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-success fw-bold shadow-sm">
            <i class="bi bi-plus-circle me-1"></i>+ Thêm Sản Phẩm
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 50px;" class="text-center">STT</th>
                        <th style="width: 75px;" class="text-center">Hình</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Mã Sản Phẩm</th>
                        <th>Danh Mục</th>
                        <th>Thương Hiệu</th>
                        <th>Giá Bán</th>
                        <th>Số Lượng</th>
                        <th style="width: 150px;" class="text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${productList}">
                        <tr>
                            <td class="text-center fw-bold">${p.productId}</td>
                            <td class="text-center">
                                <img src="${p.images.startsWith('http') ? p.images : pageContext.request.contextPath.concat('/').concat(p.images)}" 
                                     width="55" height="55" class="rounded border shadow-sm" style="object-fit: contain; background: #fff;" alt="${p.productName}"/>
                            </td>
                            <td class="fw-bold text-primary">${p.productName}</td>
                            <td><span class="badge bg-dark">${p.productCode}</span></td>
                            <td><span class="badge bg-secondary">${p.category.categoryName}</span></td>
                            <td><span class="badge bg-info text-dark">${p.seller.sellername}</span></td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</td>
                            <td><strong>${p.amount}</strong></td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.productId}" class="btn btn-sm btn-primary me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${p.productId}" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty productList}">
                        <tr><td colspan="9" class="text-center text-muted py-4">Chưa có sản phẩm nào trong kho</td></tr>
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
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</body>
</html>

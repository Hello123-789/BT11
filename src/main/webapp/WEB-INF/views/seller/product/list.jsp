<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Kênh Người Bán</title>
</head>
<body>
    <!-- Header của Kênh Người Bán -->
    <div class="card shadow-sm border-0 rounded-3 p-4 mb-4 bg-white">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div class="d-flex align-items-center">
                <img src="${sellerInfo.images.startsWith('http') ? sellerInfo.images : pageContext.request.contextPath.concat('/').concat(sellerInfo.images)}" 
                     alt="${sellerInfo.sellername}" class="rounded-circle me-3 border shadow-sm" width="55" height="55" style="object-fit: cover;">
                <div>
                    <h4 class="fw-bold text-dark mb-0">
                        <i class="bi bi-shop text-warning me-2"></i>${sellerInfo.sellername}
                    </h4>
                    <small class="text-muted">Tổng số sản phẩm trong cửa hàng: <strong class="text-success">${totalItems}</strong></small>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/seller/product/add" class="btn btn-success fw-bold shadow-sm">
                <i class="bi bi-plus-circle me-1"></i>+ Đăng Sản Phẩm Mới
            </a>
        </div>

        <hr class="my-3">

        <!-- Form tìm kiếm -->
        <form action="${pageContext.request.contextPath}/seller/products" method="get" class="row g-2 align-items-center">
            <div class="col-md-6">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm theo tên sản phẩm..." value="${keyword}">
                    <button class="btn btn-warning" type="submit"><i class="bi bi-search"></i> Tìm kiếm</button>
                </div>
            </div>
            <div class="col-md-4">
                <select name="categoryId" class="form-select" onchange="this.form.submit()">
                    <option value="0">Tất cả danh mục</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.categoryId}" ${selectedCategory == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-outline-secondary w-100"><i class="bi bi-arrow-clockwise"></i> Đặt lại</a>
            </div>
        </form>
    </div>

    <!-- Bảng danh sách sản phẩm -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 60px;" class="text-center">STT</th>
                        <th style="width: 80px;" class="text-center">Hình Ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Mã Sản Phẩm</th>
                        <th>Danh Mục</th>
                        <th>Giá Bán</th>
                        <th>Số Lượng</th>
                        <th>Tồn Kho</th>
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
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</td>
                            <td><strong>${p.amount}</strong></td>
                            <td>${p.stock}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/seller/product/edit?id=${p.productId}" class="btn btn-sm btn-primary me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/seller/product/delete?id=${p.productId}" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty productList}">
                        <tr><td colspan="9" class="text-center text-muted py-4">Không có sản phẩm nào phù hợp</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/seller/products?page=${currentPage - 1}&keyword=${keyword}&categoryId=${selectedCategory}">«</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/seller/products?page=${i}&keyword=${keyword}&categoryId=${selectedCategory}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/seller/products?page=${currentPage + 1}&keyword=${keyword}&categoryId=${selectedCategory}">»</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>

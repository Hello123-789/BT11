<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Sản Phẩm Cầu Lông</title>
</head>
<body>
    <!-- Tiêu đề & Thanh tìm kiếm / bộ lọc -->
    <div class="card shadow-sm border-0 rounded-3 p-4 mb-4 bg-white">
        <div class="row align-items-center g-3">
            <div class="col-md-4">
                <h4 class="fw-bold text-dark mb-0">
                    <i class="bi bi-grid-fill text-warning me-2"></i>Danh Sách Sản Phẩm
                </h4>
                <small class="text-muted">Tìm thấy <strong class="text-primary">${totalItems}</strong> sản phẩm</small>
            </div>

            <div class="col-md-8">
                <form action="${pageContext.request.contextPath}/products" method="get" class="row g-2">
                    <div class="col-md-5">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" placeholder="Tìm tên sản phẩm, mã..." value="${keyword}">
                            <button class="btn btn-warning" type="submit"><i class="bi bi-search"></i></button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select name="categoryId" class="form-select" onchange="this.form.submit()">
                            <option value="0">Tất cả danh mục</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.categoryId}" ${selectedCategory == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="sellerId" class="form-select" onchange="this.form.submit()">
                            <option value="0">Tất cả thương hiệu</option>
                            <c:forEach var="s" items="${sellers}">
                                <option value="${s.sellerId}" ${selectedSeller == s.sellerId ? 'selected' : ''}>${s.sellername}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-1">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary w-100" title="Đặt lại bộ lọc"><i class="bi bi-arrow-clockwise"></i></a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="row g-4 mb-4">
        <c:forEach var="p" items="${productList}">
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                    <div class="bg-white p-3 text-center position-relative border-bottom">
                        <img src="${p.images.startsWith('http') ? p.images : pageContext.request.contextPath.concat('/').concat(p.images)}" 
                             class="product-img" alt="${p.productName}">
                        <span class="position-absolute top-0 end-0 m-2 badge bg-danger">Chính hãng</span>
                    </div>
                    <div class="card-body p-3 d-flex flex-column">
                        <span class="badge bg-secondary mb-2 align-self-start">${p.category.categoryName}</span>
                        <h6 class="card-title fw-bold mb-1">
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-dark text-decoration-none text-truncate d-block" title="${p.productName}">
                                ${p.productName}
                            </a>
                        </h6>
                        <p class="card-text mb-1 small text-muted">
                            <i class="bi bi-shop me-1 text-warning"></i>${p.seller.sellername}
                        </p>
                        <p class="card-text mb-2 small text-secondary">
                            Mã: ${p.productCode} | Có sẵn: ${p.amount} cây
                        </p>
                        <div class="mt-auto pt-2 border-top">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="price text-danger fw-bold fs-5">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###"/> ₫
                                </div>
                                <small class="text-muted">Kho: <strong class="text-success">${p.stock}</strong></small>
                            </div>
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-outline-secondary btn-sm flex-fill fw-bold">
                                    <i class="bi bi-eye me-1"></i>Chi Tiết
                                </a>
                                <c:choose>
                                    <c:when test="${p.stock > 0}">
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="flex-fill">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="id" value="${p.productId}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="btn btn-warning btn-sm w-100 fw-bold text-dark" title="Thêm vào giỏ hàng">
                                                <i class="bi bi-cart-plus me-1"></i>Thêm Giỏ
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary btn-sm flex-fill disabled" disabled>Hết hàng</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty productList}">
            <div class="col-12 text-center py-5">
                <i class="bi bi-search fs-1 text-muted"></i>
                <h5 class="text-muted mt-2">Không tìm thấy sản phẩm phù hợp</h5>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-2">Xem Tất Cả Sản Phẩm</a>
            </div>
        </c:if>
    </div>

    <!-- Phân trang -->
    <c:if test="${totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/products?page=${currentPage - 1}&keyword=${keyword}&categoryId=${selectedCategory}&sellerId=${selectedSeller}">«</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/products?page=${i}&keyword=${keyword}&categoryId=${selectedCategory}&sellerId=${selectedSeller}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/products?page=${currentPage + 1}&keyword=${keyword}&categoryId=${selectedCategory}&sellerId=${selectedSeller}">»</a>
                </li>
            </ul>
        </nav>
    </c:if>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Sản Phẩm Theo Thương Hiệu</title>
</head>
<body>
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h3 class="text-dark fw-bold mb-0">
            <i class="bi bi-shop text-warning me-2"></i>Sản Phẩm Theo Thương Hiệu
        </h3>
        <span class="badge bg-success px-3 py-2">Chính Hãng 100%</span>
    </div>

    <c:forEach var="entry" items="${sellerProductMap}">
        <div class="card mb-4 shadow-sm border-0">
            <!-- Header Seller -->
            <div class="card-header bg-white border-bottom d-flex align-items-center py-3">
                <img src="${entry.key.images.startsWith('http') ? entry.key.images : pageContext.request.contextPath.concat('/').concat(entry.key.images)}" 
                     alt="${entry.key.sellername}" class="rounded-circle me-3 border shadow-sm" width="55" height="55" style="object-fit: cover;">
                <div>
                    <h5 class="mb-0 text-primary fw-bold">
                        ${entry.key.sellername}
                    </h5>
                    <small class="text-muted">Nhà phân phối ủy quyền</small>
                </div>
            </div>

            <!-- Content Products -->
            <div class="card-body bg-light">
                <div class="row g-3">
                    <c:forEach var="p" items="${entry.value}">
                        <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
                                <div class="bg-white p-3 text-center position-relative">
                                    <img src="${p.images.startsWith('http') ? p.images : pageContext.request.contextPath.concat('/').concat(p.images)}" 
                                         class="product-img" alt="${p.productName}">
                                    <span class="position-absolute top-0 end-0 m-2 badge bg-danger">Chính hãng</span>
                                </div>
                                <div class="card-body p-3 d-flex flex-column">
                                    <h6 class="card-title fw-bold mb-1">
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-dark text-decoration-none text-truncate d-block" title="${p.productName}">
                                            ${p.productName}
                                        </a>
                                    </h6>
                                    <p class="card-text mb-1 small text-muted">Mã: ${p.productCode}</p>
                                    <p class="card-text mb-1 small text-muted">Danh mục: <span class="badge bg-secondary">${p.category.categoryName}</span></p>
                                    <div class="mt-auto pt-2">
                                        <div class="price mb-1">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                                        </div>
                                        <p class="card-text mb-2 small text-secondary">Số lượng: ${p.amount} cây</p>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-outline-primary w-100 fw-bold">
                                            <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty entry.value}">
                        <div class="col-12 text-center text-muted py-4">
                            Cửa hàng hiện chưa có sản phẩm nào
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</body>
</html>

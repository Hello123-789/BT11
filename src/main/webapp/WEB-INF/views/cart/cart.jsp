<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb & Header -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products" class="text-decoration-none">Sản Phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ Hàng</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-cart3 text-warning me-2"></i>Giỏ Hàng Của Bạn
            </h3>
            <span class="badge bg-primary px-3 py-2 fs-6 rounded-pill">
                ${sessionScope.cartTotalQty != null ? sessionScope.cartTotalQty : 0} sản phẩm
            </span>
        </div>

        <!-- Thông báo Flash Messages -->
        <c:if test="${not empty sessionScope.cartSuccess}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.cartSuccess}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="cartSuccess" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.cartWarning}">
            <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.cartWarning}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="cartWarning" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.cartError}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-x-circle-fill me-2"></i>${sessionScope.cartError}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="cartError" scope="session" />
        </c:if>

        <c:choose>
            <%-- GIỎ HÀNG TRỐNG --%>
            <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
                <div class="card shadow-sm border-0 rounded-3 text-center p-5 bg-white my-4">
                    <div class="mb-3 text-muted">
                        <i class="bi bi-cart-x display-1 text-secondary opacity-50"></i>
                    </div>
                    <h4 class="fw-bold text-dark">Giỏ hàng của bạn đang trống</h4>
                    <p class="text-muted col-md-6 mx-auto mb-4">
                        Hãy dạo quanh cửa hàng và chọn những cây vợt, đôi giày hoặc phụ kiện cầu lông chính hãng ưng ý nhất nhé!
                    </p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-warning px-4 py-2 fw-bold shadow-sm text-dark">
                            <i class="bi bi-bag-plus me-1"></i>Khám Phá Sản Phẩm Ngay
                        </a>
                        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-primary px-4 py-2 fw-bold">
                            <i class="bi bi-clock-history me-1"></i>Xem Đơn Hàng Của Tôi
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- CÓ SẢN PHẨM TRONG GIỎ HÀNG --%>
            <c:otherwise>
                <div class="row g-4">
                    <!-- Bảng danh sách sản phẩm trong giỏ -->
                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0 rounded-3 overflow-hidden mb-3">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" style="width: 42%;">Sản Phẩm</th>
                                            <th scope="col" class="text-center" style="width: 18%;">Đơn Giá</th>
                                            <th scope="col" class="text-center" style="width: 22%;">Số Lượng</th>
                                            <th scope="col" class="text-end" style="width: 18%;">Thành Tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${sessionScope.cart}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${item.product.images.startsWith('http')}">
                                                                <img src="${item.product.images}" alt="${item.product.productName}" 
                                                                     class="rounded border me-3" style="width: 65px; height: 65px; object-fit: contain;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/${item.product.images}" alt="${item.product.productName}" 
                                                                     class="rounded border me-3" style="width: 65px; height: 65px; object-fit: contain;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${item.product.productId}" 
                                                               class="fw-bold text-dark text-decoration-none d-block mb-1">
                                                                ${item.product.productName}
                                                            </a>
                                                            <span class="badge bg-secondary me-1" style="font-size: 11px;">${item.product.category.categoryName}</span>
                                                            <span class="text-muted small"><i class="bi bi-shop me-1 text-warning"></i>${item.product.seller.sellername}</span>
                                                            <div class="mt-1">
                                                                <small class="text-muted">
                                                                    Kho: <strong class="text-success">${item.product.stock}</strong> sản phẩm
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center fw-bold text-dark">
                                                    <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> ₫
                                                </td>
                                                <td class="text-center">
                                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline-flex align-items-center justify-content-center">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${item.product.productId}">
                                                        
                                                        <div class="input-group input-group-sm" style="max-width: 130px;">
                                                            <button class="btn btn-outline-secondary" type="button" 
                                                                    onclick="this.parentNode.querySelector('input[type=number]').stepDown(); this.form.submit();">
                                                                <i class="bi bi-dash"></i>
                                                            </button>
                                                            <input type="number" name="quantity" class="form-control text-center px-1" 
                                                                   value="${item.quantity}" min="1" max="${item.product.stock}" 
                                                                   onchange="this.form.submit()" title="Số lượng tồn tối đa: ${item.product.stock}">
                                                            <button class="btn btn-outline-secondary" type="button" 
                                                                    onclick="if(parseInt(this.parentNode.querySelector('input[type=number]').value) < ${item.product.stock}) { this.parentNode.querySelector('input[type=number]').stepUp(); this.form.submit(); } else { alert('Số lượng đã đạt giới hạn tồn kho (${item.product.stock} sản phẩm)!'); }">
                                                                <i class="bi bi-plus"></i>
                                                            </button>
                                                        </div>
                                                    </form>
                                                    <div class="mt-1">
                                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="id" value="${item.product.productId}">
                                                            <button type="submit" class="btn btn-link text-danger p-0 text-decoration-none" style="font-size: 12px;" 
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')">
                                                                <i class="bi bi-trash3 me-1"></i>Xóa
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                                <td class="text-end fw-bold text-danger fs-6">
                                                    <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> ₫
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Các nút thao tác thêm -->
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark">
                                <i class="bi bi-arrow-left me-1"></i>Tiếp Tục Chọn Hàng
                            </a>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="d-inline">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                    <i class="bi bi-trash me-1"></i>Xóa Toàn Bộ Giỏ
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Cột tóm tắt đơn hàng & nút thanh toán COD -->
                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 rounded-3 mb-3 bg-white">
                            <div class="card-header bg-white border-bottom py-3">
                                <h5 class="fw-bold mb-0 text-dark">
                                    <i class="bi bi-receipt text-warning me-2"></i>Tóm Tắt Đơn Hàng
                                </h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tổng số lượng:</span>
                                    <span class="fw-bold">${sessionScope.cartTotalQty != null ? sessionScope.cartTotalQty : 0} món</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tạm tính:</span>
                                    <span class="fw-bold"><fmt:formatNumber value="${cartTotal}" pattern="#,###"/> ₫</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Phí giao hàng:</span>
                                    <span class="text-success fw-bold">Miễn phí (Toàn quốc)</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Phương thức:</span>
                                    <span class="badge bg-warning text-dark fw-bold">Thanh toán khi nhận hàng (COD)</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <span class="fs-5 fw-bold text-dark">Tổng cộng:</span>
                                    <span class="fs-4 fw-bold text-danger">
                                        <fmt:formatNumber value="${cartTotal}" pattern="#,###"/> ₫
                                    </span>
                                </div>

                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-warning btn-lg w-100 fw-bold shadow-sm py-3 text-dark">
                                    <i class="bi bi-cash-coin me-2"></i>Tiến Hành Thanh Toán COD
                                </a>
                            </div>
                        </div>

                        <!-- Banner hỗ trợ & bảo đảm -->
                        <div class="card shadow-sm border-0 rounded-3 bg-light p-3">
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-shield-check text-success fs-4 me-2"></i>
                                <span class="small fw-bold">Cam kết chính hãng 100%</span>
                            </div>
                            <div class="d-flex align-items-center mb-2">
                                <i class="bi bi-truck text-primary fs-4 me-2"></i>
                                <span class="small fw-bold">Giao hàng COD tận nơi toàn quốc</span>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="bi bi-box2-heart text-danger fs-4 me-2"></i>
                                <span class="small fw-bold">Kiểm tra hàng trước khi trả tiền</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

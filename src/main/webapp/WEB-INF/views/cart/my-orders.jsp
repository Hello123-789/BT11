<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Đơn Hàng Của Tôi</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ Hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Đơn Hàng Của Tôi</li>
            </ol>
        </nav>

        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="bi bi-clock-history text-warning me-2"></i>Lịch Sử Đơn Hàng Của Tôi
                </h3>
                <small class="text-muted">Danh sách các đơn hàng bạn đã đặt thành công tại Badminton Shop</small>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-bag-plus me-1"></i>Tiếp Tục Mua Sắm
            </a>
        </div>

        <c:choose>
            <%-- CHƯA CÓ ĐƠN HÀNG --%>
            <c:when test="${empty orders}">
                <div class="card shadow-sm border-0 rounded-3 text-center p-5 bg-white my-4">
                    <div class="mb-3 text-muted">
                        <i class="bi bi-inbox display-1 text-secondary opacity-50"></i>
                    </div>
                    <h4 class="fw-bold text-dark">Bạn chưa có đơn hàng nào</h4>
                    <p class="text-muted col-md-6 mx-auto mb-4">
                        Các đơn hàng bạn đặt sẽ được lưu trữ và hiển thị chi tiết tại đây để bạn dễ dàng theo dõi quá trình giao hàng COD.
                    </p>
                    <div>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-warning px-4 py-2 fw-bold shadow-sm text-dark">
                            <i class="bi bi-bag-plus me-1"></i>Khám Phá Sản Phẩm Ngay
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- DANH SÁCH ĐƠN HÀNG --%>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="order" items="${orders}">
                        <div class="col-12">
                            <div class="card shadow-sm border-0 rounded-3 overflow-hidden bg-white">
                                <!-- Header đơn hàng -->
                                <div class="card-header bg-light border-bottom d-flex flex-wrap justify-content-between align-items-center py-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="fs-6 fw-bold text-dark">
                                            Mã đơn: <span class="text-primary">#DH${order.cartId}</span>
                                        </span>
                                        <span class="text-muted small">
                                            <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center gap-2 mt-2 mt-sm-0">
                                        <span class="badge bg-success">
                                            <i class="bi bi-cash me-1"></i>${order.paymentMethod}
                                        </span>
                                        <c:choose>
                                            <c:when test="${order.status == 1}">
                                                <span class="badge bg-warning text-dark">
                                                    <i class="bi bi-hourglass-split me-1"></i>Chờ xác nhận & Giao COD
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="badge bg-info text-dark">
                                                    <i class="bi bi-truck me-1"></i>Đang giao hàng
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="badge bg-primary">
                                                    <i class="bi bi-check2-all me-1"></i>Đã giao thành công
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Đã đóng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Body: Chi tiết nhận hàng & sản phẩm -->
                                <div class="card-body p-4">
                                    <div class="row g-3 mb-3">
                                        <div class="col-md-7">
                                            <h6 class="small text-muted text-uppercase fw-bold mb-2">Địa chỉ nhận hàng</h6>
                                            <p class="mb-1"><strong>Người nhận:</strong> ${order.receiverName} - <span class="text-primary">${order.receiverPhone}</span></p>
                                            <p class="mb-1 text-secondary"><strong>Địa chỉ:</strong> ${order.address}</p>
                                            <c:if test="${not empty order.note}">
                                                <p class="mb-0 text-muted small"><em>Ghi chú: "${order.note}"</em></p>
                                            </c:if>
                                        </div>
                                        <div class="col-md-5 text-md-end">
                                            <h6 class="small text-muted text-uppercase fw-bold mb-2">Tổng thanh toán COD</h6>
                                            <div class="fs-4 fw-bold text-danger mb-2">
                                                <fmt:formatNumber value="${order.totalMoney}" pattern="#,###"/> ₫
                                            </div>
                                            <a href="${pageContext.request.contextPath}/order-success?orderId=${order.cartId}" class="btn btn-outline-secondary btn-sm">
                                                <i class="bi bi-receipt me-1"></i>Xem Hóa Đơn Chi Tiết
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Danh sách các sản phẩm trong đơn -->
                                    <div class="border rounded-2 p-3 bg-light">
                                        <div class="row g-2">
                                            <c:forEach var="item" items="${orderItemsMap[order.cartId]}">
                                                <div class="col-md-6 col-lg-4">
                                                    <div class="d-flex align-items-center bg-white p-2 rounded border">
                                                        <c:choose>
                                                            <c:when test="${item.product.images.startsWith('http')}">
                                                                <img src="${item.product.images}" alt="${item.product.productName}" 
                                                                     class="rounded me-2 border" style="width: 45px; height: 45px; object-fit: contain;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/${item.product.images}" alt="${item.product.productName}" 
                                                                     class="rounded me-2 border" style="width: 45px; height: 45px; object-fit: contain;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div class="text-truncate">
                                                            <strong class="d-block small text-truncate" title="${item.product.productName}">
                                                                ${item.product.productName}
                                                            </strong>
                                                            <small class="text-muted">${item.quantity} x <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> ₫</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Đặt Hàng Thành Công</title>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <!-- Thông báo thành công -->
                <div class="card shadow-sm border-0 rounded-4 text-center p-5 mb-4 bg-white">
                    <div class="mb-3">
                        <i class="bi bi-check-circle-fill text-success display-2"></i>
                    </div>
                    <h2 class="fw-bold text-dark mb-2">Đặt Hàng Thành Công!</h2>
                    <p class="text-muted fs-6 col-md-9 mx-auto mb-4">
                        Cảm ơn bạn đã tin tưởng và mua sắm dụng cụ cầu lông tại <strong>Badminton Shop</strong>. Đơn hàng của bạn đã được ghi nhận vào hệ thống và đang được chuẩn bị để giao tận tay bạn.
                    </p>
                    <div class="d-inline-flex justify-content-center gap-2">
                        <span class="badge bg-light text-dark border px-3 py-2 fs-6">
                            Mã Đơn Hàng: <strong class="text-primary">#DH${order.cartId}</strong>
                        </span>
                        <span class="badge bg-success px-3 py-2 fs-6">
                            Phương thức: ${order.paymentMethod} (Tiền mặt khi nhận)
                        </span>
                    </div>
                </div>

                <!-- Chi tiết đơn hàng -->
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4 bg-white">
                    <div class="card-header bg-white border-bottom py-3">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-receipt-cutoff text-warning me-2"></i>Thông Tin Đơn Hàng #DH${order.cartId}
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <h6 class="text-muted text-uppercase small fw-bold">Thông tin người nhận</h6>
                                <p class="mb-1 fw-bold text-dark"><i class="bi bi-person me-2 text-primary"></i>${order.receiverName}</p>
                                <p class="mb-1"><i class="bi bi-telephone me-2 text-primary"></i>${order.receiverPhone}</p>
                                <p class="mb-0"><i class="bi bi-geo-alt me-2 text-primary"></i>${order.address}</p>
                            </div>
                            <div class="col-md-6 border-start-md">
                                <h6 class="text-muted text-uppercase small fw-bold">Thông tin đơn hàng</h6>
                                <p class="mb-1">
                                    <span class="text-muted">Thời gian đặt:</span> 
                                    <strong><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm:ss"/></strong>
                                </p>
                                <p class="mb-1">
                                    <span class="text-muted">Trạng thái:</span> 
                                    <span class="badge bg-warning text-dark"><i class="bi bi-hourglass-split me-1"></i>Chờ xác nhận & Đóng gói</span>
                                </p>
                                <c:if test="${not empty order.note}">
                                    <p class="mb-0 text-muted small">
                                        <em>Ghi chú: "${order.note}"</em>
                                    </p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Danh sách sản phẩm trong đơn -->
                        <h6 class="text-muted text-uppercase small fw-bold mb-3">Danh sách sản phẩm đã đặt</h6>
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Sản Phẩm</th>
                                        <th class="text-center" style="width: 20%;">Đơn Giá</th>
                                        <th class="text-center" style="width: 15%;">Số Lượng</th>
                                        <th class="text-end" style="width: 25%;">Thành Tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${orderItems}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${item.product.images.startsWith('http')}">
                                                            <img src="${item.product.images}" alt="${item.product.productName}" 
                                                                 class="rounded border me-3" style="width: 45px; height: 45px; object-fit: contain;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/${item.product.images}" alt="${item.product.productName}" 
                                                                 class="rounded border me-3" style="width: 45px; height: 45px; object-fit: contain;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <strong>${item.product.productName}</strong>
                                                        <div class="small text-muted">Mã: ${item.product.productCode}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> ₫
                                            </td>
                                            <td class="text-center fw-bold">
                                                ${item.quantity}
                                            </td>
                                            <td class="text-end fw-bold text-dark">
                                                <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> ₫
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="3" class="text-end fw-bold">Phí vận chuyển COD:</td>
                                        <td class="text-end text-success fw-bold">0 ₫ (Miễn phí)</td>
                                    </tr>
                                    <tr class="table-warning">
                                        <td colspan="3" class="text-end fw-bold fs-5 text-dark">Tổng tiền thanh toán khi nhận hàng:</td>
                                        <td class="text-end fw-bold fs-4 text-danger">
                                            <fmt:formatNumber value="${order.totalMoney}" pattern="#,###"/> ₫
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Lưu ý nhận hàng -->
                        <div class="alert alert-info border-0 rounded-3 mb-0 mt-3">
                            <i class="bi bi-info-circle-fill me-2"></i>
                            <strong>Lưu ý nhận hàng:</strong> Quý khách vui lòng chuẩn bị số tiền <strong><fmt:formatNumber value="${order.totalMoney}" pattern="#,###"/> VNĐ</strong> để thanh toán cho bưu tá giao hàng. Bạn hoàn toàn có quyền kiểm tra hàng trước khi thanh toán.
                        </div>
                    </div>
                </div>

                <!-- Nút điều hướng -->
                <div class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-warning btn-lg px-4 fw-bold text-dark shadow-sm">
                        <i class="bi bi-bag-plus me-2"></i>Tiếp Tục Mua Sắm
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark btn-lg px-4">
                        <i class="bi bi-house me-2"></i>Về Trang Chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

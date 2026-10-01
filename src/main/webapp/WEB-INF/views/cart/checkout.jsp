<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Thanh Toán Đơn Hàng COD</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ Hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh Toán</li>
            </ol>
        </nav>

        <div class="border-bottom pb-3 mb-4">
            <h3 class="fw-bold text-dark mb-1">
                <i class="bi bi-credit-card-2-front text-warning me-2"></i>Thanh Toán Đơn Hàng
            </h3>
            <p class="text-muted small mb-0">Vui lòng kiểm tra lại thông tin nhận hàng và xác nhận đặt hàng phương thức COD.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-x-circle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="post">
            <div class="row g-4">
                <!-- Cột trái: Thông tin nhận hàng & phương thức COD -->
                <div class="col-lg-7">
                    <!-- Thông tin nhận hàng -->
                    <div class="card shadow-sm border-0 rounded-3 mb-4 bg-white">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="fw-bold mb-0 text-dark">
                                <i class="bi bi-geo-alt-fill text-danger me-2"></i>1. Thông Tin Nhận Hàng
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="mb-3">
                                <label for="receiverName" class="form-label fw-bold">Họ và tên người nhận <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="receiverName" name="receiverName" 
                                       placeholder="Ví dụ: Nguyễn Văn A" value="${not empty param.receiverName ? param.receiverName : defaultName}" required>
                            </div>

                            <div class="mb-3">
                                <label for="receiverPhone" class="form-label fw-bold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" 
                                       placeholder="Ví dụ: 0901234567" value="${not empty param.receiverPhone ? param.receiverPhone : defaultPhone}" required>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label fw-bold">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="address" name="address" rows="3" 
                                          placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." required>${not empty param.address ? param.address : ''}</textarea>
                            </div>

                            <div class="mb-0">
                                <label for="note" class="form-label fw-bold">Ghi chú đơn hàng (Tùy chọn)</label>
                                <textarea class="form-control" id="note" name="note" rows="2" 
                                          placeholder="Ví dụ: Giao hàng vào giờ hành chính, gọi trước khi đến...">${param.note}</textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Phương thức thanh toán COD -->
                    <div class="card shadow-sm border-0 rounded-3 mb-4 bg-white">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="fw-bold mb-0 text-dark">
                                <i class="bi bi-wallet2 text-success me-2"></i>2. Phương Thức Thanh Toán
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="form-check border rounded-3 p-3 bg-light d-flex align-items-center mb-0">
                                <input class="form-check-input ms-0 me-3 fs-5" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
                                <label class="form-check-label flex-grow-1" for="codPayment">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <strong class="text-dark fs-6"><i class="bi bi-cash-stack text-success me-2"></i>Thanh toán khi nhận hàng (COD)</strong>
                                        <span class="badge bg-success">Khuyên dùng</span>
                                    </div>
                                    <small class="text-muted d-block">
                                        Bạn sẽ thanh toán bằng tiền mặt trực tiếp cho nhân viên giao hàng khi nhận và kiểm tra sản phẩm.
                                    </small>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột phải: Tóm tắt đơn hàng & Xác nhận -->
                <div class="col-lg-5">
                    <div class="card shadow-sm border-0 rounded-3 bg-white mb-3">
                        <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                            <h5 class="fw-bold mb-0 text-dark">
                                <i class="bi bi-bag-check text-warning me-2"></i>Đơn Hàng Của Bạn
                            </h5>
                            <a href="${pageContext.request.contextPath}/cart" class="small text-decoration-none">
                                <i class="bi bi-pencil-square me-1"></i>Sửa giỏ hàng
                            </a>
                        </div>
                        <div class="card-body p-4">
                            <!-- Danh sách sản phẩm thu gọn -->
                            <div class="mb-3" style="max-height: 280px; overflow-y: auto;">
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                        <c:choose>
                                            <c:when test="${item.product.images.startsWith('http')}">
                                                <img src="${item.product.images}" alt="${item.product.productName}" 
                                                     class="rounded border me-3" style="width: 50px; height: 50px; object-fit: contain;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/${item.product.images}" alt="${item.product.productName}" 
                                                     class="rounded border me-3" style="width: 50px; height: 50px; object-fit: contain;">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="flex-grow-1 me-2">
                                            <h6 class="mb-0 text-truncate text-dark fw-bold" style="max-width: 190px;" title="${item.product.productName}">
                                                ${item.product.productName}
                                            </h6>
                                            <small class="text-muted">${item.quantity} x <fmt:formatNumber value="${item.unitPrice}" pattern="#,###"/> ₫</small>
                                        </div>
                                        <div class="text-end fw-bold text-dark">
                                            <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/> ₫
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Tính toán chi phí -->
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tạm tính:</span>
                                <span class="fw-bold"><fmt:formatNumber value="${cartTotal}" pattern="#,###"/> ₫</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Phí giao hàng:</span>
                                <span class="text-success fw-bold">0 ₫ (Miễn phí)</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Hình thức thanh toán:</span>
                                <span class="fw-bold text-dark">Tiền mặt (COD)</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="fs-5 fw-bold text-dark">Tổng thanh toán:</span>
                                <span class="fs-4 fw-bold text-danger">
                                    <fmt:formatNumber value="${cartTotal}" pattern="#,###"/> ₫
                                </span>
                            </div>

                            <!-- Nút đặt hàng -->
                            <button type="submit" class="btn btn-warning btn-lg w-100 fw-bold shadow-sm py-3 text-dark mb-2">
                                <i class="bi bi-check2-circle me-2 fs-5"></i>Xác Nhận Đặt Hàng (COD)
                            </button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary w-100">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại Giỏ Hàng
                            </a>
                        </div>
                    </div>

                    <!-- Chính sách mua hàng -->
                    <div class="card shadow-sm border-0 rounded-3 bg-light p-3">
                        <small class="text-muted d-block mb-1">
                            <i class="bi bi-shield-check text-success me-1"></i>Đảm bảo quyền lợi: Bạn được quyền đồng kiểm (mở hộp xem hàng) trước khi thanh toán tiền cho nhân viên giao vận.
                        </small>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

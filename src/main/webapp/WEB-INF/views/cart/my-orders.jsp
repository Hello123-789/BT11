<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Lịch Sử Đơn Hàng - Badminton Shop</title>
    <style>
        .order-tabs .nav-link {
            color: #495057;
            font-weight: 500;
            border-radius: 50rem;
            padding: 0.5rem 1rem;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            border: 1px solid #dee2e6;
            background-color: #f8f9fa;
            transition: all 0.2s ease-in-out;
            white-space: nowrap;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .order-tabs .nav-link:hover {
            background-color: #e9ecef;
            color: #212529;
            border-color: #ced4da;
        }
        .order-tabs .nav-link.active {
            background-color: #0d6efd !important;
            color: #ffffff !important;
            border-color: #0d6efd !important;
            box-shadow: 0 4px 6px rgba(13, 110, 253, 0.25);
        }
        .order-tabs .nav-link.active .badge {
            background-color: #ffffff !important;
            color: #0d6efd !important;
        }
        .order-card {
            border: 1px solid #e2e8f0;
            border-radius: 0.75rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .order-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.08) !important;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">Giỏ Hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch Sử Đơn Hàng</li>
            </ol>
        </nav>

        <!-- Tiêu đề trang -->
        <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="bi bi-clock-history text-warning me-2"></i>Lịch Sử Đơn Hàng
                </h3>
                <small class="text-muted">Theo dõi và lọc tiến độ xử lý đơn hàng theo 8 trạng thái</small>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-bag-plus me-1"></i>Tiếp Tục Mua Sắm
            </a>
        </div>


        <!-- THANH ĐIỀU HƯỚNG LỌC THEO 8 TRẠNG THÁI -->
        <div class="mb-4">
            <div class="nav nav-pills order-tabs flex-nowrap overflow-auto py-1">
                <!-- 0. Tất cả -->
                <a class="nav-link ${currentStatus == 'all' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=all">
                    <i class="bi bi-grid-fill me-1"></i>Tất cả
                    <span class="badge rounded-pill bg-secondary ms-1">${countAll}</span>
                </a>

                <!-- 1. Đơn hàng mới -->
                <a class="nav-link ${currentStatus == '1' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=1">
                    <i class="bi bi-sparkles me-1 text-primary"></i>Đơn hàng mới
                    <span class="badge rounded-pill bg-secondary ms-1">${count1}</span>
                </a>

                <!-- 2. Đã xác nhận -->
                <a class="nav-link ${currentStatus == '2' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=2">
                    <i class="bi bi-clipboard-check me-1 text-secondary"></i>Đã xác nhận
                    <span class="badge rounded-pill bg-secondary ms-1">${count2}</span>
                </a>

                <!-- 3. Chuẩn bị hàng -->
                <a class="nav-link ${currentStatus == '3' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=3">
                    <i class="bi bi-box-seam me-1 text-warning"></i>Chuẩn bị hàng
                    <span class="badge rounded-pill bg-secondary ms-1">${count3}</span>
                </a>

                <!-- 4. Vận chuyển -->
                <a class="nav-link ${currentStatus == '4' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=4">
                    <i class="bi bi-truck me-1 text-info"></i>Vận chuyển
                    <span class="badge rounded-pill bg-secondary ms-1">${count4}</span>
                </a>

                <!-- 5. Giao hàng -->
                <a class="nav-link ${currentStatus == '5' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=5">
                    <i class="bi bi-bicycle me-1 text-dark"></i>Giao hàng
                    <span class="badge rounded-pill bg-secondary ms-1">${count5}</span>
                </a>

                <!-- 6. Đã giao -->
                <a class="nav-link ${currentStatus == '6' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=6">
                    <i class="bi bi-check-circle-fill me-1 text-success"></i>Đã giao
                    <span class="badge rounded-pill bg-secondary ms-1">${count6}</span>
                </a>

                <!-- 7. Đơn hàng hủy -->
                <a class="nav-link ${currentStatus == '7' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=7">
                    <i class="bi bi-x-circle-fill me-1 text-danger"></i>Đơn hàng hủy
                    <span class="badge rounded-pill bg-secondary ms-1">${count7}</span>
                </a>

                <!-- 8. Đơn hàng hoàn -->
                <a class="nav-link ${currentStatus == '8' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/my-orders?status=8">
                    <i class="bi bi-arrow-counterclockwise me-1 text-muted"></i>Đơn hàng hoàn
                    <span class="badge rounded-pill bg-secondary ms-1">${count8}</span>
                </a>
            </div>
        </div>

        <c:choose>
            <%-- KHI KHÔNG CÓ ĐƠN HÀNG PHÙ HỢP VỚI BỘ LỌC --%>
            <c:when test="${empty orders}">
                <div class="card shadow-sm border-0 rounded-3 text-center p-5 bg-white my-4">
                    <div class="mb-3 text-muted">
                        <i class="bi bi-inbox display-1 text-secondary opacity-50"></i>
                    </div>
                    <h5 class="fw-bold text-dark">
                        <c:choose>
                            <c:when test="${currentStatus == '1'}">Chưa có đơn hàng nào ở trạng thái "Đơn hàng mới"</c:when>
                            <c:when test="${currentStatus == '2'}">Chưa có đơn hàng nào ở trạng thái "Đã xác nhận"</c:when>
                            <c:when test="${currentStatus == '3'}">Chưa có đơn hàng nào ở trạng thái "Chuẩn bị hàng"</c:when>
                            <c:when test="${currentStatus == '4'}">Chưa có đơn hàng nào ở trạng thái "Vận chuyển"</c:when>
                            <c:when test="${currentStatus == '5'}">Chưa có đơn hàng nào ở trạng thái "Giao hàng"</c:when>
                            <c:when test="${currentStatus == '6'}">Chưa có đơn hàng nào ở trạng thái "Đã giao"</c:when>
                            <c:when test="${currentStatus == '7'}">Chưa có đơn hàng nào ở trạng thái "Đơn hàng hủy"</c:when>
                            <c:when test="${currentStatus == '8'}">Chưa có đơn hàng nào ở trạng thái "Đơn hàng hoàn"</c:when>
                            <c:otherwise>Bạn chưa có đơn hàng nào trong hệ thống</c:otherwise>
                        </c:choose>
                    </h5>
                    <p class="text-muted col-md-6 mx-auto mb-4 small">
                        Hiện tại không có đơn hàng nào ở trạng thái này. Bạn có thể xem các trạng thái khác hoặc tiếp tục mua sắm các sản phẩm tại cửa hàng.
                    </p>
                    <div>
                        <a href="${pageContext.request.contextPath}/my-orders?status=all" class="btn btn-outline-primary px-3 py-2 me-2">
                            <i class="bi bi-grid-fill me-1"></i>Xem Tất Cả Đơn Hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-warning px-3 py-2 fw-bold text-dark">
                            <i class="bi bi-bag-plus me-1"></i>Đặt Mua Thêm Sản Phẩm
                        </a>
                    </div>
                </div>
            </c:when>

            <%-- DANH SÁCH ĐƠN HÀNG TƯƠNG ỨNG VỚI BỘ LỌC --%>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="order" items="${orders}">
                        <div class="col-12">
                            <div class="card shadow-sm order-card bg-white overflow-hidden">
                                <!-- Header đơn hàng -->
                                <div class="card-header bg-light border-bottom d-flex flex-wrap justify-content-between align-items-center py-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="fs-6 fw-bold text-dark">
                                            Mã đơn: <span class="text-primary">#DH${order.cartId}</span>
                                        </span>
                                        <span class="text-muted small">
                                            <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                        <c:if test="${not empty order.user}">
                                            <span class="badge bg-light text-dark border small">
                                                <i class="bi bi-person me-1"></i>${order.user.username}
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="d-flex align-items-center gap-2 mt-2 mt-sm-0">
                                        <span class="badge bg-secondary-subtle text-dark border">
                                            <i class="bi bi-cash me-1"></i>${order.paymentMethod}
                                        </span>

                                        <!-- Badge 8 trạng thái -->
                                        <c:choose>
                                            <c:when test="${order.status == 1}">
                                                <span class="badge bg-primary px-3 py-2 fs-6">
                                                    <i class="bi bi-sparkles me-1"></i>Đơn hàng mới
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="badge bg-secondary px-3 py-2 fs-6">
                                                    <i class="bi bi-clipboard-check me-1"></i>Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="badge bg-warning text-dark px-3 py-2 fs-6">
                                                    <i class="bi bi-box-seam me-1"></i>Chuẩn bị hàng
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 4}">
                                                <span class="badge bg-info text-dark px-3 py-2 fs-6">
                                                    <i class="bi bi-truck me-1"></i>Vận chuyển
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 5}">
                                                <span class="badge bg-dark text-white px-3 py-2 fs-6">
                                                    <i class="bi bi-bicycle me-1"></i>Giao hàng
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 6}">
                                                <span class="badge bg-success px-3 py-2 fs-6">
                                                    <i class="bi bi-check-circle-fill me-1"></i>Đã giao
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 7 or order.status == 0}">
                                                <span class="badge bg-danger px-3 py-2 fs-6">
                                                    <i class="bi bi-x-circle-fill me-1"></i>Đơn hàng hủy
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 8}">
                                                <span class="badge bg-secondary-subtle text-secondary border border-secondary px-3 py-2 fs-6">
                                                    <i class="bi bi-arrow-counterclockwise me-1"></i>Đơn hàng hoàn
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-dark border px-3 py-2 fs-6">
                                                    Trạng thái #${order.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Body: Chi tiết nhận hàng, thanh toán, sản phẩm -->
                                <div class="card-body p-4">
                                    <!-- Banner thông tin tiến độ trạng thái -->
                                    <c:choose>
                                        <c:when test="${order.status == 1}">
                                            <div class="alert alert-primary py-2 px-3 mb-3 d-flex align-items-center small">
                                                <i class="bi bi-sparkles me-2 fs-5"></i>
                                                <div><strong>Đơn hàng mới:</strong> Đơn hàng đã được tạo thành công, đang chờ tiếp nhận và xác nhận đơn.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 2}">
                                            <div class="alert alert-secondary py-2 px-3 mb-3 d-flex align-items-center small">
                                                <i class="bi bi-clipboard-check me-2 fs-5"></i>
                                                <div><strong>Đã xác nhận:</strong> Người bán đã duyệt và xác nhận đơn hàng, sẵn sàng xuất kho.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 3}">
                                            <div class="alert alert-warning py-2 px-3 mb-3 d-flex align-items-center small text-dark">
                                                <i class="bi bi-box-seam me-2 fs-5"></i>
                                                <div><strong>Chuẩn bị hàng:</strong> Đơn hàng đang được kho đóng gói cẩn thận và dán nhãn vận chuyển.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 4}">
                                            <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center small text-dark">
                                                <i class="bi bi-truck me-2 fs-5"></i>
                                                <div><strong>Đang vận chuyển:</strong> Kiện hàng đã bàn giao cho đơn vị vận chuyển và đang luân chuyển giữa các bưu cục.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 5}">
                                            <div class="alert alert-dark py-2 px-3 mb-3 d-flex align-items-center small text-white">
                                                <i class="bi bi-bicycle me-2 fs-5"></i>
                                                <div><strong>Đang giao hàng:</strong> Shipper đang trên đường đi phát hàng đến địa chỉ nhận của bạn. Vui lòng chú ý điện thoại!</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 6}">
                                            <div class="alert alert-success py-2 px-3 mb-3 d-flex align-items-center small">
                                                <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                                                <div><strong>Đã giao thành công:</strong> Người mua đã nhận hàng và hoàn tất thanh toán COD thành công.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 7 or order.status == 0}">
                                            <div class="alert alert-danger py-2 px-3 mb-3 d-flex align-items-center small">
                                                <i class="bi bi-x-circle-fill me-2 fs-5"></i>
                                                <div><strong>Đơn hàng đã hủy:</strong> Đơn hàng đã bị hủy theo yêu cầu hoặc do sự cố giao dịch.</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${order.status == 8}">
                                            <div class="alert alert-secondary py-2 px-3 mb-3 d-flex align-items-center small">
                                                <i class="bi bi-arrow-counterclockwise me-2 fs-5"></i>
                                                <div><strong>Đơn hàng hoàn:</strong> Kiện hàng đã được hoàn trả lại cho người bán.</div>
                                            </div>
                                        </c:when>
                                    </c:choose>

                                    <div class="row g-3 mb-3">
                                        <div class="col-md-7">
                                            <h6 class="small text-muted text-uppercase fw-bold mb-2">Thông tin người nhận</h6>
                                            <p class="mb-1"><strong>Họ tên:</strong> ${order.receiverName} - <span class="text-primary fw-bold">${order.receiverPhone}</span></p>
                                            <p class="mb-1 text-secondary"><strong>Địa chỉ:</strong> ${order.address}</p>
                                            <c:if test="${not empty order.note}">
                                                <p class="mb-0 text-muted small"><em>Ghi chú: "${order.note}"</em></p>
                                            </c:if>
                                        </div>
                                        <div class="col-md-5 text-md-end">
                                            <h6 class="small text-muted text-uppercase fw-bold mb-2">Tổng tiền thanh toán</h6>
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
                                        <h6 class="small text-muted fw-bold mb-2">Sản phẩm trong đơn:</h6>
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

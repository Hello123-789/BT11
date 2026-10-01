<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
    <!-- Hero Banner -->
    <div class="hero rounded-3 shadow-sm p-5 mb-4 text-center border bg-white">
        <div class="container py-3">
            <span class="badge bg-warning text-dark px-3 py-2 fs-6 mb-3 rounded-pill fw-bold">
                <i class="bi bi-fire me-1"></i>Bộ Sưu Tập Cầu Lông Mới Nhất
            </span>
            <h1 class="display-4 fw-bold text-dark mb-3">Đỉnh Cao Tốc Độ & Uy Lực Đập Cầu</h1>
            <p class="fs-5 text-muted col-md-8 mx-auto mb-4">
                Chuyên phân phối vợt cầu lông chính hãng Yonex, Victor, Li-Ning, Mizuno. Cam kết hàng chính hãng, bảo hành chu đáo và đan cước chuyên nghiệp.
            </p>
            <div class="d-flex justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg shadow-sm px-4">
                    <i class="bi bi-bag-check me-2"></i>Khám Phá Sản Phẩm
                </a>
                <a href="${pageContext.request.contextPath}/products/seller" class="btn btn-outline-dark btn-lg px-4">
                    <i class="bi bi-shop me-2"></i>Xem Theo Thương Hiệu
                </a>
            </div>
        </div>
    </div>

    <!-- 4 Thương Hiệu Hàng Đầu -->
    <h4 class="fw-bold text-dark mb-3"><i class="bi bi-stars text-warning me-2"></i>Thương Hiệu Hàng Đầu</h4>
    <div class="row text-center mb-4 g-3">
        <div class="col-md-3">
            <div class="card p-4 h-100 shadow-sm border-0 border-top border-4 border-primary align-items-center justify-content-between">
                <div class="d-flex align-items-center justify-content-center mb-3" style="height: 60px;">
                    <img src="${pageContext.request.contextPath}/uploads/yonex.jpg" alt="Yonex" class="img-fluid" style="max-height: 55px; max-width: 140px; object-fit: contain;">
                </div>
                <h5 class="fw-bold">Yonex</h5>
                <p class="text-muted small">Dòng vợt Astrox, Nanoflare, Arcsaber công nghệ Nhật Bản.</p>
                <a href="${pageContext.request.contextPath}/products?sellerId=1" class="btn btn-outline-primary btn-sm w-100 mt-2">Xem Sản Phẩm</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-4 h-100 shadow-sm border-0 border-top border-4 border-info align-items-center justify-content-between">
                <div class="d-flex align-items-center justify-content-center mb-3" style="height: 60px;">
                    <img src="${pageContext.request.contextPath}/uploads/victor.png" alt="Victor" class="img-fluid" style="max-height: 55px; max-width: 140px; object-fit: contain;">
                </div>
                <h5 class="fw-bold">Victor</h5>
                <p class="text-muted small">Dòng vợt Thruster Ryuga, Auraspeed tốc độ linh hoạt.</p>
                <a href="${pageContext.request.contextPath}/products?sellerId=2" class="btn btn-outline-info btn-sm w-100 mt-2">Xem Sản Phẩm</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-4 h-100 shadow-sm border-0 border-top border-4 border-danger align-items-center justify-content-between">
                <div class="d-flex align-items-center justify-content-center mb-3" style="height: 60px;">
                    <img src="${pageContext.request.contextPath}/uploads/lining.jpg" alt="Li-Ning" class="img-fluid" style="max-height: 55px; max-width: 140px; object-fit: contain;">
                </div>
                <h5 class="fw-bold">Li-Ning</h5>
                <p class="text-muted small">Dòng vợt Axforce, Tectonic uy lực tấn công mạnh mẽ.</p>
                <a href="${pageContext.request.contextPath}/products?sellerId=3" class="btn btn-outline-danger btn-sm w-100 mt-2">Xem Sản Phẩm</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-4 h-100 shadow-sm border-0 border-top border-4 border-success align-items-center justify-content-between">
                <div class="d-flex align-items-center justify-content-center mb-3" style="height: 60px;">
                    <img src="${pageContext.request.contextPath}/uploads/mizuno.jpg" alt="Mizuno" class="img-fluid" style="max-height: 55px; max-width: 140px; object-fit: contain;">
                </div>
                <h5 class="fw-bold">Mizuno</h5>
                <p class="text-muted small">Dòng vợt Fortius, giày Wave Claw siêu nhẹ và êm ái.</p>
                <a href="${pageContext.request.contextPath}/products?sellerId=4" class="btn btn-outline-success btn-sm w-100 mt-2">Xem Sản Phẩm</a>
            </div>
        </div>
    </div>
</body>
</html>

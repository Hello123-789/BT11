<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Cửa Hàng Cầu Lông Chính Hãng</title>

    <!-- Bootstrap 5 CSS & Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Top Bar -->
    <div class="bg-primary text-white py-1 px-3" style="font-size: 0.85rem;">
        <div class="container d-flex justify-content-between align-items-center">
            <span>
                <i class="bi bi-award-fill text-warning me-1"></i> Đồng hành cùng các vận động viên hàng đầu thế giới
            </span>
            <span class="d-none d-md-inline">
                <i class="bi bi-shield-check me-1"></i> Cam kết sản phẩm chính hãng 100%
            </span>
        </div>
    </div>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-trophy-fill me-2"></i>Badminton Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navMenu">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="bi bi-grid me-1"></i>Sản Phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products/seller">
                            <i class="bi bi-shop me-1"></i>Thương Hiệu
                        </a>
                    </li>
                    <c:if test="${sessionScope.currentUser != null and (sessionScope.currentUser.seller != null or sessionScope.currentUser.role.roleName == 'SELLER')}">
                        <li class="nav-item">
                            <a class="nav-link text-success fw-bold" href="${pageContext.request.contextPath}/seller/products">
                                <i class="bi bi-shop-window me-1"></i>Kênh Người Bán
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.currentUser != null and sessionScope.currentUser.role.roleName == 'ADMIN'}">
                        <li class="nav-item">
                            <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/products">
                                <i class="bi bi-gear-fill me-1"></i>Trang Quản Trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- Thanh tìm kiếm -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/products" method="get">
                    <div class="input-group input-group-sm">
                        <input class="form-control" type="search" name="keyword" placeholder="Tìm kiếm vợt, giày..." value="${param.keyword}">
                        <button class="btn btn-warning" type="submit"><i class="bi bi-search"></i></button>
                    </div>
                </form>

                <!-- Nút Giỏ Hàng -->
                <ul class="navbar-nav me-3 align-items-center">
                    <li class="nav-item">
                        <a class="nav-link text-white position-relative px-2" href="${pageContext.request.contextPath}/cart" title="Xem giỏ hàng">
                            <i class="bi bi-cart3 fs-5 text-warning"></i>
                            <c:set var="cartCount" value="0"/>
                            <c:if test="${sessionScope.cart != null}">
                                <c:forEach var="ci" items="${sessionScope.cart}">
                                    <c:set var="cartCount" value="${cartCount + ci.quantity}"/>
                                </c:forEach>
                            </c:if>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.65rem;">
                                ${cartCount}
                            </span>
                        </a>
                    </li>
                </ul>

                <!-- Tài khoản -->
                <ul class="navbar-nav align-items-center">
                    <c:choose>
                        <c:when test="${sessionScope.currentUser != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-white" href="#" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle text-warning me-1"></i>${sessionScope.currentUser.fullname}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow">
                                    <c:if test="${sessionScope.currentUser.seller != null or sessionScope.currentUser.role.roleName == 'SELLER'}">
                                        <li><a class="dropdown-item text-success fw-bold" href="${pageContext.request.contextPath}/seller/products"><i class="bi bi-shop-window me-2"></i>Kênh Người Bán</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.currentUser.role.roleName == 'ADMIN'}">
                                        <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-shield-lock-fill me-2"></i>Trang Quản Trị</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-2">
                                <a class="btn btn-warning text-dark btn-sm fw-bold" href="${pageContext.request.contextPath}/login"><i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-outline-warning btn-sm" href="${pageContext.request.contextPath}/register"><i class="bi bi-person-plus me-1"></i>Đăng ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container my-4 flex-grow-1">
        <c:out value="${pageBody}" escapeXml="false"/>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white pt-4 pb-3 mt-auto border-top border-secondary">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <h5 class="text-warning fw-bold"><i class="bi bi-trophy-fill me-2"></i>Badminton Shop</h5>
                    <p class="text-light small">Hệ thống phân phối dụng cụ cầu lông chính hãng hàng đầu Việt Nam.</p>
                </div>
                
                <div class="col-md-5 mb-3">
                    <h6 class="text-uppercase fw-bold text-warning mb-3">
                        <i class="bi bi-star-fill me-2"></i>Vận Động Viên Đại Diện
                    </h6>
                    <div class="d-flex flex-wrap gap-3">
                        <div class="text-center" style="width: 80px;">
                            <img src="${pageContext.request.contextPath}/images/athletes/axelsen.jpg" 
                                 alt="Viktor Axelsen" class="img-fluid rounded mb-1 shadow-sm" style="height: 85px; width: 75px; object-fit: cover;">
                            <div class="text-white fw-bold" style="font-size: 12px;">Axelsen</div>
                            <div class="text-warning" style="font-size: 11px;">Yonex</div>
                        </div>
                        <div class="text-center" style="width: 80px;">
                            <img src="${pageContext.request.contextPath}/images/athletes/lee-zii-jia.jpg" 
                                 alt="Lee Zii Jia" class="img-fluid rounded mb-1 shadow-sm" style="height: 85px; width: 75px; object-fit: cover;">
                            <div class="text-white fw-bold" style="font-size: 12px;">Lee Zii Jia</div>
                            <div class="text-warning" style="font-size: 11px;">Victor</div>
                        </div>
                        <div class="text-center" style="width: 80px;">
                            <img src="${pageContext.request.contextPath}/images/athletes/an-se-young.jpg" 
                                 alt="An Se-young" class="img-fluid rounded mb-1 shadow-sm" style="height: 85px; width: 75px; object-fit: cover;">
                            <div class="text-white fw-bold" style="font-size: 12px;">An Se-young</div>
                            <div class="text-warning" style="font-size: 11px;">Yonex</div>
                        </div>
                        <div class="text-center" style="width: 80px;">
                            <img src="${pageContext.request.contextPath}/images/athletes/shi-yu-qi.jpg" 
                                 alt="Shi Yu Qi" class="img-fluid rounded mb-1 shadow-sm" style="height: 85px; width: 75px; object-fit: cover;">
                            <div class="text-white fw-bold" style="font-size: 12px;">Shi Yu Qi</div>
                            <div class="text-warning" style="font-size: 11px;">Lining</div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-3">
                    <h6 class="text-uppercase fw-bold text-warning mb-3">Thông Tin Liên Hệ</h6>
                    <ul class="list-unstyled text-light small lh-lg">
                        <li><i class="bi bi-geo-alt-fill me-2 text-warning"></i>Địa chỉ: Đường Võ Văn Ngân, TP. Thủ Đức, TP. Hồ Chí Minh</li>
                        <li><i class="bi bi-telephone-fill me-2 text-warning"></i>Hotline: 0901 234 567</li>
                        <li><i class="bi bi-envelope-fill me-2 text-warning"></i>Email: contact@badmintonshop.vn</li>
                    </ul>
                </div>
            </div>

            <hr class="border-secondary">
            
            <div class="d-flex justify-content-between align-items-center flex-wrap small text-secondary">
                <div>&copy; 2026 Badminton Shop. Bảo lưu mọi quyền.</div>
                <div class="text-warning">Thực hiện: Võ Văn Thịnh - MSSV 24110341 - Đề số 05</div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

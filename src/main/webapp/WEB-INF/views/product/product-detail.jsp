<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>${product.productName}</title>
</head>
<body>
    <div class="card shadow-sm p-4 border-0 rounded-3">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products" class="text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <h4 class="text-dark fw-bold mb-4 border-bottom pb-2">
            <i class="bi bi-info-circle-fill text-primary me-2"></i>Thông Tin Sản Phẩm
        </h4>

        <div class="row g-4">
            <div class="col-md-5 text-center">
                <div class="bg-white p-4 border rounded-3 shadow-sm">
                    <img src="${product.images.startsWith('http') ? product.images : pageContext.request.contextPath.concat('/').concat(product.images)}" 
                         class="img-fluid rounded" style="max-height: 380px; object-fit: contain;" alt="${product.productName}">
                </div>
            </div>
            <div class="col-md-7">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-warning text-dark me-2 px-3 py-2"><i class="bi bi-trophy-fill me-1"></i>Chính Hãng</span>
                    <span class="badge bg-success px-3 py-2">Tồn kho: ${product.stock}</span>
                </div>

                <h3 class="fw-bold text-dark mb-3">${product.productName}</h3>

                <table class="table table-bordered table-striped align-middle">
                    <tbody>
                        <tr>
                            <th style="width: 30%;" class="bg-light">Tên sản phẩm</th>
                            <td class="fw-bold text-primary">${product.productName}</td>
                        </tr>
                        <tr>
                            <th class="bg-light">Mã sản phẩm</th>
                            <td><span class="badge bg-dark">${product.productCode}</span></td>
                        </tr>
                        <tr>
                            <th class="bg-light">Danh mục</th>
                            <td><span class="badge bg-secondary">${product.category.categoryName}</span></td>
                        </tr>
                        <tr>
                            <th class="bg-light">Thương hiệu</th>
                            <td><strong>${product.seller.sellername}</strong></td>
                        </tr>
                        <tr>
                            <th class="bg-light">Giá bán</th>
                            <td class="text-danger fw-bold fs-4"><fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ</td>
                        </tr>
                        <tr>
                            <th class="bg-light">Tình trạng kho</th>
                            <td>
                                <c:choose>
                                    <c:when test="${product.stock > 0}">
                                        <span class="badge bg-success fs-6"><i class="bi bi-check-circle me-1"></i>Còn hàng (${product.stock} sản phẩm)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger fs-6"><i class="bi bi-x-circle me-1"></i>Tạm hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light">Mô tả</th>
                            <td class="text-secondary">${product.description}</td>
                        </tr>
                    </tbody>
                </table>

                <!-- Form Thêm Vào Giỏ Hàng -->
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="card p-3 bg-light border-0 shadow-sm mt-3">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="${product.productId}">
                            <div class="row align-items-center g-3">
                                <div class="col-auto">
                                    <label class="fw-bold text-dark mb-0">Số lượng mua:</label>
                                </div>
                                <div class="col-auto" style="width: 130px;">
                                    <input type="number" name="quantity" class="form-control text-center fw-bold" 
                                           value="1" min="1" max="${product.stock}" 
                                           onchange="if(parseInt(this.value) > ${product.stock}) { alert('Số lượng tối đa theo tồn kho là ${product.stock}!'); this.value = ${product.stock}; }">
                                </div>
                                <div class="col-auto">
                                    <small class="text-muted">(Tối đa: ${product.stock} cây)</small>
                                </div>
                                <div class="col-12 d-flex gap-2 mt-3">
                                    <button type="submit" class="btn btn-warning btn-lg fw-bold px-4 shadow-sm text-dark">
                                        <i class="bi bi-cart-plus me-2"></i>Thêm Vào Giỏ Hàng
                                    </button>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary btn-lg px-4">
                                        <i class="bi bi-arrow-left me-1"></i>Quay Lại
                                    </a>
                                </div>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-secondary mt-3">
                            <i class="bi bi-info-circle me-2"></i>Sản phẩm này tạm thời hết hàng trong kho. Vui lòng quay lại sau!
                        </div>
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại Danh Sách
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>

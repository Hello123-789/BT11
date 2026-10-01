<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${product == null ? 'Đăng Sản Phẩm Mới' : 'Cập Nhật Sản Phẩm'}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-success text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-box-seam me-2"></i>${product == null ? 'Đăng Sản Phẩm Mới' : 'Cập Nhật Sản Phẩm'}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/seller/products" method="post">
                        <input type="hidden" name="productId" value="${product.productId}"/>

                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label fw-bold">Tên Sản Phẩm</label>
                                <input type="text" name="productName" class="form-control" value="${product.productName}" required placeholder="Nhập tên sản phẩm">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Mã Sản Phẩm</label>
                                <input type="number" name="productCode" class="form-control" value="${product.productCode}" required placeholder="Nhập mã số">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Danh Mục Sản Phẩm</label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}" ${product.category.categoryId == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Giá Bán</label>
                                <input type="number" step="any" name="price" class="form-control" value="${product.price}" required placeholder="VNĐ">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số Lượng Bán</label>
                                <input type="number" name="amount" class="form-control" value="${product.amount}" required placeholder="Số lượng">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-bold">Số Lượng Tồn Kho</label>
                                <input type="number" name="stock" class="form-control" value="${product.stock}" required placeholder="Tồn kho">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình Ảnh</label>
                            <input type="text" name="images" class="form-control" value="${product.images}" placeholder="Đường dẫn hình ảnh">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Mô Tả Sản Phẩm</label>
                            <textarea name="description" class="form-control" rows="3" placeholder="Nhập thông tin chi tiết về sản phẩm">${product.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Trạng Thái Kinh Doanh</label>
                            <select name="status" class="form-select">
                                <option value="1" ${product.status == 1 ? 'selected' : ''}>Đang kinh doanh</option>
                                <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm ngừng kinh doanh</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/seller/products" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại
                            </a>
                            <button type="submit" class="btn btn-success px-4 fw-bold">
                                <i class="bi bi-save me-1"></i>${product == null ? 'Lưu Sản Phẩm' : 'Lưu Thay Đổi'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${category == null ? 'Thêm Danh Mục Mới' : 'Cập Nhật Danh Mục'}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-tags-fill me-2"></i>${category == null ? 'Thêm Danh Mục Mới' : 'Cập Nhật Danh Mục'}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                        <input type="hidden" name="categoryId" value="${category.categoryId}"/>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên Danh Mục</label>
                            <input type="text" name="categoryName" class="form-control" value="${category.categoryName}" required placeholder="Nhập tên danh mục">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình Ảnh</label>
                            <input type="text" name="images" class="form-control" value="${category.images}" placeholder="Đường dẫn hình ảnh">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Trạng Thái</label>
                            <select name="status" class="form-select">
                                <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${category.status == 0 ? 'selected' : ''}>Tạm khóa</option>
                            </select>
                        </div>
                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="bi bi-save me-1"></i>${category == null ? 'Lưu Danh Mục' : 'Lưu Thay Đổi'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

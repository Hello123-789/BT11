<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${seller == null ? 'Thêm Đối Tác Mới' : 'Cập Nhật Đối Tác'}</title>
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0 fw-bold">
                        <i class="bi bi-shop me-2"></i>${seller == null ? 'Thêm Đối Tác Mới' : 'Cập Nhật Đối Tác'}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/sellers" method="post">
                        <input type="hidden" name="sellerId" value="${seller.sellerId}"/>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên Thương Hiệu</label>
                            <input type="text" name="sellername" class="form-control" value="${seller.sellername}" required placeholder="Nhập tên thương hiệu">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình Ảnh Logo</label>
                            <input type="text" name="images" class="form-control" value="${seller.images}" placeholder="Đường dẫn hình ảnh">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Trạng Thái Hoạt Động</label>
                            <select name="status" class="form-select">
                                <option value="1" ${seller.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${seller.status == 0 ? 'selected' : ''}>Tạm dừng</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/admin/sellers" class="btn btn-secondary px-4">
                                <i class="bi bi-arrow-left me-1"></i>Quay Lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-bold">
                                <i class="bi bi-save me-1"></i>${seller == null ? 'Lưu Đối Tác' : 'Lưu Thay Đổi'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

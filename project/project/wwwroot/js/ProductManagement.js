// Hàm kết nối SignalR và gọi hàm xử lý dữ liệu sản phẩm
function connectToProductHub() {
    var connection = new signalR.HubConnectionBuilder()
        .withUrl("/productHub") // Đường dẫn Hub đã đăng ký trong Startup.cs
        .build();

    connection.on("ReceiveProductData", function (products) {
        displayProductData(products);
    });

    connection.on("ReceiveCategories", function (categories) {
        displayCategories(categories);
    });

    connection.on("ProductDeleted", function (productId) {
        removeProductFromTable(productId);
    });

    connection.on("ProductStatusToggled", function (productId, isActive) {
        toggleProductStatus(productId, isActive);
    });

    connection.start().then(function () {
        connection.invoke("GetProductData");
        connection.invoke("GetCategories"); // Lấy danh mục từ server khi kết nối
    });

    return connection;
}

// Khai báo hàm xử lý dữ liệu sản phẩm và hiển thị lên bảng
function displayProductData(products) {
    var productTable = document.getElementById("productTable");
    productTable.innerHTML = "";

    products.forEach(function (product) {
        // Tạo hàng mới trong bảng "Product"
        var newRow = productTable.insertRow();

        // Thêm thông tin sản phẩm vào các ô tương ứng
        newRow.insertCell().innerHTML = `
                    <div class="img">
                        <a href="#"><img src="${product.image}" alt="Image"></a>
                        <p>${product.productName}</p>
                    </div>
                `;
        newRow.insertCell().innerText = "$" + product.price.toFixed(2);
        newRow.insertCell().innerText = "$" + product.cost.toFixed(2)
        newRow.insertCell().innerText = "$" + product.stockQuantity;
        newRow.insertCell().innerHTML = `
                    <div class="qty">
                        <button class="btn-minus"><i class="fa fa-minus"></i></button>
                        <input type="text" value="${product.stockQuantity}">
                        <button class="btn-plus"><i class="fa fa-plus"></i></button>
                    </div>
                `;
        newRow.insertCell().innerHTML = `
                    <button class="btn-cart">${product.productId}</button>
                `;
        newRow.insertCell().innerHTML = `
                    <button class="btn-remove" data-productid="${product.productId}">
                        <i class="fa fa-trash btn-remove" data-productid="${product.productId}"></i>
                    </button>
                    <button class="btn-toggle-status" data-productid="${product.productId}">
                        <i class="btn-toggle-status ${product.isActive ? 'fa-regular fa-eye' : 'fa-solid fa-eye-slash'}" data-productid="${product.productId}"></i>
                    </button>
                `;
    });
}

// Hàm xóa sản phẩm từ bảng dựa vào productId
function removeProductFromTable(productId) {
    var rowToDelete = document.querySelector(`[data-productid="${productId}"]`).closest("tr");
    if (rowToDelete) {
        rowToDelete.remove();
    }
}

// Hàm chuyển đổi trạng thái isActive của sản phẩm trong bảng dựa vào productId và giá trị isActive mới
function toggleProductStatus(productId, isActive) {
    var productElement = document.querySelector(`[data-productid="${productId}"]`);
    if (productElement) {
        var statusIcon = productElement.querySelector(".status-icon");
        if (isActive) {
            statusIcon.classList.remove("fa-solid", "fa-eye-slash");
            statusIcon.classList.add("fa-regular", "fa-eye");
        } else {
            statusIcon.classList.remove("fa-regular", "fa-eye");
            statusIcon.classList.add("fa-solid", "fa-eye-slash");
        }
    }
}

// Khai báo hàm xử lý sự kiện click ngoài phạm vi hàm displayProductData
function handleRemoveButtonClick(event) {
    if (event.target && event.target.classList.contains("btn-remove")) {
        var productId = event.target.getAttribute("data-productid");
        if (productId) {
            // Gọi phương thức xóa sản phẩm trên server qua SignalR
            connection.invoke("DeleteProduct", parseInt(productId));
        }
    }
}

// Khai báo hàm xử lý sự kiện click ngoài phạm vi hàm displayProductData
function handleToggleStatusButtonClick(event) {
    if (event.target && event.target.classList.contains("btn-toggle-status")) {
        var productId = event.target.getAttribute("data-productid");
        if (productId) {
            // Gọi phương thức chuyển đổi trạng thái sản phẩm trên server qua SignalR
            connection.invoke("ToggleProductStatus", parseInt(productId)).then(function () {
                // Sau khi chuyển đổi thành công, gọi lại phương thức lấy dữ liệu sản phẩm để cập nhật lại bảng
                connection.invoke("GetProductData");
            }).catch(function (error) {
                console.error("Error toggling product status:", error);
            });
        }
    }
}

function saveProduct() {
    console.log(categoryId);
    var productName = document.getElementById("productName").value;
    var productPrice = parseFloat(document.getElementById("productPrice").value);
    var productCost = parseFloat(document.getElementById("productCost").value);
    var productStockQuantity = parseInt(document.getElementById("productStockQuantity").value);
    var isActive = document.getElementById("isActive").checked;
    var categoryId = parseInt(document.getElementById("categoryId").value); // Lấy giá trị categoryId từ select

    // Gọi phương thức CreateProduct trên server qua SignalR
    connection.invoke("CreateProduct", productName, productPrice, productCost, productStockQuantity, isActive, categoryId);

    // Đóng modal sau khi lưu thành công
    var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
    modal.hide();
}

// Kết nối SignalR và gọi hàm xử lý dữ liệu sản phẩm
var connection = connectToProductHub();

// Lắng nghe sự kiện click trên cả trang và gọi hàm xử lý khi cần thiết
document.addEventListener("click", handleRemoveButtonClick);
document.addEventListener("click", handleToggleStatusButtonClick);




// Hàm lấy dữ liệu danh mục từ server
function getCategories() {
    connection.invoke("GetCategories").then(function (categories) {
        // Hiển thị dữ liệu danh mục lên bảng Category
        var categoryTable = document.getElementById("categoryTable");
        categoryTable.innerHTML = "";

        // Hiển thị tùy chọn danh mục trong thẻ select
        var categorySelect = document.getElementById("categoryId");
        categorySelect.innerHTML = "";

        categories.forEach(function (category) {
            var newRow = categoryTable.insertRow();
            newRow.insertCell().innerText = category.categoryId;
            newRow.insertCell().innerText = category.categoryName;

            // Thêm tùy chọn danh mục vào thẻ select
            var option = document.createElement("option");
            option.value = category.categoryId;
            option.innerText = category.categoryName;
            categorySelect.appendChild(option);
        });

        // Hiển thị modal thêm mới sản phẩm khi nhận được dữ liệu danh mục
        var addProductModal = new bootstrap.Modal(document.getElementById('addProductModal'));
        addProductModal.show();
    }).catch(function (error) {
        console.error("Error getting categories:", error);
    });
}

// Hiển thị danh mục trong thẻ <select>
function displayCategories(categories) {
    var categoryIdSelect = document.getElementById("categoryId");
    categoryIdSelect.innerHTML = ""; // Xóa hết các tùy chọn hiện có trong thẻ <select>

    categories.forEach(function (category) {
        var option = document.createElement("option");
        option.value = category.categoryId;
        option.innerText = category.categoryName;
        categoryIdSelect.appendChild(option);
    });
}

// Lắng nghe sự kiện click trên nút Thêm mới sản phẩm và gọi hàm để lấy dữ liệu danh mục từ server
document.getElementById("btnAddProduct").addEventListener("click", function () {
    getCategories();
});
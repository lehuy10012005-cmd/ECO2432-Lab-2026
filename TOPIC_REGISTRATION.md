# BẢN ĐĂNG KÝ CẶP VÀ CHỦ ĐỀ ĐỒ ÁN CAPSTONE (ECO2432)

* **Học phần:** Tiền điện tử & Hợp đồng thông minh (ECO2432)
* **Giảng viên phụ trách:** TS. Hà Ngọc Long
* **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế
* **Hạn nộp đăng ký:** Thứ Bảy, 26/09/2026

---

## 1. Thông tin hai thành viên trong cặp
1. **Lê Văn Quang Huy**
   * Mã sinh viên: **23K4300010**
   * Email: `lehuy10012005@gmail.com`
   * Vai trò chính: Trưởng nhóm / Quản trị Repo GitHub / Kỹ sư Hợp đồng & Đặc tả
2. **Lại Vương Gia Bảo**
   * Mã sinh viên: **23K4300024**
   * Vai trò chính: Thành viên cặp / Kỹ sư Kiểm thử & Giao diện DApp

---

## 2. Chủ đề đồ án lựa chọn
* **Chủ đề:** **Chủ đề 5 — Gây quỹ có hoàn tiền (Crowdfunding with Refund Guarantee)**
* *(Căn cứ theo danh mục 10 chủ đề phù hợp sinh viên năm 3 tại Phần N, Trang 48–49 — Sổ tay thực hành ECO2432)*
* **Mức độ:** Vừa

---

## 3. Tên dự kiến của sản phẩm
* **Tên tiếng Anh:** **HCE-FundGuard**
* **Tên tiếng Việt:** Nền tảng Gây quỹ Cộng đồng Sinh viên có Bảo chứng Hoàn tiền Tự động

---

## 4. Câu mô tả sản phẩm (Chuẩn mẫu quy định)
> **“Nhóm xây dựng HCE-FundGuard cho các câu lạc bộ và nhóm sinh viên khởi nghiệp Trường Đại học Kinh tế để bảo đảm tính minh bạch của vốn góp và tự động hoàn trả 100% tiền cho người ủng hộ nếu dự án không đạt mục tiêu tài chính trước thời hạn quy định.”**

---

## 5. Luồng nghiệp vụ cốt lõi cam kết demo
1. **Góp vốn (Funding):** Người ủng hộ kết nối ví Web3 và gửi tiền đóng góp vào Smart Contract trước thời hạn (Deadline). Hợp đồng tự động hạch toán số dư của từng người và cập nhật tổng quỹ.
2. **Kịch bản Đạt mục tiêu (Goal Met):** Khi hết hạn hoặc trước hạn, nếu tổng số tiền đóng góp $\ge$ Mục tiêu gây quỹ $\rightarrow$ Hợp đồng cho phép Chủ dự án (Campaign Owner) rút toàn bộ tiền vốn để triển khai dự án.
3. **Kịch bản Không đạt mục tiêu (Refund Guarantee):** Nếu hết thời hạn quy định mà tổng vốn góp chưa đạt mục tiêu $\rightarrow$ Hợp đồng vĩnh viễn khóa quyền rút tiền của Chủ dự án; đồng thời tự động kích hoạt cơ chế hoàn tiền để từng người đóng góp tự gọi hàm rút lại đúng $100\%$ số tiền mình đã góp một cách công bằng, minh bạch.

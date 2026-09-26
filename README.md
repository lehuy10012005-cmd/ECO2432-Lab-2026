# ECO2432 — Tiền điện tử và Hợp đồng thông minh
* **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế, Đại học Huế
* **Giảng viên phụ trách:** TS. Hà Ngọc Long
* **Kho lưu trữ:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)

---

## 📌 THÔNG TIN ĐĂNG KÝ CẶP & CHỦ ĐỀ ĐỒ ÁN CAPSTONE (Hạn 26/09/2026)

* **Thành viên nhóm (Cặp 2 sinh viên):**
  1. **Lê Văn Quang Huy** — MSSV: `23K4300010` (Trưởng nhóm / Quản trị Repo)
  2. **Lại Vương Gia Bảo** — MSSV: `23K4300024` (Thành viên cặp)
* **Chủ đề lựa chọn:** **Chủ đề 5 — Gây quỹ có hoàn tiền (Crowdfunding with Refund Guarantee)**  
  *(Căn cứ theo danh mục 10 chủ đề tại Phần N, Trang 48–49 — Sổ tay thực hành ECO2432)*
* **Tên dự kiến sản phẩm:** **HCE-FundGuard** *(Nền tảng gây quỹ cộng đồng có bảo chứng hoàn tiền tự động)*
* **Câu mô tả định vị sản phẩm (chuẩn mẫu quy định):**
  > **“Nhóm xây dựng HCE-FundGuard cho các câu lạc bộ và nhóm sinh viên khởi nghiệp Trường Đại học Kinh tế để bảo đảm tính minh bạch của vốn góp và tự động hoàn trả 100% tiền cho người ủng hộ nếu dự án không đạt mục tiêu tài chính trước thời hạn quy định.”**
* **Luồng cốt lõi cam kết demo:**
  * Người ủng hộ nạp tiền góp vốn vào hợp đồng thông minh trước thời hạn (Deadline).
  * **Kịch bản thành công:** Nếu tổng vốn góp $\ge$ Mục tiêu tài chính $\rightarrow$ Chủ dự án được quyền rút vốn để thực hiện.
  * **Kịch bản thất bại:** Nếu hết hạn mà tổng vốn góp $<$ Mục tiêu $\rightarrow$ Hợp đồng khóa quyền rút của chủ dự án, từng người ủng hộ được tự rút lại $100\%$ tiền đã góp (Refund guarantee) mà không bị giữ lại bất kỳ khoản phí nào.
* **Chi tiết hồ sơ đăng ký:** Xem tệp [TOPIC_REGISTRATION.md](./TOPIC_REGISTRATION.md)

---

## 📂 Danh mục sản phẩm các bài thực hành cá nhân (Lab 1 – 7)

| Bài Lab | Sản phẩm hoàn thành | Mô tả tóm tắt nội dung |
| :--- | :--- | :--- |
| **Lab 1** | [`AGENTS.md`](./AGENTS.md) | Quy ước dự án & 4 nguyên tắc cá nhân (Kế toán on-chain, AML, kiểm thử AI) |
| **Lab 2** | [`lab02.md`](./lab02.md) | Giao dịch đầu tiên Sepolia, đối chiếu EIP-55 Checksum, Address Poisoning |
| **Lab 3** | [`forensics.md`](./forensics.md) | Pháp y 8 trường giao dịch & Thẩm định hợp đồng USDT Mainnet (Blacklist) |
| **Lab 4** | [`lab04.md`](./lab04.md) | Thẩm định 3 token trong `ClubTokens.sol`, trích dẫn dòng lỗi rug-pull & honeypot |
| **Lab 5** | [`SPEC.md`](./SPEC.md) | Bản đặc tả nghiệp vụ BA cho công cụ phân tích dòng tiền ví on-chain 90 ngày |
| **Lab 6** | [`wallet_analyzer.py`](./wallet_analyzer.py)<br>[`balance_chart.png`](./balance_chart.png) | Chương trình Python kết nối Etherscan API V2, tính dòng tiền & vẽ biểu đồ |
| **Lab 7** | [`lab07.md`](./lab07.md) | Báo cáo thẩm định kinh tế & tính toán chi phí Gas (L1 75 triệu vs L2 750k VNĐ) |
| **Nhật ký** | [`AI_JOURNAL.md`](./AI_JOURNAL.md) | Nhật ký AI ghi nhận 7 lần tương tác, bắt các lỗi logic & sai lệch thứ nguyên |

---

## 🛠️ Cấu trúc kho lưu trữ mã nguồn
- `contracts/training/`: Các hợp đồng mẫu thực hành (`TimeLockVault`, `ClassPoint`, `VaultBuggy`, `VulnerableBank`).
- `contracts/lab04/ClubTokens.sol`: Ba token mẫu phục vụ thẩm định rủi ro.
- `web/index.html`: Giao diện Web mẫu kết nối Web3.
- `prompt_templates.md`: Mẫu câu lệnh AI tiêu chuẩn.
- `wallet_analyzer.py`: Mã nguồn công cụ phân tích ví on-chain (Lab 6).
- `balance_chart.png`: Biểu đồ trực quan hóa số dư ví Sepolia thực tế (Lab 6).
- `lab07.md`: Báo cáo chi phí gas thực tế (Lab 7).
- `TOPIC_REGISTRATION.md`: Bản đăng ký cặp và chủ đề đồ án Capstone chính thức.

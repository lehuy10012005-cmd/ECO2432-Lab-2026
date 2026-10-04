# ECO2432 — Tiền điện tử và Hợp đồng thông minh
* **Sinh viên thực hiện:** 
  1. **Lê Văn Quang Huy** — MSV: `23K4300010` (Trưởng nhóm / Repo Owner)
  2. **Lại Vương Gia Bảo** — MSV: `23K4300024` (Thành viên cặp)
* **Lớp:** K57 Kinh Tế Số
* **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế, Đại học Huế
* **Giảng viên phụ trách:** TS. Hà Ngọc Long
* **Kho lưu trữ:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)

---

## 📌 THÔNG TIN ĐỒ ÁN CAPSTONE NHÓM (HCE-ScholarProof)

* **Chủ đề lựa chọn:** **Chủ đề 8 — Ghi nhận quyền tác giả của ý tưởng nghiên cứu khoa học (Proof of Authorship & Idea Timestamping)**  
  *(Căn cứ theo danh mục 10 chủ đề tại Phần N, Trang 48–49 — Sổ tay thực hành ECO2432)*
* **Tên sản phẩm:** **HCE-ScholarProof** *(Nền tảng Ghi nhận và Bảo chứng Quyền tác giả Ý tưởng Nghiên cứu Khoa học trên Blockchain)*
* **Tuyên ngôn định vị sản phẩm (chuẩn mẫu quy định):**
  > **“Nhóm xây dựng HCE-ScholarProof cho sinh viên, giảng viên và các nhà nghiên cứu trẻ Trường Đại học Kinh tế để xác lập bằng chứng ưu tiên quyền sở hữu trí tuệ bất biến (Proof of Existence) cho các ý tưởng nghiên cứu, đề cương khoa học và tập dữ liệu ban đầu trên blockchain với chi phí vi mô, ngăn chặn hoàn toàn nguy cơ bị chiếm đoạt ý tưởng (Scooping) mà không cần bộc lộ nội dung bí mật ra công chúng.”**
* **Hồ sơ đăng ký chi tiết:** Xem tệp [TOPIC_REGISTRATION.md](./TOPIC_REGISTRATION.md)

---

## 📂 Danh mục sản phẩm các bài thực hành (Lab 1 – 8)

| Bài Lab | Sản phẩm hoàn thành | Mô tả tóm tắt nội dung | Minh chứng Commit (Click xem code) |
| :--- | :--- | :--- | :---: |
| **Lab 1** | [`AGENTS.md`](./AGENTS.md) | Quy ước dự án & 4 nguyên tắc cá nhân (Kế toán on-chain, AML, kiểm thử AI) | [`e8aa347`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/e8aa347) |
| **Lab 2** | [`lab02.md`](./lab02.md) | Giao dịch đầu tiên Sepolia, đối chiếu EIP-55 Checksum, Address Poisoning | [`5e4e774`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/5e4e774) |
| **Lab 3** | [`forensics.md`](./forensics.md) | Pháp y 8 trường giao dịch & Thẩm định hợp đồng USDT Mainnet (Blacklist) | [`b5378a1`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/b5378a1) |
| **Lab 4** | [`lab04.md`](./lab04.md) | Thẩm định 3 token trong `ClubTokens.sol`, trích dẫn dòng lỗi rug-pull & honeypot | [`bb9656c`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/bb9656c) |
| **Lab 5** | [`SPEC.md`](./SPEC.md) | Bản đặc tả nghiệp vụ BA cho công cụ phân tích dòng tiền ví on-chain 90 ngày | [`8b0c099`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/8b0c099) |
| **Lab 6** | [`wallet_analyzer.py`](./wallet_analyzer.py)<br>[`balance_chart.png`](./balance_chart.png) | Chương trình Python kết nối Etherscan API V2, tính dòng tiền & vẽ biểu đồ | [`fab046a`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/fab046a) |
| **Lab 7** | [`lab07.md`](./lab07.md) | Báo cáo thẩm định kinh tế & tính toán chi phí Gas (L1 75 triệu vs L2 750k VNĐ) | [`c05dc4e`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/c05dc4e) |
| **Lab 8** | [`lab08.md`](./lab08.md)<br>[`TOPIC_REGISTRATION.md`](./TOPIC_REGISTRATION.md)<br>[`ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) | Khởi động Đồ án Capstone Chủ đề 8 (HCE-ScholarProof), cơ chế Proof of Existence, thiết kế hợp đồng & 3 ca kiểm thử | [`40104a6`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/40104a6) |
| **Nhật ký** | [`AI_JOURNAL.md`](./AI_JOURNAL.md) | Nhật ký AI ghi nhận 8 lần tương tác, bắt các lỗi logic & thẩm định đề tài | [`40104a6`](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026/commit/40104a6) |

---

## 🛠️ Cấu trúc kho lưu trữ mã nguồn
- `contracts/capstone/ScholarProof.sol`: Hợp đồng thông minh ghi nhận quyền tác giả ý tưởng nghiên cứu (Đồ án Capstone Chủ đề 8).
- `contracts/training/`: Các hợp đồng mẫu thực hành (`TimeLockVault`, `ClassPoint`, `VaultBuggy`, `VulnerableBank`).
- `contracts/lab04/ClubTokens.sol`: Ba token mẫu phục vụ thẩm định rủi ro.
- `web/index.html`: Giao diện Web mẫu kết nối Web3.
- `prompt_templates.md`: Mẫu câu lệnh AI tiêu chuẩn.
- `wallet_analyzer.py`: Mã nguồn công cụ phân tích ví on-chain (Lab 6).
- `balance_chart.png`: Biểu đồ trực quan hóa số dư ví Sepolia thực tế (Lab 6).
- `lab07.md`: Báo cáo chi phí gas thực tế (Lab 7).
- `lab08.md`: Báo cáo khởi động đồ án Capstone Chủ đề 8 (Lab 8).
- `TOPIC_REGISTRATION.md`: Bản đăng ký cặp và chủ đề đồ án Capstone chính thức.

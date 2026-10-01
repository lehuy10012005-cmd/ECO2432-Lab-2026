# ECO2432 — Tiền điện tử và Hợp đồng thông minh
* **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế, Đại học Huế
* **Giảng viên phụ trách:** TS. Hà Ngọc Long
* **Kho lưu trữ:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)

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

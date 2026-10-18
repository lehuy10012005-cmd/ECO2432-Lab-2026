# HCE-ScholarProof — Nền tảng Ghi nhận & Bảo chứng Quyền tác giả Ý tưởng Nghiên cứu Khoa học trên Blockchain

> **Đồ án Capstone môn học:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
> **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế, Đại học Huế  
> **Giảng viên hướng dẫn:** TS. Hà Ngọc Long  
> **Kho lưu trữ chính thức:** [https://github.com/lehuy10012005-cmd/HCE-ScholarProof](https://github.com/lehuy10012005-cmd/HCE-ScholarProof)  
> **Website DApp trực tuyến (Live Demo - Vercel Production):** [https://chungnhanquyentacgia.vercel.app/](https://chungnhanquyentacgia.vercel.app/)
> **Lưu trữ dữ liệu website (Supbase): https://supabase.com/dashboard/project/nolpfigqglmwcbfqoksq/sql/c909fd6a-d77e-4778-aff8-1f10bfafc65d
---

## 👥 Nhóm sinh viên thực hiện (Cặp 2 sinh viên)

| STT | Họ và tên sinh viên | Mã sinh viên | Lớp | Vai trò dự án | Email |
| :---: | :--- | :---: | :---: | :--- | :--- |
| 1 | **Lê Văn Quang Huy** | `23K4300010` | K57 Kinh Tế Số | **Trưởng nhóm** / Kỹ sư Hợp đồng Thông minh & Đặc tả Nghiệp vụ | `lehuy10012005@gmail.com` |
| 2 | **Lại Vương Gia Bảo** | `23K4300024` | K57 Kinh Tế Số | **Thành viên cặp** / Kỹ sư Kiểm thử Tự động & Giao diện Web3 DApp | `bao9d4tpsh@gmail.com` |

---

## 🎯 Giới thiệu Đề tài Đồ án Capstone

## 1. Chủ đề lựa chọn

**Chủ đề 8: Ghi nhận quyền tác giả của ý tưởng nghiên cứu khoa học (Proof of Authorship & Idea Timestamping).**

Đề tài tập trung ứng dụng công nghệ Blockchain để ghi nhận sự tồn tại và dấu thời gian của các ý tưởng nghiên cứu khoa học, góp phần bảo vệ thành quả sáng tạo và hạn chế tranh chấp quyền tác giả trong môi trường học thuật.

## 2. Tên sản phẩm

**HCE-ScholarProof** – Nền tảng ghi nhận quyền tác giả ý tưởng nghiên cứu khoa học trên Blockchain.

Thương hiệu thực nghiệm: **HCE LEDGER**.

## 3. Bối cảnh và lý do lựa chọn

Trong môi trường đại học, việc chứng minh thời điểm hình thành ý tưởng và quyền ưu tiên sáng tạo còn gặp nhiều khó khăn. Các phương thức lưu trữ truyền thống chưa luôn bảo đảm khả năng xác minh độc lập và tính toàn vẹn của dữ liệu. Vì vậy, nhóm lựa chọn Blockchain nhằm xây dựng giải pháp ghi nhận bằng chứng số minh bạch, có thể kiểm chứng và khó bị thay đổi trái phép.

## 4. Mục tiêu dự án

- Ghi nhận sự tồn tại của ý tưởng và tài liệu nghiên cứu tại một thời điểm cụ thể.
- Sử dụng mã băm để kiểm tra tính toàn vẹn của tài liệu.
- Ứng dụng hợp đồng thông minh để lưu trữ và xác minh bản ghi trên Blockchain.
- Xây dựng giao diện DApp thân thiện, dễ sử dụng và tối ưu chi phí lưu trữ.

## 5. Tuyên ngôn định vị giá trị (Value Proposition)

HCE-ScholarProof là nền tảng DApp hỗ trợ sinh viên, giảng viên và nhà nghiên cứu tạo bằng chứng về sự tồn tại của ý tưởng khoa học thông qua mã băm và dấu thời gian trên Blockchain Sepolia. Giải pháp góp phần tăng tính minh bạch, hỗ trợ xác minh nội dung và bảo vệ quyền lợi của người sáng tạo.

## 6. Công nghệ và cơ chế hoạt động

Dự án sử dụng Blockchain Sepolia Testnet, hợp đồng thông minh (Smart Contract), hàm băm mật mã (Cryptographic Hashing) và giao diện DApp. Người dùng đăng ký tài liệu, hệ thống tạo mã băm, ghi nhận thông tin cần thiết lên Blockchain và cho phép đối chiếu mã băm để kiểm tra tính toàn vẹn của tài liệu.

## 7. Địa chỉ hợp đồng thông minh

- **Mạng triển khai:** Sepolia Testnet.
- **Địa chỉ hợp đồng:** `0x5D0E0Be214C4B6eF29CA8183F8BAF0Aaf6ab4e87`

## 8. Ý nghĩa và định hướng phát triển

HCE-ScholarProof minh họa khả năng ứng dụng Blockchain và Web3 trong bảo vệ bằng chứng học thuật. Trong tương lai, dự án có thể phát triển thêm tính năng xác minh bằng mã QR, cấp chứng nhận điện tử và tích hợp với hệ thống quản lý nghiên cứu của nhà trường.

*Lưu ý: Blockchain cung cấp bằng chứng kỹ thuật về sự tồn tại và tính toàn vẹn của dữ liệu tại thời điểm ghi nhận, nhưng không tự động xác lập quyền sở hữu trí tuệ hợp pháp.*
---

## 📂 Danh mục sản phẩm & Lộ trình triển khai Đồ án (Lab 8 – 15)

| Giai đoạn | Sản phẩm bàn giao | Mô tả nghiệp vụ & Kỹ thuật | Trạng thái |
| :---: | :--- | :--- | :---: |
| **Lab 8** | [`TOPIC_REGISTRATION.md`](./TOPIC_REGISTRATION.md)<br>[`lab08.md`](./lab08.md)<br>[`ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) | Khởi động đồ án Chủ đề 8, thiết lập cơ chế Proof of Existence, băm mật mã client-side, thiết kế Smart Contract & bộ 3 ca kiểm thử | ✅ **Hoàn thành** |
| **Lab 9** | [`SPEC.md`](./SPEC.md)<br>[`lab09.md`](./lab09.md)<br>[`contracts/training/TimeLockVault.sol`](./contracts/training/TimeLockVault.sol) | Đặc tả nghiệp vụ BA chi tiết cho nền tảng ScholarProof, máy trạng thái xác thực ý tưởng và ma trận rủi ro | ✅ **Hoàn thành** |
| **Lab 10** | [`lab10.md`](./lab10.md)<br>[`contracts/capstone/ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) (v2)<br>[`contracts/project/ProjectCore.sol`](./contracts/project/ProjectCore.sol) | Rà soát mã nguồn do AI sinh ra, giải mã Storage Slot 2 (VaultBuggy), kiểm toán & nâng cấp ScholarProof v2 | ✅ **Hoàn thành** |
| **Lab 11** | [`web/index.html`](./web/index.html)<br>[`lab11.md`](./lab11.md) | Xây dựng giao diện Web3 DApp: Băm file client-side (Keccak-256), kết nối MetaMask Ethers.js v6, tra cứu và xuất chứng thư số | ✅ **Hoàn thành** |
| **Lab 12** | [`test/ScholarProof.test.js`](./test/ScholarProof.test.js)<br>[`contracts/test/ScholarProof_test.sol`](./contracts/test/ScholarProof_test.sol)<br>[`lab12.md`](./lab12.md) | Bộ kịch bản kiểm thử tự động toàn diện: Luồng chuẩn, chống gian lận nộp đè mã băm, xử lý ngoại lệ biên | ✅ **Hoàn thành** |
| **Lab 13** | [`web/index.html`](./web/index.html) (Tích hợp Sepolia Testnet)<br>[`lab13.md`](./lab13.md)<br>[`AI_JOURNAL.md`](./AI_JOURNAL.md) | Tích hợp địa chỉ hợp đồng deploy Sepolia, xác thực mã nguồn Etherscan, kiểm thử luồng ký ví và đối soát sự kiện on-chain | ✅ **Hoàn thành** |
| **Lab 14** | [`audit_report.md`](./audit_report.md)<br>[`lab14.md`](./lab14.md)<br>[`scripts/gas_benchmark.py`](./scripts/gas_benchmark.py) | Kiểm toán an toàn hợp đồng, đo lường chi phí Gas thực nghiệm trên Layer 2 Base/Arbitrum vs Sepolia Testnet | ✅ **Hoàn thành** |
| **Lab 15** | [`DEPLOYMENT.md`](./DEPLOYMENT.md)<br>[`SLIDES.md`](./SLIDES.md)<br>[`DAPP_AI_SUPERVISION_JOURNAL.md`](./DAPP_AI_SUPERVISION_JOURNAL.md)<br>[`lab15.md`](./lab15.md) | Tài liệu hướng dẫn vận hành, nhật ký thực chiến giám sát AI & bằng chứng kiểm thử Web DApp, slide thuyết trình nghiệm thu trước hội đồng | ✅ **Hoàn thành** |

---

## 🛠️ Cấu trúc kho lưu trữ mã nguồn Đồ án
```text
HCE-ScholarProof/
├── contracts/
│   ├── capstone/
│   │   └── ScholarProof.sol            # Hợp đồng thông minh ghi nhận quyền tác giả ý tưởng (v2)
│   ├── project/
│   │   └── ProjectCore.sol             # Hợp đồng lõi theo định danh quy định của học phần
│   └── training/                       # Thư viện hợp đồng mẫu tham chiếu (TimeLockVault, VaultBuggy)
├── web/
│   └── index.html                      # Giao diện Web3 DApp băm file client-side và tra cứu on-chain
├── AGENTS.md                           # Quy ước lập trình và chuẩn mực bảo mật dự án
├── AI_JOURNAL.md                       # Nhật ký làm việc, phản biện và giám sát AI học phần (Lab 1 - 15)
├── DAPP_AI_SUPERVISION_JOURNAL.md      # Nhật ký thực chiến giám sát AI & bằng chứng kiểm thử Web DApp
├── SPEC.md                             # Bản đặc tả nghiệp vụ BA và máy trạng thái hệ thống
├── TOPIC_REGISTRATION.md               # Bản đăng ký đề tài Capstone chính thức của cặp sinh viên
├── lab08.md - lab15.md                 # Bộ 8 báo cáo kỹ thuật & kinh tế chi tiết của từng giai đoạn Lab
├── package.json                        # Cấu hình phụ thuộc OpenZeppelin Contracts v5
└── README.md                           # Tài liệu giới thiệu tổng quan đồ án HCE-ScholarProof
```

---
*Dự án được xây dựng và phát triển theo chuẩn quy ước [AGENTS.md](./AGENTS.md) của học phần ECO2432 — Trường Đại học Kinh tế, Đại học Huế.*

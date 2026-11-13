# HCE-ScholarProof — Nền tảng Ghi nhận & Bảo chứng Quyền tác giả Ý tưởng Nghiên cứu Khoa học trên Blockchain

> **Đồ án Capstone môn học:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
> **Khoa:** Hệ thống Thông tin Kinh tế — Trường Đại học Kinh tế, Đại học Huế  
> **Giảng viên hướng dẫn:** TS. Hà Ngọc Long  
> **Kho lưu trữ chính thức:** [https://github.com/lehuy10012005-cmd/HCE-ScholarProof](https://github.com/lehuy10012005-cmd/HCE-ScholarProof)  
> **Website DApp trực tuyến (Live Demo - Vercel Production):** [https://chungnhanquyentacgia.vercel.app/](https://chungnhanquyentacgia.vercel.app/)  
> **Cổng Quản trị Admin (Hội đồng Thẩm định):** [https://chungnhanquyentacgia.vercel.app/admin.html](https://chungnhanquyentacgia.vercel.app/admin.html)  
> **Lưu trữ dữ liệu website (Supabase):** `copychain_works` & Supabase Storage `copychain_files`

---

## 👥 Nhóm sinh viên thực hiện (Cặp 2 sinh viên)

| STT | Họ và tên sinh viên | Mã sinh viên | Lớp | Vai trò dự án | Email |
| :---: | :--- | :---: | :---: | :--- | :--- |
| 1 | **Lê Văn Quang Huy** | `23K4300010` | K57 Kinh Tế Số | **Trưởng nhóm** / Kỹ sư Hợp đồng Thông minh & Đặc tả Nghiệp vụ | `lehuy10012005@gmail.com` |
| 2 | **Lại Vương Gia Bảo** | `23K4300024` | K57 Kinh Tế Số | **Thành viên cặp** / Kỹ sư Kiểm thử Tự động & Giao diện Web3 DApp | `bao9d4tpsh@gmail.com` |

---

## 🎯 Giới thiệu Đề tài Đồ án Capstone

* **Chủ đề lựa chọn:** **Chủ đề 8 — Ghi nhận quyền tác giả của ý tưởng nghiên cứu khoa học (Proof of Authorship & Idea Timestamping)**  
  *(Căn cứ theo danh mục 10 chủ đề tại Phần N, Trang 48–49 — Sổ tay thực hành ECO2432)*
* **Tên sản phẩm:** **HCE-ScholarProof** (Thương hiệu thực nghiệm: **HCE LEDGER**)
* **Tuyên ngôn định vị giá trị (Value Proposition):**
  > *“Nhóm sinh viên phát triển nền tảng DApp phi tập trung HCE-ScholarProof giúp sinh viên và giảng viên bảo hộ quyền sở hữu trí tuệ sơ khởi cho ý tưởng nghiên cứu khoa học, đề tài khoá luận bằng chứng minh sự tồn tại (Proof of Existence) và dấu thời gian khối (Block Timestamp) bất biến trên Blockchain Sepolia, giảm thiểu 100% rủi ro đạo văn và tranh chấp học thuật với chi phí lưu trữ tối ưu thông qua cơ chế băm nhị phân client-side.”*
* **Địa chỉ Hợp đồng Thông minh chính thức (Sepolia Testnet):**  
  [`0x56fEF9eD4EeC61b0a1E7BF7A179a58d61dE6c9E7`](https://sepolia.etherscan.io/address/0x56fEF9eD4EeC61b0a1E7BF7A179a58d61dE6c9E7)
* **Kho lưu trữ tệp đám mây công khai (Supabase Storage):** `copychain_files` (Hỗ trợ đọc trực tuyến & tải tệp gốc)

---

## 💡 Tổng quan Nghiệp vụ: Bài toán Thực tiễn, Triết lý Web3 & Các Tính năng Cốt lõi trên Web

### 1. Tại sao cần Blockchain? Bài toán Thực tiễn trong Môi trường Đại học
Trong nghiên cứu khoa học và đào tạo đại học, việc bảo vệ ý tưởng sơ khởi luôn gặp các rào cản cố hữu:
* **Ngăn chặn nạn "nẫng tay trên" ý tưởng (Scooping Risk):** Khi sinh viên báo cáo ý tưởng trong seminar, nộp đề cương nghiên cứu hoặc thi khởi nghiệp, rủi ro bị sao chép ý tưởng trước ngày công bố/bảo vệ chính thức là rất lớn mà không có bằng chứng pháp lý chứng minh ai là người sáng tạo đầu tiên.
* **Hạn chế của Cơ sở dữ liệu truyền thống (Centralized DB):** Nếu chỉ lưu trên máy chủ web trường hoặc ổ đĩa đám mây (Google Drive/OneDrive), dữ liệu mốc thời gian (timestamp) hoàn toàn có thể bị chỉnh sửa, ghi đè hoặc can thiệp bởi quản trị viên hệ thống.
* **Giải pháp Bất biến từ Blockchain:** Blockchain đóng vai trò như một **"Công chứng viên kỹ thuật số phi tập trung"**. Bằng việc đóng dấu thời gian khối (**Block Timestamp**) trên mạng Ethereum Sepolia, một khi giao dịch đã vào khối thì **không một ai (kể cả tác giả hay nhà trường) có thể quay ngược thời gian để sửa đổi**. Điều này xác lập nguyên tắc quyền ưu tiên tuyệt đối: **Ai nộp trước dù chỉ 1 giây cũng là người đầu tiên (*First-to-Invent*)**.

### 2. Triết lý Thiết kế: Bảo vệ Nội dung Tuyệt đối & Tối ưu Chi phí Gas
* **Băm mật mã tại trình duyệt (Client-Side Cryptographic Hashing):**  
  File tài liệu gốc (PDF, Word, Code) **không bao giờ bị tải nguyên bản lên Blockchain**. Trình duyệt của sinh viên tự động băm tài liệu thành chuỗi đại diện 32-byte duy nhất (`Keccak-256` và `SHA-256`).
* **Bảo mật nghiên cứu sơ khởi:** Tệp bài viết gốc vẫn nằm an toàn trên máy tính của tác giả, hoàn toàn không bị rò rỉ nội dung bí mật công nghệ trước ngày bảo vệ.
* **Tối ưu chi phí kinh tế:** Lưu 1MB dữ liệu thô lên blockchain tốn hàng chục ngàn USD, nhưng lưu chuỗi băm 32-byte chỉ tiêu tốn định mức gas tối thiểu (~48.000 gas), giúp hệ thống vận hành bền vững với chi phí gần như bằng 0.
* **Hiệu ứng Tuyết lở (Avalanche Effect):** Thuật toán băm một chiều đảm bảo tính toàn vẹn tuyệt đối: Nếu tài liệu bị can thiệp dù chỉ thêm một dấu cách hay một ký tự, mã băm sinh ra sẽ thay đổi 100%, lập tức làm vô hiệu hóa bằng chứng giả mạo.

### 3. Trải nghiệm 4 Trụ cột Nghiệp vụ trên Giao diện Web DApp (`index.html`)

Hệ thống được thiết kế theo giao diện phẳng, hiện đại và trực quan để sinh viên, giảng viên có thể thao tác dễ dàng qua 4 trụ cột chức năng:

1. **Quy trình Đăng ký Ý tưởng 6 Bước (Wizard Step-by-Step):**
   * *Bước 1 (Thông tin tác phẩm):* Khai báo tên đề tài, mô tả tóm tắt, chọn Khoa/Viện chuyên môn trực thuộc HCE.
   * *Bước 2 (Tác giả & Quyền sở hữu):* Minh bạch hóa vai trò và phân chia tỷ lệ đóng góp (ví dụ: Chủ nhiệm đề tài 60%, Đồng tác giả 40%) kèm chữ ký ví của các thành viên nhóm.
   * *Bước 3 & 4 (Băm file & Kiểm tra dữ liệu):* Kéo thả tệp đề tài, trình duyệt tự động băm mã và hiển thị đối soát thông tin trước khi ký.
   * *Bước 5 (Ký số Blockchain):* Kết nối ví MetaMask, ký số thông điệp xác thực quyền tác giả và phát sóng giao dịch lên Sepolia.
   * *Bước 6 (Hoàn tất & Cấp mã):* Cấp mã lưu trữ chính thức (dạng `CC-2026-xxxx`), số khối on-chain và liên kết kiểm tra trên Sepolia Etherscan.

2. **Sổ cái Công trình On-Chain Công khai (Ledger Explorer):**
   * Bảng danh mục công khai hiển thị toàn bộ các công trình học thuật đã được bảo chứng theo thời gian thực.
   * Minh bạch hóa số khối (#Block), ngày giờ đóng dấu, tên tác giả, đơn vị đào tạo và mã băm mật mã.
   * Tích hợp bộ lọc đa tiêu chí theo từng Khoa và công cụ tìm kiếm tức thời.

3. **Trung tâm Đối soát Tính Toàn vẹn Độc lập (Zero-Knowledge Integrity Verification):**
   * Bất kỳ ai (nhà tuyển dụng, hội đồng đánh giá, tạp chí khoa học) chỉ cần kéo thả file bài viết cần kiểm tra vào trang:
     - **Nếu tài liệu nguyên bản:** Hệ thống lập tức báo xanh ✅ *"TÀI LIỆU TOÀN VẸN & CHÍNH GỐC"* kèm thông tin tác giả và dấu thời gian khối.
     - **Nếu tài liệu đã bị chỉnh sửa/đạo văn:** Hệ thống báo đỏ ❌ *"MÃ BĂM KHÔNG KHỚP / TÀI LIỆU ĐÃ BỊ THAY ĐỔI"*.
   * Người thẩm định hoàn toàn không cần đăng nhập hay tạo tài khoản, đảm bảo tính công khai, minh bạch và khách quan.

4. **Chứng thư Quyền Tác giả & Thư viện Số Học thuật:**
   * Tự động xuất **Thẻ Chứng thư Số** trang trọng có đầy đủ thông tin đề tài, mã băm mật mã, liên kết Sepolia và mã QR tra cứu di động.
   * Tích hợp Thư viện số đám mây (Supabase Storage) cho phép đọc trực tuyến tệp toàn văn PDF và tải tệp gốc để đối soát.

### 4. Cổng Quản Trị Hội Đồng Thẩm Định & Chế Tài On-Chain (`admin.html`)

Nhằm hoàn thiện chu trình khép kín giữa **Sinh viên (Người nộp)** và **Nhà trường / Hội đồng Thẩm định (Cơ quan chủ quản)**, phân hệ Quản trị ([`admin.html`](https://chungnhanquyentacgia.vercel.app/admin.html)) cung cấp 5 nghiệp vụ điều hành và chế tài học thuật chuyên sâu:

1. **Giám sát Sổ cái Đề tài & Đọc Toàn văn Trực tiếp (Academic Auditing):**
   * Hiển thị bảng điều khiển tập trung toàn bộ đề tài học thuật đã nộp vào hệ thống theo thời gian thực.
   * Tích hợp khung đọc trực tuyến tệp nghiên cứu PDF/DOCX từ Supabase Storage và công cụ đối soát tính hợp lệ của mã băm `docHash` (Keccak-256) với dữ liệu đã neo trên khối Sepolia.

2. **Chế tài Thu hồi Quyền Tác giả On-Chain khi Vi phạm Đạo văn (Revocation Mechanism):**
   * Khi Hội đồng phát hiện đề tài sao chép, đạo văn hoặc gian lận khoa học, Quản trị viên sử dụng ví Chủ sở hữu (Owner) thực hiện ký giao dịch thu hồi on-chain (`revokeDocument`).
   * Sự kiện thu hồi được ghi nhận bất biến lên Sepolia, lập tức kích hoạt cơ chế **Academic Integrity Guard**: Toàn bộ hệ thống Client DApp (`index.html`) tự động phát hiện và khóa tài khoản sinh viên vi phạm, hiển thị thanh cảnh báo đỏ đình chỉ quyền nộp đề tài mới nhằm bảo vệ liêm chính học thuật.

3. **Cơ chế Phục hồi Quyền Học thuật & Mở khóa Tài khoản On-Chain (Reinstatement & Unlocking):**
   * Sau khi sinh viên hoàn thành thủ tục khiếu nại, phúc khảo hoặc nộp giải trình minh oan được Hội đồng phê chuẩn, Quản trị viên kích hoạt tính năng **[🔓 Mở Khóa Tài Khoản]** trực tiếp trên cổng Admin.
   * Thao tác xác thực qua chữ ký ví MetaMask và phát sóng giao dịch mở khóa on-chain lên Sepolia, đồng thời cập nhật trạng thái phục hồi trên Supabase và phát tín hiệu đồng bộ thời gian thực (`real-time event`), tự động gỡ bỏ lệnh đình chỉ và khôi phục toàn bộ quyền nghiên cứu cho sinh viên trên giao diện Client.

4. **Cấp phát & Quản trị Chứng chỉ Đào tạo Học thuật On-Chain (Academic Credentials):**
   * Hội đồng có thẩm quyền phát hành Chứng chỉ nghiên cứu khoa học / Chứng nhận bản quyền chính thức (`issueCertificate`).
   * Chứng chỉ được mã hóa định danh, gắn kèm mã băm sinh viên và liên kết vĩnh viễn trên sổ cái Sepolia, ngăn chặn hoàn toàn tình trạng làm bằng giả hoặc giả mạo chứng chỉ số.

5. **Quản trị Quỹ Ngân sách & Rút Phí Thẩm định (Treasury Governance):**
   * Hợp đồng thông minh thiết lập cơ chế thu phí dịch vụ minh bạch (`0.0001 ETH`/lượt đăng ký) nhằm trang trải chi phí duy trì mạng lưới và thù lao hội đồng thẩm định.
   * Giao diện Admin tích hợp bảng đối soát số dư quỹ on-chain theo thời gian thực và nút chức năng **"Rút Quỹ Ngân Sách"** (`withdrawFees`). Giao dịch tuân thủ nghiêm ngặt mô hình **Checks-Effects-Interactions (CEI)**, chỉ cho phép ví Owner rút toàn bộ số dư ETH về ví ngân sách an toàn, ngăn chặn 100% tấn công tái thâm nhập (Reentrancy Attack).

---

## 📂 Danh mục sản phẩm & Lộ trình triển khai Đồ án (Lab 8 – 15+)

| Giai đoạn | Sản phẩm bàn giao | Mô tả nghiệp vụ & Kỹ thuật | Trạng thái |
| :---: | :--- | :--- | :---: |
| **Lab 8** | [`TOPIC_REGISTRATION.md`](./TOPIC_REGISTRATION.md)<br>[`lab08.md`](./lab08.md)<br>[`ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) | Khởi động đồ án Chủ đề 8, thiết lập cơ chế Proof of Existence, băm mật mã client-side, thiết kế Smart Contract & bộ 3 ca kiểm thử | ✅ **Hoàn thành** |
| **Lab 9** | [`SPEC.md`](./SPEC.md)<br>[`lab09.md`](./lab09.md)<br>[`contracts/training/TimeLockVault.sol`](./contracts/training/TimeLockVault.sol) | Đặc tả nghiệp vụ BA chi tiết cho nền tảng ScholarProof, máy trạng thái xác thực ý tưởng và ma trận rủi ro | ✅ **Hoàn thành** |
| **Lab 10** | [`lab10.md`](./lab10.md)<br>[`contracts/capstone/ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) (v2)<br>[`contracts/project/ProjectCore.sol`](./contracts/project/ProjectCore.sol) | Rà soát mã nguồn do AI sinh ra, giải mã Storage Slot 2 (VaultBuggy), kiểm toán & nâng cấp ScholarProof v2 | ✅ **Hoàn thành** |
| **Lab 11** | [`web/index.html`](./web/index.html)<br>[`lab11.md`](./lab11.md) | Xây dựng giao diện Web3 DApp: Băm file client-side (Keccak-256), kết nối MetaMask Ethers.js v6, tra cứu và xuất chứng thư số | ✅ **Hoàn thành** |
| **Lab 12** | [`test/ScholarProof.test.js`](./test/ScholarProof.test.js)<br>[`contracts/test/ScholarProof_test.sol`](./contracts/test/ScholarProof_test.sol)<br>[`lab12.md`](./lab12.md) | Bộ kịch bản kiểm thử tự động toàn diện: Luồng chuẩn, chống gian lận nộp đè mã băm, xử lý ngoại lệ biên (Chạy: `node test/ScholarProof.test.js`) | ✅ **Hoàn thành** |
| **Lab 13** | [`web/index.html`](./web/index.html) (Tích hợp Sepolia Testnet)<br>[`lab13.md`](./lab13.md)<br>[`AI_JOURNAL.md`](./AI_JOURNAL.md) | Tích hợp địa chỉ hợp đồng deploy Sepolia, xác thực mã nguồn Etherscan, kiểm thử luồng ký ví và đối soát sự kiện on-chain | ✅ **Hoàn thành** |
| **Lab 14** | [`audit_report.md`](./audit_report.md)<br>[`lab14.md`](./lab14.md)<br>[`scripts/gas_benchmark.py`](./scripts/gas_benchmark.py) | Kiểm toán an toàn hợp đồng, đo lường chi phí Gas thực nghiệm trên Layer 2 Base/Arbitrum vs Sepolia Testnet | ✅ **Hoàn thành** |
| **Lab 15** | [`DEPLOYMENT.md`](./DEPLOYMENT.md)<br>[`SLIDES.md`](./SLIDES.md)<br>[`DAPP_AI_SUPERVISION_JOURNAL.md`](./DAPP_AI_SUPERVISION_JOURNAL.md)<br>[`lab15.md`](./lab15.md) | Tài liệu hướng dẫn vận hành, nhật ký thực chiến giám sát AI & bằng chứng kiểm thử Web DApp, slide thuyết trình nghiệm thu trước hội đồng | ✅ **Hoàn thành** |
| **Nâng cấp** | [`supabase_schema.sql`](./supabase_schema.sql)<br>[`web/index.html`](./web/index.html) | Tích hợp Thư viện Số Cổng HCE: Lưu trữ đám mây Supabase Storage (`copychain_files`), In-app PDF Viewer, Tải tệp gốc & Đối soát toàn vẹn | ✅ **Hoàn thành** |
| **Quản trị & Mở rộng** | [`web/admin.html`](./web/admin.html)<br>[`contracts/capstone/ScholarProof.sol`](./contracts/capstone/ScholarProof.sol) | Cổng Quản trị Admin: Giám sát đề tài, thu hồi do đạo văn, mở khóa tài khoản on-chain, cấp chứng chỉ & rút quỹ ngân sách thẩm định | ✅ **Hoàn thành** |

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
│   ├── index.html                      # Giao diện Web3 DApp: Đăng ký ý tưởng 6 bước, Tra cứu sổ cái & Kiểm tra toàn vẹn
│   └── admin.html                      # Cổng Quản trị Admin: Giám sát đề tài, thu hồi do đạo văn, mở khóa on-chain & rút quỹ
├── test/
│   └── ScholarProof.test.js            # Bộ kịch bản kiểm thử tự động toàn diện (Chạy: node test/ScholarProof.test.js)
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

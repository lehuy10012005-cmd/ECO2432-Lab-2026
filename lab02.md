# BÁO CÁO THỰC HÀNH LAB 2: VÍ VÀ GIAO DỊCH ĐẦU TIÊN
**Học phần:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
**Sinh viên thực hiện:** Lê Huy  
**Mã nguồn / Repo:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)  
**Địa chỉ ví cá nhân (Sepolia):** `0xB07FB0761c33a01F7f7493A6a8a9667F4842Fd50`

---

## 1. Bảng đối chiếu giao dịch on-chain

| Trường dữ liệu | Giao dịch 1: Chuyển tiền thành công | Giao dịch 2: Cố tình làm thất bại (Sai Checksum) | Giao dịch bổ sung: Cảnh báo Address Poisoning |
| :--- | :--- | :--- | :--- |
| **Mã băm giao dịch (Tx Hash)** | `0x012b71a61a33cf554ffbda91ff2a2b679ef5339adb10fa21bc7fefc13b1c9440` | **Không có (N/A)** | `0xdfcb9f3cce3e8a8431af94d72b1641beb74c4aff514cd99a369cfcb2eb4c276c` |
| **Ví gửi (From)** | `0xb07fb0761c33a01f7f7493a6a8a9667f4842fd50` | `0xb07fb0761c33a01f7f7493a6a8a9667f4842fd50` | `0xb07fb0761c33a01f7f7493a6a8a9667f4842fd50` |
| **Ví nhận (To)** | `0x2f801534de966088dc2133d190e99f4f3b2da35a` | Địa chỉ bị sửa 1 ký tự | `0x8df875b39c6e037717f8ef1556ee55fe0f38360b` |
| **Số tiền chuyển** | `0.01 Sepolia ETH` | `0.01 Sepolia ETH` | `0.01 Sepolia ETH` |
| **Gas Limit / Gas Used** | `21,000 / 21,000 (100%)` | `0` | `21,000 / 21,000 (100%)` |
| **Đơn giá Gas (Effective Gas Price)** | `~2.487 Gwei (0x94470edb)` | `0 Gwei` | `~2.471 Gwei (0x93543d69)` |
| **Phí giao dịch thực trả (Tx Fee)** | `0.00005224 Sepolia ETH` | `0 ETH` | `0.00005191 Sepolia ETH` |
| **Khối xác nhận (Block Number)** | `11779474 (0xb3bd92)` | Chưa vào hàng đợi mempool | `11779517 (0xb3bdbd)` |
| **Trạng thái (Status)** | **Confirmed / Success (0x1)** | **Rejected by Wallet Client** | **Confirmed / Success (0x1)** |
| **Nguyên nhân / Hiện tượng** | Giao dịch hợp lệ, được mạng Sepolia đóng gói thành công. | MetaMask phát hiện sai mã kiểm tra **EIP-55 Checksum**, khóa nút gửi, chặn phát sóng giao dịch. | MetaMask gắn cờ đỏ `⚠️ Đã bị đầu độc` (Address Poisoning), cảnh báo địa chỉ lừa đảo. |

---

## 2. Đoạn giải trình nghiệp vụ kế toán & quản trị rủi ro on-chain

> **Câu hỏi trọng tâm:** *Nếu bạn chuyển nhầm tiền cho người lạ trên blockchain, có lấy lại được không? Vì sao?*

1. **Kết luận:** Nếu chuyển nhầm tài sản số cho một địa chỉ ví lạ trên blockchain, bạn **hoàn toàn KHÔNG THỂ tự lấy lại được tiền**.
2. **Nguyên nhân kỹ thuật & cơ chế vận hành:** Blockchain hoạt động theo cơ chế đồng thuận phân tán với đặc tính **bất biến (Immutability)** và **tính thanh toán cuối cùng (Finality)**: Một khi giao dịch đã được các validator đóng gói vào khối và xác nhận on-chain, không có bất kỳ cơ quan quản lý, ngân hàng hay tổ chức trung gian nào (kể cả đội ngũ phát triển ví MetaMask hay các nhà sáng lập Ethereum) có quyền can thiệp để đảo ngược (reverse) sổ cái hoặc thực hiện hoàn trả (chargeback) như hệ thống ngân hàng truyền thống.
3. **Góc nhìn Quản trị rủi ro & Kế toán On-chain:** Dưới góc độ quản trị dòng tiền, tài sản chỉ có thể được hoàn lại nếu người nhận tự nguyện ký một giao dịch mới gửi trả; tuy nhiên, do tính chất ẩn danh (pseudonymous), doanh nghiệp gần như không thể xác định danh tính chủ sở hữu ngoài đời thực để thực hiện đối soát ngoại bảng (off-chain reconciliation). Vì vậy, bài học kiểm soát rủi ro bắt buộc đối với kế toán Web3 là phải luôn có quy trình chuyển thử nghiệm (test transaction) số tiền nhỏ trước khi giải ngân dòng tiền lớn.

---

## 3. Bài học thực tiễn rút ra từ thực nghiệm

* **Về cơ chế EIP-55 Checksum:** Địa chỉ ví Ethereum phân biệt chữ hoa/chữ thường để tự kiểm tra lỗi chính tả khi người dùng gõ nhầm. Nếu sai checksum, ví người dùng (client-side) sẽ chặn ngay lập tức, giúp người dùng không bị mất phí gas vô ích. Tuy nhiên, Checksum **chỉ chống gõ sai cú pháp, không chống chuyển nhầm cho kẻ xấu** nếu địa chỉ đó vẫn đúng cú pháp.
* **Về thủ đoạn Address Poisoning (Đầu độc địa chỉ ví):** Kẻ tấn công thường tạo ví có các ký tự đầu và cuối tương tự ví của đối tác để dụ người dùng sao chép từ lịch sử giao dịch. Do đó, người làm tài chính phải đối chiếu tối thiểu toàn bộ các cụm ký tự giữa và không được sao chép vội vàng từ lịch sử giao dịch.

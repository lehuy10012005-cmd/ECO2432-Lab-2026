# BÁO CÁO ĐIỀU TRA ON-CHAIN: LAB 3 — ĐỌC GIAO DỊCH VÀ HỢP ĐỒNG TRÊN ETHERSCAN
**Học phần:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
**Sinh viên thực hiện:** Lê Huy  
**Mã nguồn / Repo:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)  
**Địa chỉ ví cá nhân (Sepolia):** `0xB07FB0761c33a01F7f7493A6a8a9667F4842Fd50`

---

## Phần 1: Mổ xẻ 8 trường dữ liệu giao dịch on-chain thực tế của sinh viên

* **Mã băm giao dịch phân tích (Tx Hash):** [`0x012b71a61a33cf554ffbda91ff2a2b679ef5339adb10fa21bc7fefc13b1c9440`](https://sepolia.etherscan.io/tx/0x012b71a61a33cf554ffbda91ff2a2b679ef5339adb10fa21bc7fefc13b1c9440)
* **Mạng thử nghiệm:** Sepolia Testnet

| STT | Tên trường | Giá trị thực tế trên Etherscan | Ý nghĩa kỹ thuật | Vì sao người làm nghiệp vụ kế toán / tuân thủ cần quan tâm? |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **Status** | `Success (0x1)` | Trạng thái thực thi giao dịch trên máy ảo EVM. | Xác định dòng tiền đã được ghi nhận vào sổ cái hay chưa. **Lưu ý:** Giao dịch thất bại (`Failed / Reverted`) người gửi vẫn bị mất phí gas, kế toán vẫn phải định khoản chi phí này vào chi phí vận hành. |
| **2** | **Block** | `11779474` | Số thứ tự của khối chứa giao dịch trên chuỗi. | Xác định số xác nhận (confirmations) để đảm bảo tính an toàn chống chi tiêu kép (double spending); là căn cứ đối soát số thứ tự chứng từ kế toán on-chain. |
| **3** | **Timestamp** | `Sep-25-2026 01:19:36 PM UTC` | Dấu mốc thời gian khối được validator đóng gói. | Căn cứ xác định kỳ kế toán, tỷ giá quy đổi tài sản số sang tiền pháp định (VND/USD) tại đúng thời điểm phát sinh nghĩa vụ thuế / doanh thu. |
| **4** | **From / To** | **From:** `0xb07fb...2fd50`<br>**To:** `0x2f801...da35a` | Địa chỉ ví gửi và địa chỉ ví thụ hưởng. | Phục vụ công tác định danh đối tác (KYC/AML), thẩm tra danh sách cấm (Sanction List/OFAC), đối chiếu tài khoản công nợ phải thu / phải trả. |
| **5** | **Value** | `0.01 Sepolia ETH` | Lượng tài sản gốc chuyển giao giữa hai ví. | Giá trị giao dịch kinh tế chính, cơ sở ghi nhận biến động số dư tài sản trên bảng cân đối kế toán. |
| **6** | **Transaction Fee** | `0.00005224 Sepolia ETH` | Chi phí thực tế người gửi phải trả cho mạng lưới (`Gas Used × Effective Gas Price`). | Hạch toán vào tài khoản chi phí giao dịch mạng lưới (tương đương phí chuyển khoản ngân hàng nhưng biến động linh hoạt). |
| **7** | **Gas Price** | `2.4877 Gwei (0.0000000024877 ETH)` | Đơn giá cho mỗi đơn vị tính toán gas tại thời điểm giao dịch. | Giải thích nguyên nhân biến động chi phí: Khi mạng tắc nghẽn, đơn giá gas tăng vọt làm đội chi phí vận hành doanh nghiệp. |
| **8** | **Nonce** | `34` | Số thứ tự giao dịch lũy tiến xuất phát từ ví gửi (bắt đầu từ 0). | Đảm bảo tính tuần tự, chống tấn công phát lại (Replay attack). Giúp kiểm toán viên phát hiện các giao dịch bị nhảy cóc (nonce gap) hoặc giao dịch bị hủy/thay thế. |

---

## Phần 2: Thẩm định hợp đồng thông minh thực tế (USDT - Tether USD trên Ethereum Mainnet)

* **Địa chỉ hợp đồng (Contract Address):** [`0xdAC17F958D2ee523a2206206994597C13D831ec7`](https://etherscan.io/token/0xdac17f958d2ee523a2206206994597c13d831ec7)
* **Tiêu chuẩn:** ERC-20 (decimals = 6)

### 1. Phân biệt Bytecode và Verified Source Code
* **Bytecode:** Là chuỗi mã nhị phân dạng Hex (`0x6080604052600436...`) mà máy ảo EVM nạp và thực thi trực tiếp. Bytecode hoàn toàn không thể đọc hiểu đối với con người.
* **Source Code (Verified):** Là mã nguồn viết bằng ngôn ngữ bậc cao (Solidity) do nhà phát hành công khai trên Etherscan và được trình biên dịch đối soát trùng khớp 100% với Bytecode đang chạy.
* **Góc nhìn rủi ro:** Nếu một dự án phát hành token không xác thực mã nguồn (Unverified Contract), người làm thẩm định rủi ro phải xếp dự án vào diện **CỰC KỲ NGUY HIỂM / DẤU HIỆU LỪA ĐẢO**, vì mã nguồn ẩn giấu có thể chứa mã độc rút cạn ví hoặc bẫy thanh khoản.

### 2. Trả lời 3 câu hỏi nghiệp vụ bắt buộc

#### Câu 1: Hợp đồng bạn xem có công bố mã nguồn đã xác thực không?
* **Trả lời:** **CÓ**. Hợp đồng Tether USD trên Etherscan hiển thị biểu tượng **dấu tích xanh (Contract Source Code Verified)** với phiên bản trình biên dịch `v0.4.18+commit.9cf6e910`.

#### Câu 2: Tổng cung của đồng đó là bao nhiêu? Đọc ra từ hàm nào?
* **Hàm đọc dữ liệu:** Hàm **`totalSupply()`** trong tab **Read Contract**.
* **Kết quả truy vấn trực tiếp:**
  * Giá trị nguyên thô (Raw uint256): `88,304,342,264,551,152`
  * Đơn vị quy đổi (Decimals = 6): Số thực lưu hành = `88,304,342,264,551,152 / 10^6`
  * **Tổng cung thực tế:** **~88,304,342,264.55 USDT** (Hơn **88.3 tỷ USD** đang lưu hành trên mạng chính Ethereum).

#### Câu 3: Trong tab Write Contract, có hàm nào cho phép một địa chỉ đặc biệt đóng băng tài khoản người khác không? Nếu có, tên hàm là gì?
* **Trả lời:** **CÓ! Hợp đồng USDT chứa cơ chế đóng băng tài khoản tập trung rất mạnh mẽ.**
* **Tên các hàm đặc quyền trong tab Write Contract:**
  1. **`addBlackList(address _evilUser)`:** Cho phép chủ sở hữu hợp đồng (`owner`) đưa bất kỳ địa chỉ ví nào vào danh sách đen (Blacklist). Khi bị vào danh sách đen, ví đó bị **khóa hoàn toàn quyền chuyển và nhận USDT**.
  2. **`removeBlackList(address _clearedUser)`:** Quyền gỡ bỏ lệnh đóng băng.
  3. **`destroyBlackFunds(address _blackListedUser)`:** Quyền tiêu hủy vĩnh viễn toàn bộ số dư USDT có trong ví bị đóng băng.

---

## Phần 3: Thảo luận chuyên sâu về mức độ phi tập trung thực tế (Ý nghĩa kinh tế & Pháp lý)

Phát hiện ở Câu 3 là minh chứng rõ nhất cho bản chất của các đồng tiền ổn định giá (Stablecoin) lớn hiện nay:

1. **Mức độ phi tập trung thực tế (Centralization Reality):** Mặc dù chạy trên hạ tầng phi tập trung của Ethereum, USDT **KHÔNG HỀ phi tập trung về mặt kiểm soát tài sản**. Tổ chức Tether Limited nắm giữ chiếc "chìa khóa vạn năng" (Admin Key) có quyền tịch thu hoặc đóng băng tài sản của bất kỳ người dùng nào theo yêu cầu của cơ quan tư pháp (như FBI, DoJ, Interpol) hoặc theo quyết định đơn phương của họ.
2. **Bài học cho Doanh nghiệp & Kế toán Web3:**
   * Doanh nghiệp sử dụng USDT để thanh toán quốc tế phải đối mặt với **Rủi ro kiểm duyệt (Censorship Risk)**: Nếu doanh nghiệp vô tình nhận tiền từ một ví nằm trong luồng truy vết tội phạm (như máy trộn Tornado Cash), toàn bộ số dư USDT của doanh nghiệp có thể bị đóng băng vĩnh viễn.
   * Đây là lý do người làm tuân thủ luôn phải sàng lọc giao dịch (AML Screening) trước khi chấp nhận thanh toán on-chain.

# NHẬT KÝ LÀM VIỆC VỚI AI - LAB 1: THIẾT LẬP MÔI TRƯỜNG & QUY ƯỚC AGENTS.MD

## Lần 1

**Prompt:**
> "Tôi đã mở thư mục hce-web3-starter làm Workspace. Bây giờ hãy giúp tôi hoàn thành dứt điểm toàn bộ bài Lab 1:
> 1. Hãy tự động đọc và tinh chỉnh lại tệp AGENTS.md, thêm quy tắc cá nhân chuẩn cho tôi.
> 2. Tự mở Terminal hướng dẫn và chạy các lệnh Git (add, commit, push) để đẩy kho mã nguồn này lên GitHub cá nhân của tôi và lấy link commit nộp bài.
> 3. Nhắc tôi kiểm tra địa chỉ ví để hoàn tất sản phẩm nộp của Lab 1."

**AI trả về:**
- Tinh chỉnh phần "Quy tắc cá nhân của sinh viên" trong tệp `AGENTS.md` thành 4 điều khoản chi tiết: Ngôn ngữ & Diễn giải, Quản trị rủi ro & Kế toán On-chain, Kiểm thử nghiêm ngặt, An toàn bảo mật tài sản số.
- Tự động tạo kho lưu trữ `ECO2432-Lab-2026` trên GitHub cá nhân (`lehuy10012005-cmd`), chạy các lệnh Git (`init`, `add`, `commit`, `remote add`, `push`).
- Cung cấp link commit kiểm chứng và checklist kiểm tra ví MetaMask mạng Sepolia.

**Đánh giá:** Dùng được.

**Chỗ sai:**
Phần quy tắc cá nhân mặc định trước đó chỉ có 2 dòng sơ sài, thiếu định danh sinh viên (Lê Huy - ECO2432), chưa có quy tắc bảo mật khóa riêng (Private Key) và chưa gắn chặt với góc nhìn kiểm toán on-chain. Kho mã nguồn trên GitHub chưa được tạo trước đó khiến lệnh đẩy ban đầu không có đích đến.

**Cách sửa:**
Sinh viên yêu cầu AI đối chiếu Sổ tay môn học ECO2432 để viết lại bộ quy tắc thành 4 điều chuẩn mực; đồng thời tạo repo trống trên GitHub trước khi push mã nguồn.

**Ai phát hiện:** Sinh viên phát hiện.

## Lần 2 (Lab 2: Ví và giao dịch đầu tiên)

**Prompt:**
> "địa chỉ ví : 0xB07FB0761c33a01F7f7493A6a8a9667F4842Fd50 mã băm của giao dịch thành công : 0x012b71a61a33cf554ffbda91ff2a2b679ef5339adb10fa21bc7fefc13b1c9440 mã băm giao dịch không thành công ( hoặc thành công) : 0xdfcb9f3cce3e8a8431af94d72b1641beb74c4aff514cd99a369cfcb2eb4c276c cố tình sửa 1 kí tự ở ví người nhận thì nó không cho chuyển qua trạng thái này ( cái này tôi chưa hiểu lắm mà đúng không)"

**AI trả về:**
- Giải thích bản chất kỹ thuật của giao dịch `0xdfcb...276c`: Đã thành công on-chain nhưng từng bị MetaMask cảnh báo đỏ "Đã bị đầu độc" (Address Poisoning).
- Giải thích lý do khi cố tình sửa 1 ký tự ví người nhận thì MetaMask lập tức khóa nút gửi: Do cơ chế mã kiểm tra EIP-55 Checksum tự động phát hiện lỗi chính tả ngay tại lớp ứng dụng (client-side), giúp người dùng không tốn phí gas vô ích.
- Tạo báo cáo `lab02.md` gồm bảng đối chiếu dữ liệu on-chain thực tế và đoạn giải trình 3 câu về tính bất biến (Immutability) của blockchain dưới góc nhìn kế toán và quản trị rủi ro.

**Đánh giá:** Dùng được.

**Chỗ sai:**
Ban đầu sinh viên nhầm lẫn giao dịch `0xdfcb...276c` là giao dịch thất bại do nhìn thấy cảnh báo đỏ `⚠️ Đã bị đầu độc` trên MetaMask, và chưa phân biệt được giữa việc giao dịch thất bại on-chain (revert/out of gas) với việc bị ví chặn ngay từ giao diện do sai Checksum (chưa hề được phát sóng lên mạng nên không có Tx Hash).

**Cách sửa:**
AI tra cứu trực tiếp biên lai (receipt) từ mạng Sepolia RPC để chứng minh giao dịch thực tế đã Confirmed, đồng thời phân tích cơ chế bảo mật EIP-55 Checksum và thủ đoạn gian lận Address Poisoning theo đúng chuẩn nghiệp vụ tuân thủ AML.

**Ai phát hiện:** Sinh viên phát hiện hiện tượng bất thường và chủ động hỏi AI đối soát dữ liệu on-chain.

## Lần 3 (Lab 3: Đọc giao dịch và hợp đồng trên Etherscan)

**Prompt:**
> "rồi ok qua Lab 3 , cứ theo trình tự vậy"

**AI trả về:**
- Mổ xẻ chi tiết 8 trường dữ liệu on-chain của giao dịch `0x012b...9440` (Status, Block, Timestamp, From/To, Value, Tx Fee, Gas Price, Nonce) gắn với góc nhìn kế toán tài sản số và điều tra tuân thủ (AML/KYC).
- Thẩm định hợp đồng thực tế USDT trên Ethereum Mainnet (`0xdAC17F958D2ee523a2206206994597C13D831ec7`): phân biệt Bytecode và Verified Code, truy vấn trực tiếp tổng cung (~88.3 tỷ USDT) qua hàm `totalSupply()`.
- Phát hiện và phân tích quyền đóng băng tài khoản tập trung qua hàm `addBlackList()` và `destroyBlackFunds()`, trả lời sâu sắc về mức độ phi tập trung thực tế và rủi ro kiểm duyệt (Censorship Risk).
- Tạo tệp sản phẩm nộp `forensics.md` và đồng bộ lên kho GitHub.

**Đánh giá:** Dùng được.

**Chỗ sai:**
Nhiều người dùng lầm tưởng các token trên blockchain đều phi tập trung hoàn toàn và không ai có thể can thiệp số dư. Nếu không đọc tab Write Contract của hợp đồng USDT, sinh viên sẽ không phát hiện ra nhà phát hành Tether có đặc quyền đóng băng địa chỉ ví và tiêu hủy tiền trong ví của người khác.

**Cách sửa:**
AI trực tiếp tra cứu mã nguồn đã xác thực của hợp đồng Tether trên Etherscan, chỉ rõ tên các hàm quản trị danh sách đen (`addBlackList`, `destroyBlackFunds`) và phân tích bài học quản trị rủi ro dòng tiền cho doanh nghiệp.

**Ai phát hiện:** Sinh viên định hướng yêu cầu AI phân tích rủi ro kiểm duyệt on-chain theo khung Sổ tay thực hành.

## Lần 4 (Lab 4: Nhận diện hợp đồng có rủi ro)

**Prompt:**
> "Bạn là chuyên viên thẩm định rủi ro tài sản số. Dưới đây là mã nguồn một hợp đồng token trong contracts/lab04/ClubTokens.sol. Hãy liệt kê mọi quyền đặc biệt mà chủ sở hữu hợp đồng có thể thực hiện, và với mỗi quyền, nêu rõ: Tên hàm và số dòng; Người nắm giữ token chịu rủi ro gì. Chỉ trả lời dựa trên mã nguồn tôi cung cấp. Nếu không tìm thấy, nói là không tìm thấy."

**AI trả về:**
- Thẩm định 3 hợp đồng mẫu `ClubTokenA`, `ClubTokenB`, `ClubTokenC` trong tệp `contracts/lab04/ClubTokens.sol`.
- Chỉ ra chính xác số dòng và cơ chế rủi ro:
  + `ClubTokenA` (dòng 7–11): Sạch, không có quyền đặc biệt.
  + `ClubTokenB` (dòng 18–20): Hàm `mint()` không có trần `MAX_SUPPLY`, rủi ro pha loãng vô hạn (Rug-pull).
  + `ClubTokenC` (dòng 30–32 và dòng 34–37): Hàm `setRestricted()` kết hợp logic chặn trong hàm `_update()`, tạo bẫy Honeypot (chỉ cho mua, không cho bán).
- Đưa ra đề xuất cải tiến mã nguồn và lập báo cáo chi tiết `lab04.md`.

**Đánh giá:** Dùng được.

**So sánh Đối chứng (Đọc thủ công vs AI) & Bắt lỗi AI:**
- **Đọc thủ công tìm ra gì:** Sinh viên đọc mã nguồn 15 phút đầu và phát hiện ngay hàm `mint` ở Token B có `onlyOwner` và biến `restricted` ở Token C dùng để chặn chuyển tiền.
- **AI tìm thêm được gì:** AI phân tích sâu hơn về mặt kỹ thuật: chỉ ra Token C vi phạm OpenZeppelin v5 ở chỗ can thiệp vào hàm `_update` nhưng không phát ra `event` khi gọi `setRestricted` (gây mù thông tin cho các bot cảnh báo on-chain), đồng thời chỉ ra thủ đoạn ngụy tạo lý do "bảo vệ cộng đồng" để che giấu bẫy Honeypot.
- **AI có nói sai chỗ nào không:** Ban đầu nếu không có câu ràng buộc *"Chỉ trả lời dựa trên mã nguồn tôi cung cấp"*, AI thường tự suy đoán hợp đồng có thể dính lỗi Reentrancy (dù đây là token ERC-20 thuần túy không có hàm chuyển ETH). Sinh viên đã dùng đúng mẫu prompt chuẩn trong `prompt_templates.md` để ép AI bám sát từng dòng mã cụ thể từ dòng 1 đến dòng 40.

**Ai phát hiện:** Sinh viên phát hiện và kiểm soát giới hạn suy diễn của AI.

## Lần 5 (Lab 5: Viết đặc tả cho công cụ phân tích dòng tiền)

**Prompt:**
> "Hãy giúp tôi hoàn thiện bản đặc tả nghiệp vụ SPEC.md cho công cụ phân tích dòng tiền ví on-chain trong 90 ngày theo đúng chuẩn BA Fintech (Sổ tay thực hành ECO2432, trang 15–16). Không viết code trong buổi này. Bổ sung đầy đủ 6 phần: Mục đích, Đầu vào, Quy tắc R1–R6, Đầu ra, Trường hợp ngoại lệ và Ngoài phạm vi, kèm quy tắc mở rộng cho tình huống tự chuyển tiền (Self-transfer)."

**AI trả về:**
- Bản đặc tả nghiệp vụ `SPEC.md` hoàn chỉnh gồm 6 phần cốt lõi và 7 quy tắc nghiệp vụ tài chính (R1–R7).
- Định nghĩa chặt chẽ cơ chế tính toán dòng tiền ra (`giá trị + phí gas`) và hạch toán phí gas của giao dịch thất bại.
- Bổ sung 4 ca biên ngoại lệ (Edge Cases E1–E4) về xử lý ví rỗng, lỗi xác thực API Etherscan, địa chỉ sai định dạng và cơ chế phân trang tự động khi vượt quá 10.000 giao dịch.

**Đánh giá:** Dùng được.

**Chỗ sai & Phản biện của sinh viên:**
Nếu chỉ mô tả chung chung "viết tool phân tích ví", AI thường bỏ qua việc giao dịch thất bại vẫn làm giảm số dư ví do tốn phí gas (vi phạm nguyên tắc bảo toàn số dư sổ cái), hoặc quên chia đơn vị 10^18 từ `wei` sang `ETH`. Sinh viên đã yêu cầu chuẩn hóa từng quy tắc R1–R7 độc lập có thể kiểm thử được (testable assertion) trước khi chuyển sang bước sinh mã ở Lab 6.

**Ai phát hiện:** Sinh viên định hình yêu cầu nghiệp vụ và giám sát cấu trúc đặc tả.






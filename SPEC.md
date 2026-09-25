# ĐẶC TẢ NGHIỆP VỤ: LAB 5 — CÔNG CỤ PHÂN TÍCH DÒNG TIỀN VÍ ON-CHAIN (90 NGÀY)
**Học phần:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
**Tác giả (BA):** Lê Huy  
**Mã nguồn / Repo:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)

---

## 1. Mục đích
Hệ thống tự động truy vấn dữ liệu từ sổ cái blockchain Ethereum qua Etherscan API để lập báo cáo dòng tiền vào/ra và trực quan hóa biến động số dư lũy kế trong 90 ngày gần nhất cho chuyên viên kế toán và kiểm toán tài sản số.

---

## 2. Đầu vào (Inputs)
- **`address` (Bắt buộc):** Địa chỉ ví cần phân tích, kiểu chuỗi ký tự (`string`), 42 ký tự hex bắt đầu bằng `0x`, do người dùng cung cấp.
- **`ETHERSCAN_API_KEY` (Bắt buộc):** Khóa xác thực truy cập API của Etherscan, kiểu chuỗi (`string`), bắt buộc đọc từ biến môi trường của hệ điều hành, tuyệt đối không ghi trực tiếp trong mã nguồn.
- **`days` (Tùy chọn):** Số ngày cần phân tích tính ngược từ thời điểm hiện tại, kiểu số nguyên dương (`uint`), giá trị mặc định là `90`.

---

## 3. Quy tắc nghiệp vụ (Business Rules)
- **R1 (Xác định Dòng tiền VÀO):** Giao dịch có trường `to` trùng khớp với địa chỉ ví đang xét được ghi nhận là dòng tiền VÀO (`Cash Inflow`). Giá trị ghi nhận = `value`.
- **R2 (Xác định Dòng tiền RA):** Giao dịch có trường `from` trùng khớp với địa chỉ ví đang xét được ghi nhận là dòng tiền RA (`Cash Outflow`).
- **R3 (Kế toán chi phí thực trừ):** Đối với giao dịch đi ra (người gửi là ví đang xét), tổng số tiền thực tế bị trừ khỏi số dư ví phải bằng: `Giá trị chuyển (value) + Phí giao dịch (gasUsed × gasPrice)`.
- **R4 (Xử lý giao dịch thất bại):** Giao dịch có trạng thái thất bại (`isError == "1"` hoặc `txreceipt_status == "0"`) vẫn bị mạng lưới trừ phí gas của người gửi (`from`). Do đó, hệ thống bắt buộc phải tính khoản phí gas này vào dòng tiền RA (`value = 0`, dòng tiền ra = `gasUsed × gasPrice`).
- **R5 (Chuẩn hóa đơn vị kế toán):** Mọi giá trị số tiền và phí gas trả về từ API đều ở đơn vị cơ sở `wei` (kiểu số nguyên lớn). Hệ thống bắt buộc phải quy đổi sang đơn vị `ETH` bằng cách chia cho 10^18 trước khi tính toán lũy kế và hiển thị.
- **R6 (Tuần tự hóa thời gian):** Toàn bộ giao dịch trong kỳ 90 ngày phải được sắp xếp theo thời gian (`timestamp`) tăng dần (từ quá khứ đến hiện tại) trước khi tính toán số dư lũy kế từng thời điểm.
- **R7 (Tình huống đặc biệt - Tự chuyển cho chính mình):** Nếu giao dịch có trường `from` và `to` cùng là địa chỉ ví đang xét (`Self-transfer`), giá trị chuyển `value` không làm thay đổi số dư, nhưng ví vẫn bị trừ chi phí gas. Dòng tiền thực tế chỉ ghi nhận phí gas đi ra.

---

## 4. Đầu ra (Outputs)
- **Bảng đối soát dòng tiền chi tiết (Dạng bảng Markdown / Dataframe / Console):**
  - Các cột: Thời gian (`Timestamp YYYY-MM-DD HH:MM:SS`), Mã băm (`TxHash`), Chiều dòng tiền (`VÀO` / `RA`), Số tiền chuyển (`ETH`), Phí gas (`ETH`), Trạng thái (`Thành công` / `Thất bại`), Số dư lũy kế sau giao dịch (`ETH`).
- **Biểu đồ trực quan hóa (Line Chart):**
  - Trục hoành (X): Trục thời gian tăng dần trong 90 ngày.
  - Trục tung (Y): Số dư lũy kế của ví tại từng mốc giao dịch (đơn vị: `ETH`).
- **Bộ 3 chỉ số tài chính tổng hợp (Summary Metrics):**
  1. **Tổng dòng tiền VÀO trong kỳ (Total Inflow):** Tổng ETH nhận.
  2. **Tổng dòng tiền RA trong kỳ (Total Outflow):** Tổng ETH chuyển + Phí gas thực trả.
  3. **Biến động ròng trong kỳ (Net Cash Flow):** Tổng vào - Tổng ra.

---

## 5. Trường hợp ngoại lệ (Edge Cases)
- **E1 (Ví không phát sinh giao dịch):** Nếu API trả về danh sách rỗng trong khoảng 90 ngày gần nhất, hệ thống in thông báo rõ ràng: `"Ví không có giao dịch trong 90 ngày qua"`, kết thúc an toàn và không vẽ biểu đồ trống.
- **E2 (Lỗi xác thực API Key):** Nếu API trả về mã lỗi xác thực (như `Invalid API Key`, `Max rate limit reached`), hệ thống phải bắt lỗi ngoại lệ, in thông báo hướng dẫn người dùng kiểm tra biến môi trường và dừng chương trình (không crash đột ngột).
- **E3 (Địa chỉ ví sai định dạng):** Nếu địa chỉ ví không đủ 42 ký tự, không bắt đầu bằng `0x`, hoặc sai ký tự hex, hệ thống từ chối ngay lập tức trước khi gọi API để tiết kiệm tài nguyên.
- **E4 (Ví có lượng giao dịch lớn - Phân trang):** Nếu ví có hơn 10.000 giao dịch trong kỳ (vượt quá giới hạn 1 trang của Etherscan API), hệ thống phải tự động lặp phân trang (`page=1, page=2, ...`) để thu thập đầy đủ 100% dữ liệu lịch sử trước khi tổng hợp.

---

## 6. Ngoài phạm vi (Out of Scope)
- **Token ERC-20 / NFT:** Chỉ phân tích dòng tiền của đồng tiền gốc (Native ETH), không phân tích biến động của token phụ (USDT, USDC, DAI,...).
- **Tiền pháp định (Fiat):** Không tự động quy đổi giá trị sang VNĐ hoặc USD (do biến động tỷ giá liên tục của thị trường).
- **Giao dịch nội bộ (Internal Transactions):** Giai đoạn này chỉ xét các giao dịch thông thường (`Normal Transactions`), chưa phân tích giao dịch sinh ra từ tương tác nội bộ của Smart Contract.

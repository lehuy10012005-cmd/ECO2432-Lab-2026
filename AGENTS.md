# AGENTS.md - Quy ước dự án ECO2432

## Ngôn ngữ và phiên bản

- Solidity `^0.8.20`.
- OpenZeppelin Contracts 5.x; dùng `_update`, không dùng `_beforeTokenTransfer`.
- Python 3.10+.

## Quy tắc bắt buộc khi viết hợp đồng

1. Mọi hàm làm thay đổi trạng thái phải phát `event`.
2. Mọi hàm dành cho chủ sở hữu phải kiểm tra quyền rõ ràng.
3. Áp dụng Checks - Effects - Interactions.
4. Chuyển ETH bằng `call{value: ...}("")` và kiểm tra kết quả; không dùng `transfer`.
5. Ưu tiên `error` tùy biến thay cho chuỗi lỗi dài.
6. Không dùng `tx.origin` để xác thực.
7. Tỷ lệ phần trăm dùng basis point, trong đó 1% = 100.

## Quy tắc khi viết Python

1. Không ghi khóa API trong mã nguồn; đọc từ biến môi trường.
2. Kiểm tra trạng thái phản hồi trước khi xử lý dữ liệu.
3. Đổi wei sang ETH trước khi hiển thị.

## Khi được yêu cầu sinh mã

- Giải thích ngắn gọn lựa chọn thiết kế trước khi đưa mã.
- Hỏi lại khi yêu cầu chưa rõ; không tự suy đoán quy tắc kinh tế.
- Nêu tối thiểu ba trường hợp kiểm thử, gồm một trường hợp gian lận.

## Quy tắc cá nhân của sinh viên (Lê Huy - ECO2432)

1. **Ngôn ngữ & Diễn giải:**
   - Mọi chú thích (`comments`) trong mã nguồn và tài liệu giải trình (`README`, `SPEC.md`, `AI_JOURNAL.md`) phải viết bằng tiếng Việt rõ ràng, chuẩn xác theo thuật ngữ kinh tế, tài chính và công nghệ Web3.
2. **Góc nhìn Quản trị rủi ro & Kế toán On-chain:**
   - Khi giải thích giải pháp hoặc phân tích lỗi/lỗ hổng bảo mật, luôn làm rõ tác động kinh tế: rủi ro thất thoát tài sản, mất cân đối số dư sổ cái (reconciliation), đặc quyền rút tiền/mint vô hạn của chủ sở hữu (rug-pull/centralization risk) và chi phí gas giao dịch.
3. **Kiểm thử nghiêm ngặt & Chống suy đoán (AI Supervision):**
   - Luôn yêu cầu tối thiểu 3 ca kiểm thử (gồm ít nhất 1 ca kiểm thử gian lận hoặc gọi sai quyền). Không tự ý suy đoán quy tắc tài chính khi đặc tả chưa rõ ràng.
4. **An toàn bảo mật tài sản số:**
   - Tuyệt đối không ghi mã khóa bí mật (Private Key), Seed Phrase, hoặc API Key trong mã nguồn. Chỉ sử dụng ví thử nghiệm trên mạng Sepolia Testnet.


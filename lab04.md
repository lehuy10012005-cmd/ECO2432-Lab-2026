# BÁO CÁO THẨM ĐỊNH RỦI RO: LAB 4 — NHẬN DIỆN HỢP ĐỒNG CÓ RỦI RO
**Học phần:** Tiền điện tử và Hợp đồng thông minh (ECO2432)  
**Sinh viên thực hiện:** Lê Huy  
**Mã nguồn / Repo:** [https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026](https://github.com/lehuy10012005-cmd/ECO2432-Lab-2026)  
**Tệp mã nguồn thẩm định:** [contracts/lab04/ClubTokens.sol](contracts/lab04/ClubTokens.sol)

---

## 1. Bảng kết luận thẩm định 3 hợp đồng mẫu

| Hợp đồng | Kết luận rủi ro | Tên hàm đặc quyền | Số dòng (Bằng chứng) | Phân tích cơ chế & Rủi ro cho người nắm giữ |
| :---: | :---: | :---: | :---: | :--- |
| **ClubTokenA** (CTA) | **AN TOÀN / SẠCH**<br>*(Bản đối chứng)* | Không có | Dòng 7 – 11 | - Tổng cung cố định 1,000,000 CTA được đúc 1 lần duy nhất trong constructor (Dòng 9).<br>- Không kế thừa `Ownable`, không có hàm đúc thêm (`mint`), không có hàm khóa ví.<br>- **Rủi ro:** Không có rủi ro can thiệp mã nguồn. Quyền sở hữu hoàn toàn phi tập trung. |
| **ClubTokenB** (CTB) | **RỦI RO CAO**<br>*(Pha loãng vô hạn / Rug-pull)* | `mint(address to, uint256 amount)` | **Dòng 18 – 20** | - Kế thừa `Ownable` (Dòng 13). Hàm `mint` được bảo vệ bằng modifier `onlyOwner` nhưng **KHÔNG CÓ TRẦN TỔNG CUNG (No Cap / MAX_SUPPLY)**.<br>- **Rủi ro:** Chủ sở hữu có thể đúc tùy ý hàng tỷ token ra ví cá nhân bất kỳ lúc nào rồi xả bán trên sàn DEX, gây lạm phát phi mã và làm giá trị token của nhà đầu tư rớt về 0 (pha loãng 100% tài sản). |
| **ClubTokenC** (CTC) | **CỰC KỲ NGUY HIỂM**<br>*(Bẫy Honeypot / Khóa bán)* | 1. `setRestricted()`<br>2. `_update()` (Override) | **Dòng 30 – 32**<br><br>**Dòng 34 – 37** | - Quản lý danh sách hạn chế qua biến `restricted` (Dòng 24).<br>- Hàm `setRestricted` (Dòng 30–32) cho phép `onlyOwner` tùy tiện đánh dấu bất kỳ ví nào là `restricted = true`.<br>- Hàm `_update` (Dòng 34–37) kiểm tra `require(!restricted[from], "Dia chi bi han che")`.<br>- **Rủi ro:** Nhà đầu tư vẫn mua vào được (`to` không bị chặn), nhưng khi bán ra hoặc chuyển đi (`from` là ví nhà đầu tư) thì giao dịch bị revert ngay lập tức. Đây chính là bản chất của bẫy lừa đảo **Honeypot** (tiền vào được nhưng không ra được). Ngoài ra, hàm không phát `event` (Dòng 30-32), vi phạm tính minh bạch on-chain. |

---

## 2. Phân tích kinh tế & Kỹ thuật chi tiết

### A. Bài học từ Hợp đồng B: "Lý do hợp lý" nhưng tiềm ẩn rủi ro lạm phát
* **Hiện tượng:** Trong thực tế, các dự án lừa đảo thường ngụy trang hàm `mint()` không giới hạn bằng những lời giải thích hoa mỹ như: *"Phục vụ chương trình khuyến mãi / Trả thưởng cộng đồng / Phát triển hệ sinh thái"*.
* **Góc nhìn kế toán & thẩm định:** Một điều khoản gây rủi ro phá sản dự án không nhất thiết phải là lỗi lập trình (bug). Bản thân việc trao quyền lực vô hạn cho `owner` mà không có cơ chế kiểm soát thuật toán chính là rủi ro quản trị tập trung (Centralization Risk).
* **Đề xuất sửa đổi an toàn:** Bổ sung hằng số trần tổng cung `MAX_SUPPLY` và kiểm tra điều kiện trước khi đúc:
```solidity
uint256 public constant MAX_SUPPLY = 2_000_000 * 10 ** 18;

function mint(address to, uint256 amount) external onlyOwner {
    require(totalSupply() + amount <= MAX_SUPPLY, "Vuot tran tong cung cho phep");
    _mint(to, amount);
}
```

### B. Bài học từ Hợp đồng C: Bẫy "Bảo vệ cộng đồng" và mô hình Honeypot
* **Hiện tượng:** Chú thích code ghi là *"Danh sách địa chỉ bị hạn chế để bảo vệ cộng đồng"*, đánh vào tâm lý an tâm của nhà đầu tư.
* **Bản chất kinh tế:** Đây là cơ chế tước đoạt quyền định đoạt tài sản (Asset Confiscation). Khi chủ sở hữu gom đủ thanh khoản của người mua, họ kích hoạt `setRestricted` cho toàn bộ ví nhà đầu tư và chỉ để lại ví của mình để xả toàn bộ tiền trong bể thanh khoản (Liquidity Pool).
* **Dấu hiệu nhận diện on-chain:**
  1. Không có sự kiện (`event`) phát ra khi khóa ví, khiến các công cụ giám sát on-chain không theo dõi được.
  2. Không có thời hạn tự động mở khóa (Timelock).
  3. Không có cơ chế bỏ phiếu cộng đồng (DAO) hay đa chữ ký (Multi-sig).

---

## 3. Khuyến nghị cho Chuyên viên Thẩm định Dự án (Due Diligence Checklist)

1. **Quy tắc 1 (Mã nguồn sạch):** Hợp đồng token tiêu chuẩn chỉ nên đúc toàn bộ trong constructor như `ClubTokenA`, hoặc nếu có hàm `mint` thì bắt buộc phải có `MAX_SUPPLY` bất biến (`constant`).
2. **Quy tắc 2 (Kiểm tra hàm _update / transfer):** Mọi logic can thiệp vào luồng chuyển tiền nội bộ (`_update` trong OpenZeppelin v5) có chứa điều kiện `require` dựa trên danh sách chặn (`restricted`, `blacklist`) đều phải được gắn cờ đỏ cảnh báo rủi ro Honeypot.
3. **Quy tắc 3 (Phân quyền quản trị):** Nếu dự án bắt buộc phải có quyền khẩn cấp, quyền đó phải do ví đa chữ ký (Multi-signature Wallet như Gnosis Safe) nắm giữ kết hợp cơ chế khóa thời gian (Timelock tối thiểu 48–72 giờ) để cộng đồng kịp phản ứng rút vốn.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title HCE-ScholarProof (Ghi nhận quyền tác giả ý tưởng nghiên cứu khoa học)
 * @author Nhóm sinh viên ECO2432: Lê Văn Quang Huy (23K4300010) & Lại Vương Gia Bảo (23K4300024)
 * @notice Hợp đồng thông minh lưu trữ bằng chứng tồn tại (Proof of Existence) và dấu thời gian (Timestamping)
 *         nhằm bảo vệ quyền sở hữu trí tuệ vi mô, ngăn chặn nạn chiếm đoạt ý tưởng nghiên cứu (Idea Scooping).
 * @dev Tuân thủ chuẩn mực AGENTS.md: Solidity ^0.8.20, Custom Errors, Checks-Effects-Interactions, Events.
 */
contract ScholarProof {
    // --- CẤU TRÚC DỮ LIỆU ---
    struct IdeaRecord {
        address author;        // Địa chỉ ví của tác giả sáng lập ban đầu
        uint256 timestamp;     // Mốc thời gian khối (block.timestamp)
        uint256 blockNumber;   // Thứ tự khối giao dịch xác nhận
        string title;          // Tiêu đề ý tưởng / công trình nghiên cứu
        string category;       // Lĩnh vực chuyên môn (Fintech, Kinh tế số, AI, ...)
        bool exists;           // Cờ đánh dấu sự tồn tại
    }

    // Ánh xạ từ vân tay mật mã tài liệu (docHash 32 bytes) sang bản ghi quyền tác giả
    mapping(bytes32 => IdeaRecord) private _ideas;

    // Tổng số lượng ý tưởng nghiên cứu đã được bảo chứng trên hệ thống
    uint256 public totalIdeas;

    // --- SỰ KIỆN (EVENTS) ---
    event IdeaRegistered(
        bytes32 indexed docHash,
        address indexed author,
        uint256 timestamp,
        uint256 blockNumber,
        string title,
        string category
    );

    // --- CẤU TRÚC LỖI TÙY BIẾN (CUSTOM ERRORS) ---
    error InvalidDocHash();
    error EmptyTitle();
    error IdeaAlreadyRegistered(bytes32 docHash, address existingAuthor, uint256 registeredAt);
    error IdeaNotFound(bytes32 docHash);

    // --- HÀM NGHIỆP VỤ CỐT LÕI ---

    /**
     * @notice Đăng ký quyền tác giả và xác lập bằng chứng ưu tiên (Prior Art) cho ý tưởng nghiên cứu
     * @param docHash Mã băm Keccak-256 / SHA-256 của tệp tài liệu nghiên cứu (tính toán off-chain)
     * @param title Tiêu đề của đề tài hoặc ý tưởng nghiên cứu
     * @param category Lĩnh vực chuyên môn
     */
    function registerIdea(
        bytes32 docHash,
        string calldata title,
        string calldata category
    ) external {
        // 1. CHECKS: Kiểm tra tính hợp lệ của dữ liệu đầu vào
        if (docHash == bytes32(0)) revert InvalidDocHash();
        if (bytes(title).length == 0) revert EmptyTitle();
        if (_ideas[docHash].exists) {
            revert IdeaAlreadyRegistered(docHash, _ideas[docHash].author, _ideas[docHash].timestamp);
        }

        // 2. EFFECTS: Ghi nhận trạng thái vào sổ cái bất biến
        _ideas[docHash] = IdeaRecord({
            author: msg.sender,
            timestamp: block.timestamp,
            blockNumber: block.number,
            title: title,
            category: category,
            exists: true
        });

        unchecked {
            totalIdeas++;
        }

        // Phát sự kiện on-chain để các ứng dụng Web3 client bắt được trạng thái
        emit IdeaRegistered(
            docHash,
            msg.sender,
            block.timestamp,
            block.number,
            title,
            category
        );
    }

    /**
     * @notice Tra cứu và thẩm định quyền tác giả của một tài liệu nghiên cứu
     * @param docHash Mã băm của tài liệu cần kiểm chứng
     * @return author Địa chỉ ví của tác giả đăng ký đầu tiên
     * @return timestamp Mốc thời gian khối (Unix timestamp) khi đăng ký
     * @return blockNumber Số thứ tự khối xác nhận giao dịch
     * @return title Tiêu đề công trình
     * @return category Lĩnh vực nghiên cứu
     */
    function verifyIdea(bytes32 docHash) external view returns (
        address author,
        uint256 timestamp,
        uint256 blockNumber,
        string memory title,
        string memory category
    ) {
        IdeaRecord memory record = _ideas[docHash];
        if (!record.exists) revert IdeaNotFound(docHash);

        return (
            record.author,
            record.timestamp,
            record.blockNumber,
            record.title,
            record.category
        );
    }

    /**
     * @notice Kiểm tra nhanh xem mã băm tài liệu đã từng được đăng ký hay chưa
     * @param docHash Mã băm tài liệu
     * @return isRegistered true nếu đã đăng ký, false nếu chưa
     */
    function isIdeaRegistered(bytes32 docHash) external view returns (bool isRegistered) {
        return _ideas[docHash].exists;
    }
}

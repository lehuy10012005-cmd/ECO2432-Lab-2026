// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title HCE-ScholarProof (v3 - Nâng cấp Toàn diện cho Chủ đề 8: Xác thực & Thu hồi Chứng nhận Khóa học)
 * @author Nhóm sinh viên ECO2432: Lê Văn Quang Huy (23K4300010) & Lại Vương Gia Bảo (23K4300024)
 * @notice Hợp đồng thông minh phục vụ đồng thời 2 phân hệ trọng yếu:
 *         1. Phân hệ Chủ đề 8: Đơn vị đào tạo phát hành mã băm chứng chỉ -> Bên thứ ba (Nhà tuyển dụng)
 *            tra cứu (0đ gas) -> Khi có gian lận, Đơn vị ký giao dịch thu hồi và trạng thái thu hồi hiện rõ.
 *         2. Phân hệ Bằng chứng ý tưởng nghiên cứu (Proof of Existence & Timestamping) bảo toàn mã nguồn cũ.
 * @dev Tuân thủ nghiêm ngặt chuẩn mực AGENTS.md:
 *      - Khung kiến trúc Checks - Effects - Interactions (CEI).
 *      - Phân quyền đơn vị phát hành (Authorized Issuers / Owner) ngăn chặn rủi ro mạo danh cơ sở giáo dục.
 *      - Mọi hàm làm thay đổi trạng thái đều phát Event có indexed để ứng dụng Web3 client lắng nghe sự kiện.
 *      - Sử dụng Custom Errors thay cho chuỗi require dài giúp tối ưu hóa chi phí gas.
 *      - Không sử dụng tx.origin để xác thực quyền truy cập.
 */
contract ScholarProof {
    // ========================================================================
    // QUẢN TRỊ HỢP ĐỒNG & PHÂN QUYỀN ĐƠN VỊ PHÁT HÀNH (ACCESS CONTROL)
    // ========================================================================
    address public owner;
    
    // Danh sách các địa chỉ ví được cấp quyền Đơn vị phát hành (Huy & Bảo)
    mapping(address => bool) public authorizedIssuers;

    modifier onlyOwner() {
        if (msg.sender != owner) revert UnauthorizedCaller(msg.sender);
        _;
    }

    modifier onlyIssuer() {
        if (msg.sender != owner && !authorizedIssuers[msg.sender]) {
            revert UnauthorizedIssuer(msg.sender);
        }
        _;
    }

    // ========================================================================
    // CẤU TRÚC DỮ LIỆU CHỦ ĐỀ 8: CHỨNG NHẬN KHÓA HỌC (CREDENTIAL VERIFICATION)
    // ========================================================================
    struct CertificateRecord {
        bytes32 certHash;         // Mã băm Keccak-256 (32 bytes) của tệp chứng chỉ PDF gốc
        string certCode;          // Mã số chứng chỉ duy nhất (VD: HCE-BC-2026-001)
        string studentName;       // Họ và tên học viên nhận chứng nhận
        string courseName;        // Tên khóa học / chương trình đào tạo
        string grade;             // Xếp loại tốt nghiệp (Xuất sắc, Giỏi, Khá)
        uint256 issueDate;        // Mốc thời gian khối (block.timestamp) khi cấp chứng nhận
        uint256 blockNumber;      // Số thứ tự khối xác nhận trên Sepolia
        address issuer;           // Địa chỉ ví của đơn vị phát hành đã ký giao dịch
        bool isRevoked;           // Cờ đánh dấu trạng thái thu hồi (true: đã bị thu hồi)
        string revokeReason;      // Lý do thu hồi chính thức từ Hội đồng kỷ luật / Nhà trường
        uint256 revokedAt;        // Mốc thời gian khối khi giao dịch thu hồi được xác nhận
        address revokedBy;        // Địa chỉ ví của người có thẩm quyền ký lệnh thu hồi
        bool exists;              // Cờ kiểm tra tính tồn tại của chứng nhận trên sổ cái
    }

    // Ánh xạ từ Mã chứng chỉ (certCode) sang Bản ghi chi tiết
    mapping(string => CertificateRecord) private _certificates;

    // Ánh xạ từ Mã băm Keccak-256 (certHash) sang Mã chứng chỉ (hỗ trợ đối soát theo tệp PDF)
    mapping(bytes32 => string) private _hashToCertCode;

    // Các biến đếm thống kê sổ cái chứng nhận
    uint256 public totalCertificates;
    uint256 public totalRevokedCertificates;

    // ========================================================================
    // CẤU TRÚC DỮ LIỆU PHÂN HỆ Ý TƯỞNG NGHIÊN CỨU (BẢO TOÀN TÍNH TƯƠNG THÍCH)
    // ========================================================================
    uint256 public constant MAX_TITLE_LENGTH = 200;
    uint256 public constant MAX_CATEGORY_LENGTH = 100;

    struct IdeaRecord {
        address author;
        uint256 timestamp;
        uint256 blockNumber;
        string title;
        string category;
        bool exists;
    }

    mapping(bytes32 => IdeaRecord) private _ideas;
    uint256 public totalIdeas;

    // ========================================================================
    // SỰ KIỆN ON-CHAIN (EVENTS)
    // ========================================================================
    event CertificateIssued(
        string indexed certCode,
        bytes32 indexed certHash,
        address indexed issuer,
        string studentName,
        string courseName,
        uint256 issueDate
    );

    event CertificateRevoked(
        string indexed certCode,
        address indexed revokedBy,
        string reason,
        uint256 revokedAt
    );

    event IssuerStatusUpdated(address indexed issuer, bool status);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    event IdeaRegistered(
        bytes32 indexed docHash,
        address indexed author,
        uint256 timestamp,
        uint256 blockNumber,
        string title,
        string category
    );

    event AuthorshipTransferred(
        bytes32 indexed docHash,
        address indexed previousAuthor,
        address indexed newAuthor,
        uint256 timestamp
    );

    // ========================================================================
    // LỖI TÙY BIẾN (CUSTOM ERRORS TIẾT KIỆM GAS)
    // ========================================================================
    error UnauthorizedCaller(address caller);
    error UnauthorizedIssuer(address caller);
    error InvalidDocHash();
    error EmptyCertCode();
    error EmptyStudentName();
    error EmptyCourseName();
    error EmptyRevokeReason();
    error CertificateAlreadyExists(string certCode);
    error CertificateNotFound(string certCode);
    error CertificateAlreadyRevoked(string certCode, uint256 revokedAt, string reason);
    error EmptyTitle();
    error TitleTooLong(uint256 length, uint256 maxAllowed);
    error CategoryTooLong(uint256 length, uint256 maxAllowed);
    error IdeaAlreadyRegistered(bytes32 docHash, address existingAuthor, uint256 registeredAt);
    error IdeaNotFound(bytes32 docHash);
    error NotAuthor();
    error InvalidNewAuthor();
    error SameAuthor();

    // ========================================================================
    // HÀM KHỞI TẠO (CONSTRUCTOR)
    // ========================================================================
    constructor() {
        owner = msg.sender;
        authorizedIssuers[msg.sender] = true;
        
        // Cấp quyền mặc định cho ví thử nghiệm của Trưởng nhóm Lê Huy và Thành viên Gia Bảo
        authorizedIssuers[0xB07FB0761c33a01F7f7493A6a8a9667F4842Fd50] = true;
    }

    // ========================================================================
    // HÀM QUẢN TRỊ ĐƠN VỊ PHÁT HÀNH (ADMIN FUNCTIONS)
    // ========================================================================
    function setAuthorizedIssuer(address issuer, bool status) external onlyOwner {
        if (issuer == address(0)) revert InvalidNewAuthor();
        authorizedIssuers[issuer] = status;
        emit IssuerStatusUpdated(issuer, status);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert InvalidNewAuthor();
        address oldOwner = owner;
        owner = newOwner;
        authorizedIssuers[newOwner] = true;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    // ========================================================================
    // NGHIỆP VỤ CỐT LÕI CHỦ ĐỀ 8: PHÁT HÀNH & THU HỒI CHỨNG NHẬN
    // ========================================================================

    /**
     * @notice Đơn vị phát hành cấp chứng nhận khóa học và niêm phong mã băm lên Sepolia
     * @dev Áp dụng Checks-Effects-Interactions (CEI). Chỉ ví được ủy quyền mới gọi được.
     * @param certCode Mã chứng nhận duy nhất (VD: HCE-BC-2026-001)
     * @param certHash Mã băm Keccak-256 (32 bytes) của tệp PDF chứng nhận
     * @param studentName Họ và tên học viên
     * @param courseName Tên khóa đào tạo
     * @param grade Xếp loại tốt nghiệp (Xuất sắc, Giỏi, Khá)
     */
    function issueCertificate(
        string calldata certCode,
        bytes32 certHash,
        string calldata studentName,
        string calldata courseName,
        string calldata grade
    ) external onlyIssuer {
        // 1. CHECKS
        if (bytes(certCode).length == 0) revert EmptyCertCode();
        if (certHash == bytes32(0)) revert InvalidDocHash();
        if (bytes(studentName).length == 0) revert EmptyStudentName();
        if (bytes(courseName).length == 0) revert EmptyCourseName();
        if (_certificates[certCode].exists) revert CertificateAlreadyExists(certCode);

        // 2. EFFECTS
        _certificates[certCode] = CertificateRecord({
            certHash: certHash,
            certCode: certCode,
            studentName: studentName,
            courseName: courseName,
            grade: grade,
            issueDate: block.timestamp,
            blockNumber: block.number,
            issuer: msg.sender,
            isRevoked: false,
            revokeReason: "",
            revokedAt: 0,
            revokedBy: address(0),
            exists: true
        });

        _hashToCertCode[certHash] = certCode;

        unchecked {
            totalCertificates++;
        }

        // 3. INTERACTIONS (Phát sự kiện)
        emit CertificateIssued(
            certCode,
            certHash,
            msg.sender,
            studentName,
            courseName,
            block.timestamp
        );
    }

    /**
     * @notice Thu hồi chứng nhận khóa học khi phát hiện gian lận hoặc sai phạm nghiêm trọng
     * @dev Chỉ Đơn vị phát hành có thẩm quyền mới được thu hồi. Giao dịch bất biến trên sổ cái.
     * @param certCode Mã chứng chỉ cần thu hồi
     * @param reason Lý do thu hồi (Bắt buộc, giải trình trước hội đồng)
     */
    function revokeCertificate(
        string calldata certCode,
        string calldata reason
    ) external onlyIssuer {
        // 1. CHECKS
        CertificateRecord storage record = _certificates[certCode];
        if (!record.exists) revert CertificateNotFound(certCode);
        if (record.isRevoked) revert CertificateAlreadyRevoked(certCode, record.revokedAt, record.revokeReason);
        if (bytes(reason).length == 0) revert EmptyRevokeReason();

        // 2. EFFECTS
        record.isRevoked = true;
        record.revokeReason = reason;
        record.revokedAt = block.timestamp;
        record.revokedBy = msg.sender;

        unchecked {
            totalRevokedCertificates++;
        }

        // 3. INTERACTIONS (Phát sự kiện cảnh báo on-chain)
        emit CertificateRevoked(
            certCode,
            msg.sender,
            reason,
            block.timestamp
        );
    }

    /**
     * @notice Nhà tuyển dụng hoặc bên thứ ba tra cứu và xác thực chứng nhận (0đ gas)
     * @param certCode Mã số chứng nhận cần xác minh
     */
    function verifyCertificate(string calldata certCode) external view returns (
        bool exists,
        bool isRevoked,
        bytes32 certHash,
        string memory studentName,
        string memory courseName,
        string memory grade,
        uint256 issueDate,
        uint256 blockNumber,
        address issuer,
        string memory revokeReason,
        uint256 revokedAt
    ) {
        CertificateRecord memory record = _certificates[certCode];
        if (!record.exists) revert CertificateNotFound(certCode);

        return (
            record.exists,
            record.isRevoked,
            record.certHash,
            record.studentName,
            record.courseName,
            record.grade,
            record.issueDate,
            record.blockNumber,
            record.issuer,
            record.revokeReason,
            record.revokedAt
        );
    }

    /**
     * @notice Xác thực chứng nhận dựa trên Mã băm tệp PDF do ứng viên cung cấp
     * @param certHash Mã băm Keccak-256 tính từ tệp tài liệu
     */
    function verifyCertificateByHash(bytes32 certHash) external view returns (
        bool exists,
        bool isRevoked,
        string memory certCode,
        string memory studentName,
        string memory courseName,
        string memory grade,
        uint256 issueDate,
        string memory revokeReason
    ) {
        string memory code = _hashToCertCode[certHash];
        if (bytes(code).length == 0) revert CertificateNotFound("");

        CertificateRecord memory record = _certificates[code];
        return (
            record.exists,
            record.isRevoked,
            record.certCode,
            record.studentName,
            record.courseName,
            record.grade,
            record.issueDate,
            record.revokeReason
        );
    }

    /**
     * @notice Kiểm tra nhanh xem chứng nhận có bị thu hồi hay không
     */
    function isCertificateRevoked(string calldata certCode) external view returns (
        bool exists,
        bool isRevoked,
        string memory reason
    ) {
        CertificateRecord memory record = _certificates[certCode];
        return (record.exists, record.isRevoked, record.revokeReason);
    }

    // ========================================================================
    // CÁC HÀM XÁC THỰC BẢN QUYỀN Ý TƯỞNG (GIỮ NGUYÊN BẢO TOÀN CHO LAB CŨ)
    // ========================================================================
    function registerIdea(
        bytes32 docHash,
        string calldata title,
        string calldata category
    ) external {
        if (docHash == bytes32(0)) revert InvalidDocHash();
        
        uint256 titleLen = bytes(title).length;
        if (titleLen == 0) revert EmptyTitle();
        if (titleLen > MAX_TITLE_LENGTH) revert TitleTooLong(titleLen, MAX_TITLE_LENGTH);

        uint256 catLen = bytes(category).length;
        if (catLen > MAX_CATEGORY_LENGTH) revert CategoryTooLong(catLen, MAX_CATEGORY_LENGTH);

        if (_ideas[docHash].exists) {
            revert IdeaAlreadyRegistered(docHash, _ideas[docHash].author, _ideas[docHash].timestamp);
        }

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

        emit IdeaRegistered(
            docHash,
            msg.sender,
            block.timestamp,
            block.number,
            title,
            category
        );
    }

    function transferAuthorship(bytes32 docHash, address newAuthor) external {
        IdeaRecord storage record = _ideas[docHash];
        if (!record.exists) revert IdeaNotFound(docHash);
        if (record.author != msg.sender) revert NotAuthor();
        if (newAuthor == address(0)) revert InvalidNewAuthor();
        if (newAuthor == msg.sender) revert SameAuthor();

        address previousAuthor = record.author;
        record.author = newAuthor;

        emit AuthorshipTransferred(docHash, previousAuthor, newAuthor, block.timestamp);
    }

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

    function isIdeaRegistered(bytes32 docHash) external view returns (bool isRegistered) {
        return _ideas[docHash].exists;
    }
}

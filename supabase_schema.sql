-- =============================================================================
-- HỆ THỐNG CƠ SỞ DỮ LIỆU ĐÁM MÂY SUPABASE CHO DỰ ÁN HCE-SCHOLARPROOF / COPYCHAIN
-- Môn học: Kinh tế Web3 & Công nghệ Tài chính (ECO2432)
-- Tác giả: Lê Huy (ECO2432)
-- =============================================================================
-- HƯỚNG DẪN THỰC THI:
-- 1. Đăng nhập vào trang quản trị: https://supabase.com/dashboard
-- 2. Chọn dự án của bạn (nolpfigqglmwcbfqoksq)
-- 3. Ở menu bên trái, chọn "SQL Editor" -> nhấp "New query"
-- 4. Dán toàn bộ nội dung file này vào và bấm nút "Run" (hoặc Ctrl + Enter).
-- =============================================================================

-- 1. BẢNG TÀI KHOẢN NGƯỜI DÙNG & TÁC GIẢ (copychain_users)
CREATE TABLE IF NOT EXISTS public.copychain_users (
    id TEXT PRIMARY KEY,
    mssv TEXT,
    name TEXT,
    full_name TEXT,
    id_card TEXT,
    email TEXT,
    phone TEXT,
    dob TEXT,
    address TEXT,
    class_name TEXT,
    faculty TEXT,
    academic_status TEXT DEFAULT 'Sinh viên đang học tập (Chính quy)',
    status TEXT DEFAULT 'ACTIVE',
    is_revoked BOOLEAN DEFAULT FALSE,
    revoke_reason TEXT,
    wallet TEXT,
    role TEXT DEFAULT 'AUTHOR',
    role_name TEXT DEFAULT 'Tác Giả',
    badge TEXT,
    avatar TEXT,
    password TEXT,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Tự động bổ sung cột nếu bảng copychain_users đã được tạo trước đó
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS mssv TEXT;
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS class_name TEXT;
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS faculty TEXT;
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS academic_status TEXT DEFAULT 'Sinh viên đang học tập (Chính quy)';
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'ACTIVE';
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS is_revoked BOOLEAN DEFAULT FALSE;
ALTER TABLE public.copychain_users ADD COLUMN IF NOT EXISTS revoke_reason TEXT;

-- 2. BẢNG TÁC PHẨM ĐĂNG KÝ BẢN QUYỀN (copychain_works)
CREATE TABLE IF NOT EXISTS public.copychain_works (
    code TEXT PRIMARY KEY,
    title TEXT,
    type TEXT,
    department TEXT,
    faculty TEXT,
    author_mssv TEXT,
    author_class TEXT,
    author_faculty TEXT,
    authors_text TEXT,
    author_wallet TEXT,
    sha256 TEXT,
    keccak256 TEXT,
    tx_hash TEXT,
    block_number TEXT,
    status TEXT DEFAULT 'VERIFIED',
    status_text TEXT,
    is_revoked BOOLEAN DEFAULT FALSE,
    revoke_reason TEXT,
    revoked_at TIMESTAMPTZ,
    revoked_by TEXT,
    revoke_tx_hash TEXT,
    date_registered TEXT,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Tự động bổ sung cột nếu bảng copychain_works đã được tạo trước đó
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS department TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS faculty TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS author_mssv TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS author_class TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS author_faculty TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS is_revoked BOOLEAN DEFAULT FALSE;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS revoke_reason TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS revoked_at TIMESTAMPTZ;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS revoked_by TEXT;
ALTER TABLE public.copychain_works ADD COLUMN IF NOT EXISTS revoke_tx_hash TEXT;

-- 3. BẢNG SỔ CÁI HỌC THUẬT & BẢN GHI XÁC THỰC (copychain_records)
CREATE TABLE IF NOT EXISTS public.copychain_records (
    code TEXT PRIMARY KEY,
    title TEXT,
    date TEXT,
    faculty TEXT,
    type TEXT,
    advisor TEXT,
    authors TEXT,
    author_mssv TEXT,
    author_class TEXT,
    author_email TEXT,
    author_phone TEXT,
    hash TEXT,
    sha256 TEXT,
    block TEXT,
    time TEXT,
    wallet TEXT,
    tx_hash TEXT,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Tự động bổ sung cột nếu bảng copychain_records đã được tạo trước đó
ALTER TABLE public.copychain_records ADD COLUMN IF NOT EXISTS author_mssv TEXT;
ALTER TABLE public.copychain_records ADD COLUMN IF NOT EXISTS author_class TEXT;

-- 4. BẢNG CHỨNG NHẬN KHÓA HỌC & QUẢN LÝ THU HỒI ON-CHAIN (copychain_certificates)
CREATE TABLE IF NOT EXISTS public.copychain_certificates (
    cert_code TEXT PRIMARY KEY,
    student_name TEXT,
    student_id TEXT,
    course_name TEXT,
    grade TEXT,
    issue_date TEXT,
    cert_hash TEXT,
    sha256 TEXT,
    is_revoked BOOLEAN DEFAULT FALSE,
    revoke_reason TEXT,
    revoked_at TIMESTAMPTZ,
    revoked_by TEXT,
    issuer TEXT,
    block_number BIGINT,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- =============================================================================
-- CẤU HÌNH BẢO MẬT HÀNG (ROW LEVEL SECURITY - RLS) CHO CLIENT WEB3
-- Cho phép đọc và ghi dữ liệu công khai qua API Anon Key
-- =============================================================================
ALTER TABLE public.copychain_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.copychain_works ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.copychain_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.copychain_certificates ENABLE ROW LEVEL SECURITY;

-- Xóa chính sách cũ nếu tồn tại trước khi tạo mới
DROP POLICY IF EXISTS "Cho phép đọc người dùng công khai" ON public.copychain_users;
DROP POLICY IF EXISTS "Cho phép thêm sửa người dùng công khai" ON public.copychain_users;

DROP POLICY IF EXISTS "Cho phép đọc tác phẩm công khai" ON public.copychain_works;
DROP POLICY IF EXISTS "Cho phép thêm sửa tác phẩm công khai" ON public.copychain_works;

DROP POLICY IF EXISTS "Cho phép đọc sổ cái công khai" ON public.copychain_records;
DROP POLICY IF EXISTS "Cho phép thêm sửa sổ cái công khai" ON public.copychain_records;

DROP POLICY IF EXISTS "Cho phép đọc chứng chỉ công khai" ON public.copychain_certificates;
DROP POLICY IF EXISTS "Cho phép thêm sửa chứng chỉ công khai" ON public.copychain_certificates;

-- Tạo chính sách phân quyền cho bảng copychain_users
CREATE POLICY "Cho phép đọc người dùng công khai" 
    ON public.copychain_users FOR SELECT 
    USING (true);

CREATE POLICY "Cho phép thêm sửa người dùng công khai" 
    ON public.copychain_users FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- Tạo chính sách phân quyền cho bảng copychain_works
CREATE POLICY "Cho phép đọc tác phẩm công khai" 
    ON public.copychain_works FOR SELECT 
    USING (true);

CREATE POLICY "Cho phép thêm sửa tác phẩm công khai" 
    ON public.copychain_works FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- Tạo chính sách phân quyền cho bảng copychain_records
CREATE POLICY "Cho phép đọc sổ cái công khai" 
    ON public.copychain_records FOR SELECT 
    USING (true);

CREATE POLICY "Cho phép thêm sửa sổ cái công khai" 
    ON public.copychain_records FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- Tạo chính sách phân quyền cho bảng copychain_certificates
CREATE POLICY "Cho phép đọc chứng chỉ công khai" 
    ON public.copychain_certificates FOR SELECT 
    USING (true);

CREATE POLICY "Cho phép thêm sửa chứng chỉ công khai" 
    ON public.copychain_certificates FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- =============================================================================
-- CẤP QUYỀN TRUY CẬP (GRANT PRIVILEGES) CHO ROLE anon VÀ authenticated
-- Khắc phục triệt để lỗi "permission denied for table" khi gọi qua API
-- =============================================================================
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_users TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_works TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_records TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_certificates TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated;


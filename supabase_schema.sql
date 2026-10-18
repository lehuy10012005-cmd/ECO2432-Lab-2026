-- =============================================================================
-- HỆ THỐNG CƠ SỞ DỮ LIỆU ĐÁM MÂY SUPABASE CHO DỰ ÁN HCE-SCHOLARPROOF / COPYCHAIN
-- TÍCH HỢP LƯU TRỮ ĐÁM MÂY (SUPABASE STORAGE), XEM TRỰC TIẾP & TẢI TÁC PHẨM
-- Môn học: Kinh tế Web3 & Công nghệ Tài chính (ECO2432)
-- Tác giả: Lê Huy (ECO2432) & Gia Bảo
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

-- 2. BẢNG TÁC PHẨM ĐĂNG KÝ BẢN QUYỀN (copychain_works)
CREATE TABLE IF NOT EXISTS public.copychain_works (
    code TEXT PRIMARY KEY,
    title TEXT,
    type TEXT,
    department TEXT,
    authors_text TEXT,
    author_wallet TEXT,
    sha256 TEXT,
    keccak256 TEXT,
    tx_hash TEXT,
    block_number TEXT,
    status TEXT DEFAULT 'VERIFIED',
    status_text TEXT,
    date_registered TEXT,
    file_url TEXT,
    file_name TEXT,
    file_size TEXT,
    file_type TEXT,
    view_count INT DEFAULT 1,
    download_count INT DEFAULT 0,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 3. BẢNG SỔ CÁI HỌC THUẬT & BẢN GHI XÁC THỰC (copychain_records)
CREATE TABLE IF NOT EXISTS public.copychain_records (
    code TEXT PRIMARY KEY,
    title TEXT,
    date TEXT,
    faculty TEXT,
    type TEXT,
    advisor TEXT,
    authors TEXT,
    author_email TEXT,
    author_phone TEXT,
    hash TEXT,
    sha256 TEXT,
    block TEXT,
    time TEXT,
    wallet TEXT,
    tx_hash TEXT,
    file_url TEXT,
    file_name TEXT,
    file_size TEXT,
    file_type TEXT,
    view_count INT DEFAULT 1,
    download_count INT DEFAULT 0,
    raw_data JSONB,
    updated_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW()),
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- =============================================================================
-- CẬP NHẬT CÁC CỘT LƯU TRỮ FILE NẾU BẢNG ĐÃ TỒN TẠI TỪ TRƯỚC (SAFE MIGRATION)
-- =============================================================================
DO $$
BEGIN
    -- Cập nhật bảng copychain_works
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'file_url') THEN
        ALTER TABLE public.copychain_works ADD COLUMN file_url TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'file_name') THEN
        ALTER TABLE public.copychain_works ADD COLUMN file_name TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'file_size') THEN
        ALTER TABLE public.copychain_works ADD COLUMN file_size TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'file_type') THEN
        ALTER TABLE public.copychain_works ADD COLUMN file_type TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'view_count') THEN
        ALTER TABLE public.copychain_works ADD COLUMN view_count INT DEFAULT 1;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_works' AND column_name = 'download_count') THEN
        ALTER TABLE public.copychain_works ADD COLUMN download_count INT DEFAULT 0;
    END IF;

    -- Cập nhật bảng copychain_records
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'file_url') THEN
        ALTER TABLE public.copychain_records ADD COLUMN file_url TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'file_name') THEN
        ALTER TABLE public.copychain_records ADD COLUMN file_name TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'file_size') THEN
        ALTER TABLE public.copychain_records ADD COLUMN file_size TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'file_type') THEN
        ALTER TABLE public.copychain_records ADD COLUMN file_type TEXT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'view_count') THEN
        ALTER TABLE public.copychain_records ADD COLUMN view_count INT DEFAULT 1;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'copychain_records' AND column_name = 'download_count') THEN
        ALTER TABLE public.copychain_records ADD COLUMN download_count INT DEFAULT 0;
    END IF;
END $$;

-- =============================================================================
-- CẤU HÌNH SUPABASE STORAGE CHO TỆP TOÀN VĂN HỌC THUẬT (BUCKET: copychain_files)
-- =============================================================================
-- Tạo bucket công khai 'copychain_files' nếu chưa có
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'copychain_files',
    'copychain_files',
    true,
    52428800, -- Giới hạn 50MB mỗi tệp
    ARRAY[
        'application/pdf',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'application/zip',
        'application/x-zip-compressed',
        'image/jpeg',
        'image/png',
        'image/webp'
    ]
)
ON CONFLICT (id) DO UPDATE SET 
    public = true,
    file_size_limit = 52428800;

-- Phân quyền Storage Policy: Cho phép tải lên và đọc tệp công khai
DROP POLICY IF EXISTS "Cho phép đọc tệp công khai" ON storage.objects;
CREATE POLICY "Cho phép đọc tệp công khai" 
    ON storage.objects FOR SELECT 
    USING (bucket_id = 'copychain_files');

DROP POLICY IF EXISTS "Cho phép tải tệp lên công khai" ON storage.objects;
CREATE POLICY "Cho phép tải tệp lên công khai" 
    ON storage.objects FOR INSERT 
    WITH CHECK (bucket_id = 'copychain_files');

DROP POLICY IF EXISTS "Cho phép cập nhật tệp công khai" ON storage.objects;
CREATE POLICY "Cho phép cập nhật tệp công khai" 
    ON storage.objects FOR UPDATE 
    USING (bucket_id = 'copychain_files');

-- =============================================================================
-- CẤU HÌNH BẢO MẬT HÀNG (ROW LEVEL SECURITY - RLS) CHO CÁC BẢNG DỮ LIỆU
-- Cho phép đọc và ghi dữ liệu công khai qua API Anon Key
-- =============================================================================
ALTER TABLE public.copychain_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.copychain_works ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.copychain_records ENABLE ROW LEVEL SECURITY;

-- Xóa chính sách cũ nếu tồn tại trước khi tạo mới
DROP POLICY IF EXISTS "Cho phép đọc người dùng công khai" ON public.copychain_users;
DROP POLICY IF EXISTS "Cho phép thêm sửa người dùng công khai" ON public.copychain_users;

DROP POLICY IF EXISTS "Cho phép đọc tác phẩm công khai" ON public.copychain_works;
DROP POLICY IF EXISTS "Cho phép thêm sửa tác phẩm công khai" ON public.copychain_works;

DROP POLICY IF EXISTS "Cho phép đọc sổ cái công khai" ON public.copychain_records;
DROP POLICY IF EXISTS "Cho phép thêm sửa sổ cái công khai" ON public.copychain_records;

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

-- =============================================================================
-- CẤP QUYỀN TRUY CẬP (GRANT PRIVILEGES) CHO ROLE anon VÀ authenticated
-- Khắc phục triệt để lỗi "permission denied for table" khi gọi qua API
-- =============================================================================
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_users TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_works TO anon, authenticated;
GRANT ALL ON TABLE public.copychain_records TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated;

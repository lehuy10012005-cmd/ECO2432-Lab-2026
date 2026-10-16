const nodemailer = require("nodemailer");

module.exports = async function handler(req, res) {
  // Cấu hình CORS để cho phép frontend gọi từ bất kỳ domain nào
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");

  if (req.method === "OPTIONS") {
    return res.status(200).end();
  }

  if (req.method !== "POST") {
    return res.status(405).json({ success: false, error: "Method Not Allowed" });
  }

  try {
    const { email, name, otp } = req.body || {};
    if (!email || !otp) {
      return res.status(400).json({ success: false, error: "Thiếu địa chỉ email hoặc mã OTP!" });
    }

    const gmailUser = process.env.GMAIL_USER;
    const gmailPass = process.env.GMAIL_APP_PASSWORD;

    if (!gmailUser || !gmailPass) {
      return res.status(500).json({
        success: false,
        error: "Chưa cấu hình biến môi trường GMAIL_USER và GMAIL_APP_PASSWORD trên Vercel!"
      });
    }

    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: gmailUser,
        pass: gmailPass
      }
    });

    const mailOptions = {
      from: `"HUE-ScholarProof" <${gmailUser}>`,
      to: email,
      subject: `[HUE-ScholarProof] Mã xác thực OTP đăng ký: ${otp}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 520px; margin: 0 auto; border: 1px solid #e2e8f0; border-radius: 12px; padding: 24px; color: #1e293b;">
          <h2 style="color: #2563eb; margin-top: 0;">Xác Thực Tài Khoản HCE-ScholarProof</h2>
          <p>Xin chào <strong>${name || 'Tác giả'}</strong>,</p>
          <p>Bạn vừa yêu cầu đăng ký tài khoản trên nền tảng Bảo chứng Quyền tác giả học thuật HCE-ScholarProof.</p>
          <div style="background: #eff6ff; border-radius: 8px; padding: 18px; text-align: center; margin: 20px 0;">
            <div style="font-size: 13px; color: #1e40af; font-weight: 600; text-transform: uppercase;">Mã xác thực OTP của bạn</div>
            <div style="font-size: 32px; font-weight: 800; letter-spacing: 8px; color: #1d4ed8; font-family: monospace; margin: 8px 0;">${otp}</div>
            <div style="font-size: 12px; color: #64748b;">Mã có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này cho người khác.</div>
          </div>
          <p style="font-size: 12px; color: #94a3b8; border-top: 1px solid #f1f5f9; padding-top: 12px; margin-bottom: 0;">
            Trân trọng,<br>Hệ thống Xác thực Tác quyền Học thuật HCE-ScholarProof (Trường ĐH Kinh tế - ĐH Huế)
          </p>
        </div>
      `
    };

    await transporter.sendMail(mailOptions);
    return res.status(200).json({ success: true, message: "Đã gửi mã OTP thành công tới " + email });
  } catch (error) {
    console.error("Lỗi gửi email:", error);
    return res.status(500).json({ success: false, error: error.message || "Lỗi máy chủ gửi email" });
  }
};

@echo off
chcp 65001 >nul
cd /d "%~dp0"
title HCE-ScholarProof OTP Server
echo ===================================================
echo   Khoi dong May chu Gui OTP Gmail (HCE-ScholarProof)
echo ===================================================
py otp_server.py || python otp_server.py
pause

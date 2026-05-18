.PHONY: setup install-python-package clean create-directories

# ตั้งค่าตัวแปร
PYTHON := python3
VENV := .venv
V_PIP := $(VENV)/bin/pip

# คำสั่งหลัก: สร้างโฟลเดอร์ -> ลง Libraries -> ติดตั้ง mloader
setup: create-directories install-python-package
	@echo "------------------------------------------------"
	@echo "✅ mloader is installed and ready to use!"
	@echo "To test it, run: make run"
	@echo "------------------------------------------------"

install-python-package:
	@echo "--- 📦 Preparing Environment and Installing mloader ---"
	# 1. สร้าง venv (เลี่ยงปัญหา PEP 668/externally-managed-environment)
	@test -d $(VENV) || $(PYTHON) -m venv $(VENV)
	
	# 2. อัปเกรด pip
	@$(V_PIP) install --upgrade pip
	
	# 3. ติดตั้ง Dependencies จากไฟล์ของโปรเจกต์
	@if [ -f requirements.txt ]; then \
		$(V_PIP) install --retries 10 -r requirements.txt; \
	fi

	# 4. ติดตั้งตัว mloader เอง (ใช้ . เพื่อติดตั้งจากโฟลเดอร์ปัจจุบัน)
	@echo "--- 🔨 Installing mloader into venv ---"
	@$(V_PIP) install -e .

create-directories:
	@echo "--- 📁 Creating necessary directories ---"
	@mkdir -p downloads output
	@echo "Directories created."

# เพิ่มคำสั่งสำหรับรันเพื่อทดสอบ
run:
	@$(VENV)/bin/mloader --help

clean:
	@echo "--- 🧹 Cleaning up ---"
	@rm -rf $(VENV)
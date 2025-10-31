# AIONVEST Makefile (no Docker)
# Note: jalankan perintah berikut dari direktori root repo ini

FRONTEND_DIR := frontend
BACKEND_DIR  := backend

.PHONY: help init init-frontend init-backend install dev dev-frontend dev-backend env-init clean

help:
	@echo "Available targets:"
	@echo "  make init            # Init frontend + backend (Next.js & NestJS)"
	@echo "  make init-frontend   # Init Next.js (TypeScript, Tailwind)"
	@echo "  make init-backend    # Init NestJS (TypeScript)"
	@echo "  make install         # npm install di frontend & backend"
	@echo "  make dev             # Jalankan dev server frontend & backend (2 terminal disarankan)"
	@echo "  make dev-frontend    # Jalankan dev server Next.js"
	@echo "  make dev-backend     # Jalankan dev server NestJS"
	@echo "  make env-init        # Buat file .env contoh untuk frontend & backend"
	@echo "  make clean           # Hapus node_modules & lockfiles (gunakan hati-hati)"

init: init-frontend init-backend env-init

init-frontend:
	npx create-next-app@latest $(FRONTEND_DIR) \
	  --ts \
	  --eslint \
	  --app \
	  --tailwind \
	  --use-npm \
	  --src-dir \
	  --import-alias "@/*"

init-backend:
	npx @nestjs/cli new $(BACKEND_DIR) --package-manager npm

install:
	npm install --prefix $(FRONTEND_DIR) || true
	npm install --prefix $(BACKEND_DIR) || true

# Saran: jalankan di dua terminal terpisah untuk pengalaman terbaik
dev: dev-backend

dev-frontend:
	npm run dev --prefix $(FRONTEND_DIR)

echo-backend-bootstrap:
	@echo "Jika backend belum memiliki script start:dev, jalankan:"
	@echo "npm i --save-dev @nestjs/cli && npm run start:dev --prefix $(BACKEND_DIR)"

dev-backend:
	npm run start:dev --prefix $(BACKEND_DIR)

env-init:
	@mkdir -p $(FRONTEND_DIR)
	@mkdir -p $(BACKEND_DIR)
	@touch $(FRONTEND_DIR)/.env.local
	@touch $(BACKEND_DIR)/.env
	@echo "# Frontend ENV" > $(FRONTEND_DIR)/.env.example
	@echo "NEXT_PUBLIC_API_BASE=http://localhost:3001" >> $(FRONTEND_DIR)/.env.example
	@cp -n $(FRONTEND_DIR)/.env.example $(FRONTEND_DIR)/.env.local 2>/dev/null || true
	@echo "# Backend ENV" > $(BACKEND_DIR)/.env.example
	@echo "PORT=3001" >> $(BACKEND_DIR)/.env.example
	@echo "# Pilih salah satu DB dan isi URL sesuai setup lokal Anda" >> $(BACKEND_DIR)/.env.example
	@echo "DATABASE_URL=mysql://user:pass@localhost:3306/aionvest" >> $(BACKEND_DIR)/.env.example
	@echo "# DATABASE_URL=postgresql://user:pass@localhost:5432/aionvest" >> $(BACKEND_DIR)/.env.example
	@echo "GEMINI_API_KEY=your_gemini_key_here" >> $(BACKEND_DIR)/.env.example
	@cp -n $(BACKEND_DIR)/.env.example $(BACKEND_DIR)/.env 2>/dev/null || true

clean:
	rm -rf $(FRONTEND_DIR)/node_modules $(BACKEND_DIR)/node_modules || true
	rm -f  $(FRONTEND_DIR)/package-lock.json $(BACKEND_DIR)/package-lock.json || true

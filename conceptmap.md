## **AIONVEST — Future-Value Investing AI Platform**

### Concept Map

#### **1. Project Vision**

Aionvest adalah platform analisis saham berbasis AI yang menekankan future-value investing: membeli bisnis berkualitas pada harga yang menarik, di mana nilai intrinsik masa depan (berdasarkan proyeksi arus kas dan fundamental) jauh melebihi harga saat ini. Fokus pada instrumen resmi ilmu keuangan: DCF/FCFF, Dividend/Gordon Growth, WACC via CAPM, Margin of Safety (MoS), expected CAGR, dan horizon investasi.

---

#### **2. Core Objectives**

* Mengotomasi valuasi intrinsik berbasis proyeksi dan discount rate.
* Menggabungkan data pasar, fundamental, dan sentimen berita sebagai katalis/risk modifiers.
* Memprioritaskan saham dengan MoS tinggi dan expected CAGR menarik pada horizon yang sesuai.
* Rekomendasi BUY/HOLD/SELL dengan confidence, risiko, dan penjelasan ringkas.

---

#### **3. System Architecture**

##### **A. Data Layer**

* **Sources:**

  * Stock Market APIs: IDX, Yahoo Finance, Alpha Vantage, IEX Cloud.
  * Fundamentals/Statements: balance sheet, income, cashflow APIs.
  * News APIs: Google News, Bloomberg, CNBC, IDX News Feed.
  * Corporate data: IPO, M&A, Rights Issue, Insider Reports.
* **Processing:**

  * ETL untuk pembersihan/normalisasi + mapping simbol.
  * Pembangunan proyeksi: growth, margin, capex, working capital, terminal growth.
  * Input suku bunga/risiko: risk-free, market premium, beta, cost of debt, struktur modal.
  * Periodik via CRON/queues.
  * Disimpan ke MariaDB/MySQL atau PostgreSQL (pilih salah satu untuk konsistensi proyek).

---

##### **B. AI & Analytics Layer**

1. **Fundamental Valuation Engine (Future Value)**

   * DCF/FCFF dan/atau Dividend (Gordon Growth) untuk nilai intrinsik.
   * Hitung WACC via CAPM (risk-free, beta, market premium) + biaya utang.
   * Sensitivitas terhadap growth/discount rate; margin/risiko operasional.

2. **Risk & MoS Engine**

   * Menurunkan Margin of Safety dari perbandingan harga vs fair value.
   * Menghasilkan risk factors dan confidence score.

3. **News Sentiment Engine**

   * NLP (BERT-based) untuk skor sentimen dan katalis.
   * Deteksi pola akuisisi/merger/insider.
   * Menjadi modifier untuk rekomendasi dan confidence.

4. **Market Pattern Engine**

   * Sinyal teknikal (RSI, MACD, Volume, Candles) sebagai konteks timing/horizon.

5. **Acquisition Potential Engine**

   * Kombinasi faktor valuasi, sentimen, dan pola pasar.
   * Menghasilkan “Acquisition Probability Score”.
   * Output terstruktur untuk dashboard.

   ```json
   {
     "symbol": "PANI",
     "fair_value": 1250,
     "current_price": 820,
     "margin_of_safety": 0.34,
     "expected_cagr": 0.20,
     "horizon_months": 24,
     "acquisition_score": 0.72,
     "sentiment": "bullish",
     "recommendation": "BUY",
     "confidence": 0.7,
     "risk_factors": ["raw material cost", "regulatory"]
   }
   ```

---

##### **C. Web Platform**

* **Frontend:** Next.js + TailwindCSS

  * Dashboard: ranking berdasar MoS dan expected CAGR, confidence, risk badges.
  * Detail: candlestick + fair value band, breakdown DCF (cashflows, WACC, sensitivitas), grafik CAGR/horizon.
  * Screener dan simulasi portofolio berbasis target return/horizon.

* **Backend:** NestJS

  * REST/GraphQL APIs.
  * Auth, caching, integrasi AI (Gemini) dan optional microservice Python (FastAPI) untuk NLP/model internal.
  * Endpoints tambahan: `/api/valuation/:symbol` untuk breakdown DCF/WACC.

* **Database:** MariaDB/MySQL atau PostgreSQL (pilih satu) + optional Redis Cache

---

##### **D. Deployment & Infrastructure**

* **Local Dev:** Makefile workflows (tanpa Docker) untuk init/install/dev.
* **Environment:** VPS Ubuntu (Node.js + PM2/Nginx) tanpa Docker.
* **CI/CD:** GitHub Actions (build/test, rsync/SSH deploy).
* **Domain:** `aionvest.vransenden.site`
* **Security:** HTTPS via Nginx + Certbot (Let’s Encrypt)
* **Background Jobs:** BullMQ / cron jobs

---

##### **E. Long-Term Add-ons**

* AI-powered portfolio advisor.
* Telegram/Discord bot for real-time notifications.
* Auto-trading module (paper-trading first, then live).
* Chrome extension for in-browser stock sentiment analysis.

---

## **Task List / GitHub Issues**

| #  | Task                                                | Description                                                                      | Label       |
| -- | --------------------------------------------------- | -------------------------------------------------------------------------------- | ----------- |
| 1  | **Initialize Project Structure (No Docker)**         | Buat `frontend` (Next.js) dan `backend` (NestJS) + Makefile workflows.            | setup       |
| 2  | **Env Config**                                       | Tambah `.env.example` untuk frontend/backend (API base, DB URL, GEMINI key).     | devops      |
| 3  | **Design Database Schema**                           | Tabel `stocks`, `news`, `analysis_results`, `watchlists`.                        | backend     |
| 4  | **Stock Data Fetcher**                               | NestJS module untuk data harga (Yahoo/IDX).                                      | backend     |
| 5  | **News Fetcher + Sentiment Stub**                    | Crawler/news API + parser sentimen dasar.                                        | backend     |
| 6  | **ValuationService (FV)**                            | Proyeksi, WACC/CAPM inputs, DCF/FCFF pipeline, sensitivitas.                     | ai          |
| 7  | **Gemini Integration (Reasoner)**                    | Prompt FV (MoS, expected CAGR, horizon, risks, confidence) + parsing JSON aman.  | ai          |
| 8  | **Backend API Integration**                          | Endpoint `/api/valuation/:symbol` + `/api/stocks/top` (MoS/CAGR).                | backend     |
| 9  | **Frontend Layout Setup**                            | Tailwind + layout dasar.                                                         | frontend    |
| 10 | **Dashboard (MoS/CAGR Ranking)**                     | Tabel/komponen ranking + filters/horizon.                                        | frontend    |
| 11 | **Stock Detail (Valuation Breakdown)**               | Candlestick + fair value band + DCF breakdown + risk/assumptions.                | frontend    |
| 12 | **Portfolio Simulator**                              | Simulasi berbasis target CAGR & horizon.                                         | frontend    |
| 13 | **User Authentication**                              | JWT-based auth (register/login).                                                 | backend     |
| 14 | **Deploy MVP (No Docker)**                           | VPS setup (Node, PM2, Nginx, Certbot) + GitHub Actions untuk deploy.             | devops      |
| 15 | **Add Telegram Bot**                                 | Notifier sinyal baru (BUY/HOLD/SELL).                                            | integration |
| 16 | **Documentation & README Update**                    | Panduan setup lokal (Makefile), arsitektur FV, diagram, usage.                   | docs        |

---

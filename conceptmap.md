## **AIONVEST — AI-Powered Stock Analysis Platform**

### Concept Map

#### **1. Project Vision**

Aionvest is an AI-driven stock analysis platform that automates market research, identifies undervalued companies, and predicts potential acquisition targets based on financial data, sentiment analysis, and behavioral patterns.

---

#### **2. Core Objectives**

* Replace manual stock analysis with AI-based automation.
* Integrate both **market data** and **news sentiment**.
* Identify **undervalued stocks** with high **acquisition probability**.
* Generate actionable buy/sell recommendations.

---

#### **3. System Architecture**

##### **A. Data Layer**

* **Sources:**

  * Stock Market APIs: IDX, Yahoo Finance, Alpha Vantage, IEX Cloud.
  * News APIs: Google News, Bloomberg, CNBC, IDX News Feed.
  * Corporate data: IPO, M&A, Rights Issue, Insider Reports.
* **Processing:**

  * ETL for cleaning and normalizing datasets.
  * Periodic updates via CRON or background jobs.
  * Stored in PostgreSQL or MongoDB.

---

##### **B. AI & Analytics Layer**

1. **Fundamental Analysis Engine**

   * Calculates intrinsic value, P/E, PBV, EPS growth, ROE.
   * Detects undervalued / overvalued stocks.
   * Predicts potential growth using regression / LSTM models.

2. **News Sentiment Engine**

   * NLP model (BERT-based) for sentiment scoring of company-related news.
   * Detects acquisition, merger, or insider activity patterns.
   * Outputs daily sentiment index per stock.

3. **Market Pattern Engine**

   * Technical signal recognition (RSI, MACD, Volume, Candle Patterns).
   * Detects hidden accumulation or abnormal behavior.

4. **Acquisition Potential Engine**

   * Combines results from the three engines above.
   * Computes an “Acquisition Probability Score”.
   * Produces structured output for the dashboard.

   ```json
   {
     "symbol": "PANI",
     "acquisition_score": 0.87,
     "valuation_status": "undervalued",
     "sentiment": "bullish",
     "recommendation": "BUY"
   }
   ```

---

##### **C. Web Platform**

* **Frontend:** Next.js + TailwindCSS

  * Interactive dashboard & charts (via TradingView API).
  * Visualization of AI insights and valuation trends.
  * Stock screener and portfolio simulation.

* **Backend:** NestJS

  * REST/GraphQL APIs for frontend consumption.
  * Handles authentication, caching, and AI model integration.
  * Connects to Python microservice for AI computations (via FastAPI).

* **Database:** PostgreSQL + Redis Cache

---

##### **D. Deployment & Infrastructure**

* **Environment:** Ubuntu VPS / Dockerized setup
* **CI/CD:** GitHub Actions
* **Domain:** `aionvest.vransenden.site`
* **Security:** HTTPS via Certbot / Let’s Encrypt
* **Background Jobs:** BullMQ / Celery

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
| 1  | **Initialize Project Structure**                    | Create `frontend` (Next.js) and `backend` (NestJS) directories with basic setup. | setup       |
| 2  | **Setup Docker & Env Config**                       | Add Dockerfiles for both apps + docker-compose.yml.                              | devops      |
| 3  | **Design Database Schema**                          | Plan tables for stocks, news, analysis_results, and user watchlists.             | backend     |
| 4  | **Implement Stock Data Fetcher**                    | Build a NestJS module to pull data from Yahoo Finance or IDX API.                | backend     |
| 5  | **Implement News Fetcher + Sentiment Preprocessor** | Basic news crawler and sentiment parser (stub).                                  | backend     |
| 6  | **Integrate AI Microservice (Python)**              | Create FastAPI service that handles ML model inference.                          | ai          |
| 7  | **AI Model: Fundamental Analysis**                  | Implement basic fair value predictor using regression/LSTM.                      | ai          |
| 8  | **AI Model: News Sentiment**                        | Train BERT-based model for sentiment scoring.                                    | ai          |
| 9  | **AI Model: Acquisition Probability Engine**        | Combine data from models to compute acquisition likelihood.                      | ai          |
| 10 | **Backend API Integration**                         | Connect NestJS endpoints to AI microservice.                                     | backend     |
| 11 | **Frontend Layout Setup**                           | Initialize Tailwind theme and layout (Next.js app).                              | frontend    |
| 12 | **Dashboard UI**                                    | Build main dashboard with charts, scores, and recommendations.                   | frontend    |
| 13 | **Portfolio Simulator**                             | Implement mock portfolio tracking based on AI recommendations.                   | frontend    |
| 14 | **User Authentication**                             | JWT-based auth (register/login).                                                 | backend     |
| 15 | **Deploy MVP**                                      | Deploy full stack to VPS (Docker Compose).                                       | devops      |
| 16 | **Add Telegram Bot**                                | Integrate simple notifier for new buy/sell signals.                              | integration |
| 17 | **Documentation & README Update**                   | Add setup guide, architecture diagram, and usage docs.                           | docs        |

---

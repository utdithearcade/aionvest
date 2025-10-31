# AIONVEST

**Future-Value Investing AI Platform**

Aionvest is an AI-driven stock analysis platform that emphasizes future-value investing: buying quality businesses at attractive prices where the intrinsic future value far exceeds today's cost. The platform uses official financial methods such as DCF/FCFF, Dividend/Gordon Growth Model, WACC via CAPM, Margin of Safety, and expected CAGR to provide data-driven investment recommendations.

## Philosophy

**"Buy when current valuation is relatively small vs prospective future value"**

Focus on opportunities where small expenditures today can balloon into significant profits in the future through deep fundamental analysis and accurate cash flow projections.

## Tech Stack

- **Frontend**: Next.js 15 + TypeScript + Tailwind CSS
- **Backend**: NestJS + TypeScript
- **AI Engine**: Google Gemini API
- **Database**: MariaDB/MySQL
- **Charts**: ApexCharts / Chart.js
- **Development**: Makefile workflows (no Docker)
- **Deployment**: VPS Ubuntu + PM2 + Nginx + Certbot

## Key Features

### Core Valuation Engine
- **DCF/FCFF Analysis**: Discounted Cash Flow dengan Free Cash Flow to Firm
- **Dividend Growth Model**: Gordon Growth untuk saham dividend-paying
- **WACC Calculation**: Weighted Average Cost of Capital via CAPM
- **Margin of Safety**: Buffer antara fair value dan market price
- **Expected CAGR**: Compound Annual Growth Rate proyeksi
- **Investment Horizon**: Timeline optimal untuk holding period

### AI-Powered Insights
- **Fundamental Analysis**: Proyeksi revenue, margin, capex, working capital
- **Risk Assessment**: Identifikasi risk factors dan confidence scoring
- **Sentiment Analysis**: News sentiment sebagai catalyst/risk modifier
- **Acquisition Probability**: Deteksi potensi target akuisisi

### Dashboard & Visualization
- **Ranking System**: Berdasarkan Margin of Safety dan expected CAGR
- **Interactive Charts**: Candlestick dengan fair value band overlay
- **DCF Breakdown**: Visualisasi komponen valuasi dan sensitivitas
- **Portfolio Simulation**: Mock tracking berdasarkan AI recommendations

## Quick Start

### Prerequisites
- Node.js 18+ dan npm
- MariaDB/MySQL server
- Google Gemini API key

### Setup

```bash
# Clone repository
git clone <repo-url>
cd aionvest

# Initialize project structure
make init

# Install dependencies
make install

# Setup environment variables
cp frontend/.env.example frontend/.env.local
cp backend/.env.example backend/.env

# Edit environment files with your credentials
# frontend/.env.local:
NEXT_PUBLIC_API_BASE=http://localhost:3001

# backend/.env:
PORT=3001
DATABASE_URL=mysql://user:password@localhost:3306/aionvest
GEMINI_API_KEY=your_gemini_api_key_here
```

### Database Setup

```sql
-- Create database
CREATE DATABASE aionvest;

-- Create user (optional)
CREATE USER 'aionvest_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON aionvest.* TO 'aionvest_user'@'localhost';
FLUSH PRIVILEGES;
```

### Development

```bash
# Terminal 1: Start backend (NestJS)
make dev-backend

# Terminal 2: Start frontend (Next.js)
make dev-frontend
```

Access:
- Frontend: http://localhost:3000
- Backend API: http://localhost:3001

## Makefile Commands

```bash
make help           # Show available commands
make init           # Initialize Next.js + NestJS projects
make install        # Install dependencies for both apps
make dev            # Start backend (use separate terminals for frontend)
make dev-frontend   # Start Next.js dev server
make dev-backend    # Start NestJS dev server
make env-init       # Create .env example files
make clean          # Remove node_modules and lockfiles
```

## API Endpoints

| Method | Endpoint                  | Description                                  |
|--------|---------------------------|----------------------------------------------|
| GET    | `/api/stocks`             | Retrieves list of tracked stocks             |
| GET    | `/api/stocks/:symbol`     | Retrieves data for a specific stock          |
| GET    | `/api/analysis/:symbol`   | Retrieves AI analysis result                 |
| POST   | `/api/analyze/:symbol`    | Executes new AI analysis via Gemini          |
| GET    | `/api/stocks/top`         | Lists top stocks by MoS/expected CAGR        |
| GET    | `/api/valuation/:symbol`  | Returns valuation components (DCF breakdown) |

## AI Output Schema

```json
{
  "fair_value": 3850,
  "current_price": 2800,
  "margin_of_safety": 0.27,
  "expected_cagr": 0.18,
  "horizon_months": 24,
  "valuation_gap": 0.35,
  "sentiment_score": 0.4,
  "acquisition_probability": 0.7,
  "recommendation": "BUY",
  "confidence": 0.72,
  "risk_factors": ["cyclical demand", "FX exposure"],
  "explanation": "DCF suggests intrinsic value above current price with sufficient margin of safety; fundamentals and sentiment supportive over a 24-month horizon."
}
```

## Database Schema

### Core Tables

**stocks**
- Basic company information (symbol, name, sector, market_cap)

**news**
- News articles with sentiment analysis (title, content, published_at)

**analysis_results**
- AI valuation outputs with all metrics (fair_value, margin_of_safety, expected_cagr, etc.)

## Development Roadmap

- [x] **Phase 1**: Project scaffolding (Next.js + NestJS + Makefile)
- [ ] **Phase 2**: Database schema + ORM setup (TypeORM + MariaDB)
- [ ] **Phase 3**: Data fetchers (market data + news APIs)
- [ ] **Phase 4**: ValuationService (DCF/FCFF + WACC/CAPM)
- [ ] **Phase 5**: Gemini integration (future-value prompts)
- [ ] **Phase 6**: Frontend dashboard (MoS/CAGR ranking)
- [ ] **Phase 7**: Stock detail pages (charts + DCF breakdown)
- [ ] **Phase 8**: Portfolio simulation
- [ ] **Phase 9**: Authentication system
- [ ] **Phase 10**: Production deployment (VPS + CI/CD)

## Data Sources

### Legal & Compliant
- **Market Data**: Alpha Vantage API (free tier available)
- **News**: Google News RSS feeds (legal for aggregation)
- **Fundamentals**: Financial statements via API providers
- **Risk-Free Rate**: Government bond yields
- **Market Premium**: Historical market return data

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This platform is for educational and research purposes. All investment decisions should be made with proper due diligence and risk assessment. Past performance does not guarantee future results. Always consult with qualified financial advisors before making investment decisions.

---

**Built with passion for intelligent investing and financial technology.**

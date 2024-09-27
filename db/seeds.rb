# Users
john = User.find_or_create_by!(email: "johndoe@test.com") do |user|
  user.name = "John Doe"
  user.password = "john1234"
  user.password_confirmation = "john1234"
end

jane = User.find_or_create_by!(email: "janedoe@test.com") do |user|
  user.name = "Jane Doe"
  user.password = "jane1234"
  user.password_confirmation = "jane1234"
end

sample_stocks = [
  {
    name: "Reliance Industries Limited",
    ticker: "RELIANCE",
    exchange: "NSE",
    isin: "INE002A01018",
    company_name: "Reliance Industries Limited",
    bse_code: 500325,
    nse_code: "RELIANCE",
    sector: "Energy",
  },
  {
    name: "Tata Consultancy Services Limited",
    ticker: "TCS",
    exchange: "NSE",
    isin: "INE467B01029",
    company_name: "Tata Consultancy Services Limited",
    bse_code: 532540,
    nse_code: "TCS",
    sector: "Information Technology",
  },
  {
    name: "HDFC Bank Limited",
    ticker: "HDFCBANK",
    exchange: "NSE",
    isin: "INE040A01034",
    company_name: "HDFC Bank Limited",
    bse_code: 500180,
    nse_code: "HDFCBANK",
    sector: "Financial Services",
  },
  {
    name: "Infosys Limited",
    ticker: "INFY",
    exchange: "NSE",
    isin: "INE009A01021",
    company_name: "Infosys Limited",
    bse_code: 500209,
    nse_code: "INFY",
    sector: "Information Technology",
  },
  {
    name: "ICICI Bank Limited",
    ticker: "ICICIBANK",
    exchange: "NSE",
    isin: "INE090A01021",
    company_name: "ICICI Bank Limited",
    bse_code: 532174,
    nse_code: "ICICIBANK",
    sector: "Financial Services",
  },
]

sample_stocks.each do |stock|
  Stock.find_or_create_by!(ticker: stock[:ticker]) do |s|
    s.name = stock[:name]
    s.exchange = stock[:exchange]
    s.isin = stock[:isin]
    s.company_name = stock[:company_name]
    s.bse_code = stock[:bse_code]
    s.nse_code = stock[:nse_code]
    s.sector = stock[:sector]
  end
end

MoneyRails.configure do |config|
  config.default_currency = :eur  # or :gbp, :usd, etc.
  # config.default_format = {sign_before_symbol: true}
  MoneyRails.sign_before_symbol = true
end

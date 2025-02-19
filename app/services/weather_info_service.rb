require 'httparty'

class WeatherInfoService
  BASE_URL = "https://api.weatherapi.com/v1/forecast.json"

  def self.get_forecast(address)
    zip_code = extract_postal_code(address)
    return log_and_return_error("Invalid address: #{address}") if zip_code.nil?

    # Check cache before making an API request
    if (cached_data = Rails.cache.read(zip_code))
      Rails.logger.info "Cache HIT for ZIP: #{zip_code}"
      return cached_data.merge(cached: true)
    end

    Rails.logger.info "Cache MISS for ZIP: #{zip_code}, making API request..."
    fetch_and_cache_weather(zip_code)
  end

  private

  # Extract postal code globally
  def self.extract_postal_code(address)
    postal_code_regex = /\b[A-Z0-9][A-Z0-9\- ]{2,10}[A-Z0-9]\b/i
    zip = address.match(postal_code_regex)&.to_s
    Rails.logger.info "Extracted Postal Code: #{zip}"
    zip
  end

  # Fetch weather data from API and store in cache
  def self.fetch_and_cache_weather(zip_code)
    response = HTTParty.get("#{BASE_URL}?key=#{ENV['WEATHER_API_KEY']}&q=#{zip_code}&days=1")

    return log_and_return_error("API Request Failed: #{response.code} - #{response.message}") unless response.success?

    weather_data = extract_weather_data(response)
    
    # Store in cache
    Rails.cache.write(zip_code, weather_data, expires_in: 30.minutes)
    Rails.logger.info "Stored in cache for ZIP: #{zip_code}"

    weather_data
  end

  # Extract relevant weather data from API response
  def self.extract_weather_data(response)
    {
      temperature: response.dig("current", "temp_c"),
      high: response.dig("forecast", "forecastday", 0, "day", "maxtemp_c"),
      low: response.dig("forecast", "forecastday", 0, "day", "mintemp_c"),
      condition: response.dig("current", "condition", "text"),
      cached: false
    }
  end

  # Log error and return error response
  def self.log_and_return_error(message)
    Rails.logger.error message
    { error: message }
  end
end

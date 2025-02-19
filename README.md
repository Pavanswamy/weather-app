## **🌦️ Weather Forecast App (Ruby on Rails)**

A simple weather forecasting app built with **Ruby on Rails** that fetches **real-time weather data** using the [WeatherAPI](https://www.weatherapi.com/).

✅ **Supports global addresses**  
✅ **Displays current, high & low temperatures**  
✅ **Caches results for 30 minutes**

---

## **🚀 Features**

- 🌍 **Enter any address or ZIP code** (Supports global locations)
- 🌡️ **Fetches real-time weather data** (Current, High, Low temperatures)
- ⚡ **Fast with caching** (Stores results for 30 minutes using Redis)

---

## **🛠️ Setup & Installation**

### **1️⃣ Clone the Repository**

```sh
git clone https://github.com/Pavanswamy/weather-app.git
cd weather-app
```

### **2️⃣ Install Dependencies**

```sh
bundle install
```

### **3️⃣ Setup Redis for Caching**

Ensure Redis is running for caching to work:

```sh
redis-server
```

### **4️⃣ Get a WeatherAPI Key**

Sign up at [WeatherAPI](https://www.weatherapi.com/) and get a **free API key**.

Create a `.env` file in the project root and add:

```sh
WEATHER_API_KEY=your_api_key_here
```

### **5️⃣ Run Database Migrations**

```sh
rails db:migrate
```

### **6️⃣ Start the Rails Server**

```sh
rails server
```

Visit: **`http://localhost:3000/`**

---

## **📜 API Usage**

The app fetches weather data using the following API:

```sh
https://api.weatherapi.com/v1/forecast.json?key=YOUR_API_KEY&q=ADDRESS&days=1
```

**Example Request:**

```sh
http://localhost:3000/weather?address=New York
```

**Example Response (JSON):**

```json
{
  "temperature": 15.2,
  "high": 20.0,
  "low": 10.5,
  "condition": "Sunny",
  "cached": false
}
```

---

## **🔧 Tech Stack**

- **Ruby on Rails** (Backend)
- **HTTParty** (API Requests)
- **Redis** (Caching)

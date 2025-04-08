# Weather Getter 🌤️

A lightweight Ruby on Rails app that fetches and displays weather forecast data using the [WeatherAPI](https://www.weatherapi.com/).

## Features

- Accepts a US postal code and fetches the 3-day forecast
- Displays current, daily, and hourly forecast
- Caches results for 30 minutes by postal code
- Shows an indicator when data is served from cache
- Includes test coverage for controller, service, and model layers

## Tech Stack

- Ruby on Rails
- Minitest + Mocha for testing
- WeatherAPI for forecast data

## Setup Instructions

### 1. Clone the repo
```
git clone https://github.com/your-username/weathered.git
cd weathered
```

### 2. Install dependencies:
```
bundle install
```

### 3. Setup your WeatherAPI key by following their instructions:
https://www.weatherapi.com/docs/ 

### 4. Create a .env file in the root:
(Or set it in your shell environment)
```
WEATHER_API_KEY=your_api_key_here
```

Run the server:
```
bin/rails server
```

Open in browser:
```
http://localhost:3000
```

Running Tests
```
bin/rails test
```

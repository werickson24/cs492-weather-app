String getIcon(shortForecast, isDaytime){
  if (shortForecast.toLowerCase().contains("sunny")) {
    return "assets/weather_icons/sunny.svg";
  } else if (shortForecast.toLowerCase().contains("clear")) {
    if (isDaytime) {
      return "assets/weather_icons/sunny.svg";
    } else {
      return "assets/weather_icons/clear.svg";
    }
  } else if (shortForecast.toLowerCase().contains("mostly cloudy")) {
    if (isDaytime) {
      return "assets/weather_icons/mostly_cloudy.svg";
    } else {
      return "assets/weather_icons/mostly_cloudy_night.svg";
    }
  } else if (shortForecast.toLowerCase().contains("partly cloudy")) {
    if (isDaytime) {
      return "assets/weather_icons/partly_cloudy.svg";
    } else {
      return "assets/weather_icons/partly_clear.svg";
    }
  } else if (shortForecast.toLowerCase().contains("cloudy")) {
    return "assets/weather_icons/cloudy.svg";
  } else if (shortForecast.toLowerCase().contains("thunderstorms")) {
    return "assets/weather_icons/strong_tstorms.svg";
  } else if (shortForecast.toLowerCase().contains("drizzle")) {
    return "assets/weather_icons/drizzle.svg";
  } else if (shortForecast.toLowerCase().contains("rain showers")) {
    return "assets/weather_icons/scattered_showers.svg";
  } else if (shortForecast.toLowerCase().contains("rain")) {
    return "assets/weather_icons/droplet_heavy.svg";
  } else if (shortForecast.toLowerCase().contains("snow showers")) {
    return "assets/weather_icons/scattered_snow.svg";
  } else if (shortForecast.toLowerCase().contains("blowing snow")) {
    return "assets/weather_icons/blowing_snow.svg";
  } else if (shortForecast.toLowerCase().contains("heavy snow")) {
    return "assets/weather_icons/heavy_snow.svg";
  } else if (shortForecast.toLowerCase().contains("light snow")) {
    return "assets/weather_icons/flurries.svg";
  } else if (shortForecast.toLowerCase().contains("snow")) {
    return "assets/weather_icons/snow_showers.svg";
  } else if (shortForecast.toLowerCase().contains("frost")) {
    return "assets/weather_icons/icy.svg";
  } else if (shortForecast.toLowerCase().contains("fog")) {
    return "assets/weather_icons/fog.svg";
  } else if (shortForecast.toLowerCase().contains("sleet") ||
      shortForecast.contains("hail")) {
    return "assets/weather_icons/sleet_hail.svg";
  } else {
    return "assets/weather_icons/question.svg";
  }
}
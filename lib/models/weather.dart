class Weather {
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final String cityName;

  const Weather({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      cityName: json['name'] as String,
    );
  }

  String get temperatureString => '${temperature.round()}°C';
  
  String get capitalizedDescription => 
      description.split(' ').map((word) => 
          word.isEmpty ? word : word[0].toUpperCase() + word.substring(1)
      ).join(' ');

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  // Weather emoji based on icon code
  String get emoji {
    if (icon.startsWith('01')) return '☀️'; // clear sky
    if (icon.startsWith('02')) return '⛅'; // few clouds
    if (icon.startsWith('03')) return '☁️'; // scattered clouds
    if (icon.startsWith('04')) return '☁️'; // broken clouds
    if (icon.startsWith('09')) return '🌦️'; // shower rain
    if (icon.startsWith('10')) return '🌧️'; // rain
    if (icon.startsWith('11')) return '⛈️'; // thunderstorm
    if (icon.startsWith('13')) return '❄️'; // snow
    if (icon.startsWith('50')) return '🌫️'; // mist
    return '🌤️'; // default
  }

  @override
  String toString() {
    return 'Weather(temperature: $temperatureString, description: $description, city: $cityName)';
  }
}
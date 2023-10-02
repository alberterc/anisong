double fontSizeLargerOffset = 4.0;

class Mobile {
  static double minScreenWidth = 750.0;
  static double fontSize = 12.0;

  // grid view related
  static double childAspectRatio = (1 / 1.5);
}

class Dekstop {
  static double fontSize = 18.0;

  // grid view related
  static double childAspectRatio = (2 / 3);
}

// var cardSize = screenSize.width <= Mobile.minScreenWidth ? {'height': 215.0, 'width': 125.0} : {'height': 315.0, 'width': 225.0};

class JikanApi {
  static String baseUrl = 'https://api.jikan.moe/v4';
  static String animeSearch = '/anime'; // https://api.jikan.moe/v4/anime[?page=1&q=str ...etc]
  static String themes = '/themes'; // https://api.jikan.moe/v4/anime/{id}/themes
}

class CommonUrl {
  static String youtube = 'https://www.youtube.com';
}
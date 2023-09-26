class Mobile {
  static double minScreenWidth = 750.0;
  static double fontSize = 12.0;

  // grid view related
  static double childAspectRatio = (1.2 / 1.5);
}

class Dekstop {
  static double fontSize = 18.0;

  // grid view related
  static double childAspectRatio = (2 / 4);
}

class JikanApi {
  static String baseUrl = 'https://api.jikan.moe/v4';
  static String animeSearch = '/anime'; // https://api.jikan.moe/v4/anime[?page=1&q=str ...etc]
  static String themes = '/themes'; // https://api.jikan.moe/v4/anime/{id}/themes
}
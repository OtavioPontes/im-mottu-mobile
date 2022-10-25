class URI {
  static String baseUrl = 'https://gateway.marvel.com/v1/public';
  static String characters = '$baseUrl/characters';
  static String event({required int id}) => '$baseUrl/characters/$id/events';
}

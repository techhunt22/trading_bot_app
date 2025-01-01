class ListAPI {
  ListAPI._();

  //BASE URL
  static const String baseUrl = "https://opo.techhunt.info";



  //Create Account API ENDPOINT
  static const String createaccount = "/create-account";
  static const String getallaccounts = "/accounts";
  static const String buycoins = "/buy-coin";
  static const String sellcoins = "/sell-coin";
  static const String startbot = "/start";
  static const String stopbot = "/stop";

  static String deleteaccount(String id) {
    return "/accounts/$id";
  }

  static String updateaccount(String id) {
    return "/accounts/$id";
  }


}
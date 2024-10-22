class ListAPI {
  ListAPI._();

  //BASE URL
  static const String baseUrl = "http://192.168.50.204:3000";


  //Create Account API ENDPOINT
  static const String createaccount = "/accounts";
  static const String getallaccounts = "/accounts";

  static String updateaccount(String id) {
    return "/accounts/$id";
  }


}
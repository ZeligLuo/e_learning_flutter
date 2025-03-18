
class AppConstants{
  // server API url can change based on the server hosting or mobile device
  // with local host can use http
  // android is http://10.0.2.2:8000/ and ios is http://127.0.0.1:8000/
  // hosting https to fetch lesson video data
  static const String SERVER_API_URL = "http://10.0.2.2:8000/";
  // url for data fetching
  static const String IMAGE_UPLOADS_PATH = "${SERVER_API_URL}uploads/";
  static const String STORAGE_USER_PROFILE_KEY = "user_profile";
  static const String STORAGE_USER_TOKEN_KEY = "user_token";
  static const String STORAGE_DEVICE_OPEN_FIRST_KEY = "first_time";
}

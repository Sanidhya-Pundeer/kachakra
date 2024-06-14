class ApiConstants {
  static const String baseUrl = 'https://keemti.avsportswear.com/api';

  static const String userLogin = '$baseUrl/user-login.php?accesskey=12345';

  static const String getUser = '$baseUrl/get-user.php?acceskey=12345&user_id=';

  static const String getAllUser = '$baseUrl/get-all-users.php?accesskey=12345';

  static const String getDrainService = '$baseUrl/get-drain-service.php?accesskey=12345';

  static const String getCleanerService = '$baseUrl/get-cleaner-service.php?accesskey=12345';

  static const String addUser = '$baseUrl/add-user.php?accesskey=12345';

  static const String addRequest = '$baseUrl/add-request.php?accesskey=12345';

  static const String getRequestCurrentStatusByID = '$baseUrl/get-request-current-status-by-id.php?accesskey=12345&user_id=';

  static const String updateRequest = '$baseUrl/update-request.php?accesskey=12345&request_id=';

  static const String getRequest = '$baseUrl/get-all-request.php?accesskey=12345';

  static const String getRequestByID = '$baseUrl/get-request-by-id.php?accesskey=12345&user_id=';

  static const String submitComplaint = '$baseUrl/submit-complaint-by-id.php?accesskey=12345';

  static const String submitComplaintPhotos = '$baseUrl/submit-complaint-photos.php?accesskey=12345';


  // Add more endpoints as needed
}

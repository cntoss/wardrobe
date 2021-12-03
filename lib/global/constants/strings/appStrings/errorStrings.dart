class ErrorStrings {
  //!Dio specific errors
  String get dioCancel => "Request to server was cancelled. Please try again.";
  String get dioConnectionTimeOout =>
      "Connection timeout with server. Please try again.";
  String get dioDefault =>
      "No internet connection. Please verify your internet connection.";
  String get dioRecieveTimeout =>
      "Receive timeout in connection with server.Please try again.";
  String get dioSendTimeout => "Send timeout in connection with server.";
  String get dio401 =>
      'Unauthorized attempt.Authorization credentials were not provided.';
  String get dio400 => 'Bad request. Please try again.';
  String get dio404 =>
      'The requested resource was not found. Please try again.';
  String get dio500 => 'Internal server error has occured. Please try again.';
  String get unknownError => 'Unknown error has occurred. Please try again.';
  //!Dio specific errors
}

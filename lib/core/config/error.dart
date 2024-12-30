class StateError {
  final String message;
  final String code;
  final String consoleMessage;

  const StateError(
      {this.message = "Something went wrong, Please try again later",
      this.code = "",
      this.consoleMessage = ""});

  factory StateError.initial() => const StateError();
}

enum StateStatus { initial, loading, failure, success }

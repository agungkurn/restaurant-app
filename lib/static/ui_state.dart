sealed class UiState {}

class Idle extends UiState {}

class Loading extends UiState {}

class Success<T> extends UiState {
  final T data;

  Success(this.data);
}

class Error extends UiState {
  final String errorMessage;

  Error(this.errorMessage);
}

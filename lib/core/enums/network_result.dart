class NetworkResult<T>{
  final T? data;
  final String? message;
  
  NetworkResult({this.data, this.message});
}

class ResultSuccess<T> extends NetworkResult<T>{
  ResultSuccess(T data) : super(data: data);
}

class ResultError<T> extends NetworkResult<T>{
  ResultError(String message) : super(message: message);
}

class ResultLoading<T> extends NetworkResult<T>{
  ResultLoading();
}

class ResultInit<T> extends NetworkResult<T>{
  ResultInit();
}


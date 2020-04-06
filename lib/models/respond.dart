class Respond<T> {
  bool success;
  String error;
  T result;

  Respond(this.success, {this.result, this.error});
}

class Res<T> {
  bool success;
  String error;
  T result;

  Res(this.success, {this.result, this.error});
}

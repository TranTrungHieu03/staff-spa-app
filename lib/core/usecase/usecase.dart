abstract interface class UseCase<SuccessType, Params> {
  Future<SuccessType> call(Params params);
}

class NoParams {}

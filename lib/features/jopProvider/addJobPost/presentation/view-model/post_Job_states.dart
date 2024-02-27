class PostJobStates {}

class PostJobInitState extends PostJobStates {}

// login
class PostJobLoadingState extends PostJobStates {}

class PostJobSuccessState extends PostJobStates {}

class PostJobErrorState extends PostJobStates {
  final String error;

  PostJobErrorState({required this.error});
}

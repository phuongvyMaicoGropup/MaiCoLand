class UserReponse {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String photoURL;

  UserReponse(
      {
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.photoURL,
      required this.username,
      required this.email});
}

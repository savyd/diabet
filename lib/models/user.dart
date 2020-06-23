class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String phone;
  final String gender;
  final String birthDate;
  final String weight;
  final String height;

  UserData(
      {this.uid,
      this.name,
      this.phone,
      this.gender,
      this.birthDate,
      this.weight,
      this.height});
}

class ModelClass{
  final int? id;
  final String name;
  final String email;
  final String dob;
  final String course;
  final String adm_no;
  final String mob;
  final String password;

  ModelClass({
    this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.course,
    required this.adm_no,
    required this.mob,
    required this.password
  });

  factory ModelClass.fromMap(Map<String, dynamic> json) =>
  ModelClass(id: json["id"], name: json["name"], email: json["email"], dob: json["dob"], course: json["course"], adm_no: json["adm_no"], mob: json["mob"], password: json["password"]);

  Map<String, dynamic> toMap() => {
    "id" : id,
    "name" : name,
    "email" : email,
    "dob" : dob,
    "course" : course,
    "adm_no" : adm_no,
    "mob" : mob,
    "password" : password
  };
}
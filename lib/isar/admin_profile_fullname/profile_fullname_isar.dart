import 'package:isar_community/isar.dart';

part 'profile_fullname_isar.g.dart';

@embedded
class FullName {
  String? firstName;
  String? lastName;

  FullName(
      {this.firstName,this.lastName});

  factory FullName.fromJson(Map<String, dynamic> json) {
    return FullName(
      firstName: json['first_name'].toString(),
      lastName: json['last_name'].toString(),
     
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
       
      };
}

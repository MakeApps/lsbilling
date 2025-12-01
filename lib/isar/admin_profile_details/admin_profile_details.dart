import 'package:isar_community/isar.dart';

part 'admin_profile_details.g.dart';

@embedded
class Details {
  String? city;
  String? mobileNumber;
  String? pincode;
  String? state;
  String? street;

  Details(
      {this.city, this.mobileNumber, this.pincode, this.state, this.street});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      city: json['city'].toString(),
      mobileNumber: json['mobile_numbe'].toString(),
      pincode: json['pincode'].toString(),
      state: json['state'].toString(),
      street: json['street'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'city': city,
        'mobileNumber': mobileNumber,
        'pincode': pincode,
        'state': state,
        'street': street
      };
}

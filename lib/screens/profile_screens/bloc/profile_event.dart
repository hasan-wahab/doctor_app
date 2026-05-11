import 'dart:io';

abstract class ProfileEvents {}

class MyProfileEvent extends ProfileEvents {}

class UpdateProfileEvent extends ProfileEvents {
  final File? path;
  final String name;
  final String email;
  final String cnic;
  final String phone;
  final String birthDate;
  final String gender;
  UpdateProfileEvent({
    this.path,
    required this.name,
    required this.email,
    required this.cnic,
    required this.phone,
    required this.birthDate,
    required this.gender
  });
}

import 'dart:io';

class Contact {
  final File? image;
  final String? first_name;
  final String? last_name;
  final String? phone_number;
  final String? email;

  Contact({
    required this.phone_number,
    required this.image,
    required this.first_name,
    required this.last_name,
    required this.email,
  });
}

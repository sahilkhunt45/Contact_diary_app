import 'package:contacs/screens/dashbord.dart';
import 'package:contacs/screens/detailpage.dart';
import 'package:contacs/screens/edit_contact.dart';
import 'package:flutter/material.dart';

import 'all_contacts.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      initialRoute: 'homepage',
      routes: {
        'homepage': (context) => const Homepage(),
        'detail_page': (context) => const Detail_Page(),
        'all_contacts': (context) => const All_Contacts(),
        'edit_contacts': (context) => const Edite_Contact(),
      },
    ),
  );
}

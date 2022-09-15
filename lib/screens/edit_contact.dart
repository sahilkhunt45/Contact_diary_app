import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../app_theme.dart';
import '../contact_model.dart';
import '../global.dart';

class Edite_Contact extends StatefulWidget {
  const Edite_Contact({Key? key}) : super(key: key);

  @override
  State<Edite_Contact> createState() => _Edite_ContactState();
}

class _Edite_ContactState extends State<Edite_Contact> {
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _updatecontactkey = GlobalKey<FormState>();

  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  String? _firstname;
  String? _lastname;
  String? _phonenumber;
  String? _email;
  File? _image;

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;

    _firstnamecontroller.text = data.first_name;
    _lastnamecontroller.text = data.last_name;
    _phonenumbercontroller.text = data.phone_number;
    _emailcontroller.text = data.email;

    return Scaffold(
      backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();

            _firstnamecontroller.clear();
            _lastnamecontroller.clear();
            _phonenumbercontroller.clear();
            _emailcontroller.clear();

            setState(() {
              _firstname = "";
              _lastname = "";
              _phonenumber = "";
              _email = "";
            });
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
          color: Colors.black,
        ),
        title: Text(
          "Edit",
          style: TextStyle(
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_updatecontactkey.currentState!.validate()) {
                _updatecontactkey.currentState!.save();
                Contact c1 = Contact(
                  phone_number: _phonenumber,
                  image: _image,
                  first_name: _firstname,
                  last_name: _lastname,
                  email: _email,
                );

                int i = Global.allcontacts.indexOf(data);
                Global.allcontacts[i] = (c1);

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('homepage', (route) => false);
              }
            },
            icon: const Icon(Icons.check),
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        (_image != null) ? FileImage(_image!) : null,
                    radius: 45,
                    backgroundColor: Colors.grey.shade400,
                    child: (_image != null)
                        ? const Text("")
                        : Text(
                            "Edit",
                            style: TextStyle(
                              color: (AppTheme.isDark)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Edit Photo",
                            style: TextStyle(
                                color: (AppTheme.isDark)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          actions: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      XFile? pickedFile =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      setState(() {
                                        Navigator.of(context).pop();
                                        _image = File(pickedFile!.path);
                                      });
                                    },
                                    child: const Text(
                                      "Take your photo\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      XFile? pickedFile =
                                          await _picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      setState(() {
                                        Navigator.of(context).pop();
                                        _image = File(pickedFile!.path);
                                      });
                                    },
                                    child: const Text(
                                      "Chose Form Gallary\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        Navigator.of(context).pop();
                                        _image = null;
                                      });
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete),
                                        Text(
                                          "Delete Your Photo",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                    mini: true,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              margin: const EdgeInsets.all(13),
              child: Form(
                key: _updatecontactkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.name,
                      controller: _firstnamecontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          _firstname = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintText: "First Name",
                        hintStyle: TextStyle(
                            color: (AppTheme.isDark)
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Last Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.name,
                      controller: _lastnamecontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          _lastname = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                            color: (AppTheme.isDark)
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.number,
                      controller: _phonenumbercontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your number first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          _phonenumber = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            color: (AppTheme.isDark)
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailcontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your email first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                            color: (AppTheme.isDark)
                                ? Colors.white
                                : Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

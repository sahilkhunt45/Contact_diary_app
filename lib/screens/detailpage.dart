import 'package:contacs/contact_model.dart';
import 'package:contacs/global.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../app_theme.dart';

class Detail_Page extends StatefulWidget {
  const Detail_Page({Key? key}) : super(key: key);

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? first_name;
  String? last_name;
  String? phone_number;
  String? email;

  final GlobalKey<FormState> contactFormkey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: (AppTheme.isDark) ? Colors.white : Colors.black,
        ),
        title: Text(
          "Add",
          style: TextStyle(
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (contactFormkey.currentState!.validate()) {
                contactFormkey.currentState!.save();
              }
              Contact c1 = Contact(
                phone_number: phone_number,
                image: image,
                first_name: first_name,
                last_name: last_name,
                email: email,
              );
              setState(() {
                Global.allcontacts.add(c1);
              });
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('homepage', (route) => false);
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
                    backgroundImage: (image != null) ? FileImage(image!) : null,
                    radius: 50,
                    backgroundColor: Colors.grey.shade400,
                    child: (image != null)
                        ? const Text("")
                        : const Text(
                            "ADD",
                            style: TextStyle(
                              color: Colors.black,
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
                          title: const Text("Add Photo"),
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
                                        image = File(pickedFile!.path);
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
                                        image = File(pickedFile!.path);
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
                                        image = null;
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
                    child: Icon(
                      Icons.add,
                      color: (AppTheme.isDark) ? Colors.black : Colors.white,
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
                key: contactFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.name,
                      controller: firstnameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          first_name = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintStyle: TextStyle(
                          color: (AppTheme.isDark) ? Colors.grey : Colors.black,
                        ),
                        hintText: "First Name",
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
                        color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.name,
                      controller: lastnameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          last_name = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintStyle: TextStyle(
                          color: (AppTheme.isDark) ? Colors.grey : Colors.black,
                        ),
                        hintText: "Last Name",
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
                        color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.number,
                      controller: phonenumberController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your number first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phone_number = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintStyle: TextStyle(
                          color: (AppTheme.isDark) ? Colors.grey : Colors.black,
                        ),
                        hintText: "Phone Number",
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
                        color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your email first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            (AppTheme.isDark) ? Colors.white12 : Colors.white,
                        hintStyle: TextStyle(
                          color: (AppTheme.isDark) ? Colors.grey : Colors.black,
                        ),
                        hintText: "Email Address",
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

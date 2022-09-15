import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'app_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'global.dart';

class All_Contacts extends StatefulWidget {
  const All_Contacts({Key? key}) : super(key: key);

  @override
  State<All_Contacts> createState() => _All_ContactsState();
}

class _All_ContactsState extends State<All_Contacts> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('homepage');
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: (AppTheme.isDark) ? Colors.white : Colors.black,
        ),
        backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
        title: Text(
          "Contacts",
          style: TextStyle(
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_outlined),
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(flex: 3),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      (res.image != null) ? FileImage(res.image as File) : null,
                ),
                const Spacer(flex: 1),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: (AppTheme.isDark) ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    Global.allcontacts.remove(res);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('homepage', (route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: (AppTheme.isDark) ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('edit_contacts', arguments: res);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "${res.first_name}" "${res.last_name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: (AppTheme.isDark) ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                Text(
                  "+91 ${res.phone_number}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: (AppTheme.isDark) ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
                color: (AppTheme.isDark) ? Colors.white : Colors.black,
                indent: 20,
                endIndent: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    Uri url = Uri.parse("tel:+91${res.phone_number}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("can't be luanched..."),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.call),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.amber,
                  onPressed: () async {
                    Uri url = Uri.parse("sms:+91 ${res.phone_number}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("can't be luanched..."),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.message),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.lightBlue,
                  onPressed: () async {
                    Uri url = Uri.parse(
                        "mailto:${res.email}?subject=Demo&body=Hello");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("can't be luanched..."),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.email),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.deepOrange,
                  onPressed: () async {
                    await Share.share("+91 ${res.phone_number}");
                  },
                  child: const Icon(Icons.share),
                ),
              ],
            ),
            Divider(
                color: (AppTheme.isDark) ? Colors.white : Colors.black,
                indent: 20,
                endIndent: 20),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

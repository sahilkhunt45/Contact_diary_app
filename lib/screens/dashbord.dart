import 'package:flutter/material.dart';
import 'package:contacs/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]).then((_) => runApp(
        const Homepage(),
      ));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: (AppTheme.isDark) ? Colors.black : Colors.white,
        title: Text(
          "Contacts",
          style: TextStyle(
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                AppTheme.isDark = !AppTheme.isDark;
              });
            },
            icon: const Icon(Icons.circle),
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_outlined),
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: (AppTheme.isDark) ? Colors.black : Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('detail_page');
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: (Global.allcontacts.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_box_outlined,
                    color: (AppTheme.isDark) ? Colors.white : Colors.black,
                    size: 130,
                  ),
                  const Text(
                    "You have no contacts yet",
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: Global.allcontacts.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('all_contacts',
                          arguments: Global.allcontacts[i]);
                    },
                    leading: CircleAvatar(
                      backgroundImage: (Global.allcontacts[i].image != null)
                          ? FileImage(Global.allcontacts[i].image as File)
                          : null,
                    ),
                    title: Text(
                      "${Global.allcontacts[i].first_name}  ${Global.allcontacts[i].last_name}",
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    subtitle: Text(
                      "+91 ${Global.allcontacts[i].phone_number}",
                      style: TextStyle(
                          color:
                              (AppTheme.isDark) ? Colors.white : Colors.black),
                    ),
                    trailing: IconButton(
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
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

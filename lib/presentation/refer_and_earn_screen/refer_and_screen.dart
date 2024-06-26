import 'package:contacts_service/contacts_service.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/faq_screen/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferAndEarn extends StatefulWidget {
  ReferAndEarn({super.key});

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  String referalCode = "Here is your referal code join hindgreco";

  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContact();
    });
  }

  ShareFunction() {
    Share.share(referalCode);
  }

  ShareMail() {
    Share.share(referalCode, subject: 'referal code for hindgreco');
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName?.toLowerCase() ?? '';
        return contactName.contains(searchTerm);
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    } else {
      setState(() {
        contactsFiltered = contacts;
      });
    }
  }

  getAllContacts() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      List<Contact> _contacts = await ContactsService.getContacts();
      setState(() {
        contacts = _contacts;
        contactsFiltered = _contacts;
      });
    } else {
      // Handle the case when permission is not granted
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Permissions error"),
          content: Text(
              "Please enable contacts access permission in system settings"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: Get.height * 0.5,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/refer.png",
                    height: Get.height * 0.38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Invite",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconColumn(Icons.copy_rounded, 'Copy', () {
                          Clipboard.setData(
                                  ClipboardData(text: "Your referral code"))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Referral code copied to clipboard")));
                          });
                        }),
                        SizedBox(width: 40),
                        _buildIconColumn(Icons.share, 'Share', () {
                          // Implement share functionality
                          ShareFunction();
                        }),
                        SizedBox(width: 40),
                        _buildIconColumn(Icons.mail_outline_rounded, 'Mail',
                            () {
                          // Implement mail functionality
                          ShareMail();
                        }),
                        SizedBox(width: 40),
                        _buildIconColumn(Icons.question_answer_outlined, 'FAQ',
                            () {
                          // Implement more options functionality
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FAQ(),
                              ));
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildBackButton(),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.5,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              labelText: 'Search',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Contact contact = isSearching
                                ? contactsFiltered[index]
                                : contacts[index];
                            String? phone = contact.phones?.isNotEmpty == true
                                ? contact.phones!.first.value
                                : 'No phone number';

                            return Row(
                              children: [
                                Container(
                                  width: Get.width * 0.75,
                                  child: ListTile(
                                    title:
                                        Text(contact.displayName ?? 'No name'),
                                    subtitle: Text(phone!),
                                    leading: (contact.avatar != null &&
                                            contact.avatar!.isNotEmpty)
                                        ? CircleAvatar(
                                            backgroundImage:
                                                MemoryImage(contact.avatar!),
                                          )
                                        : CircleAvatar(
                                            child: Text(contact.initials()),
                                          ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // SMS functionality for invite
                                    final Uri url = Uri(
                                      scheme: 'sms',
                                      path: phone,
                                      queryParameters: <String, String>{
                                        'body': 'Your referral code',
                                      },
                                    );
                                    // if (await canLaunchUrl(url)) {
                                    // await launchUrl(url);
                                    // } else {
                                    // print(
                                    // 'show dialog: cannot launch this url');
                                    // }
                                    //For error handling
                                    try {
                                      await launchUrl(url);
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  child: Text('Invite'),
                                ),
                              ],
                            );
                          },
                          childCount: isSearching
                              ? contactsFiltered.length
                              : contacts.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconColumn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 23),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 8),
        child: GestureDetector(
          onTap: onTapArrowleft4,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/images/img_arrowleft.svg'),
          ),
        ),
      ),
    );
  }

  void onTapArrowleft4() {
    Get.back();
  }
}

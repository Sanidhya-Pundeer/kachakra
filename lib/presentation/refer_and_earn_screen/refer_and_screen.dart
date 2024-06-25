import 'package:contacts_service/contacts_service.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/cupertino.dart';
// import 'package:courier_delivery/presentation/refer_and_earn_screen/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ReferAndEarn extends StatefulWidget {
  ReferAndEarn({super.key});

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContact();
    });
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 227, 219, 219),
        body: Stack(
          children: [
            Container(
              height: Get.height * 0.5,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/refer.png",
                    height: Get.height * 0.38,
                    // fit: BoxFit.fitHeight,
                    // width: double.infinity,
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        SizedBox(width: 9),
                        Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.copy_rounded,
                                size: 23,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Copy')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.share,
                                size: 23,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Share')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.mail_outline_rounded,
                                size: 23,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Mail')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.more_horiz_rounded,
                                size: 23,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('More')
                            ],
                          ),
                        ),
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
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  prefixIcon: Icon(Icons.search_outlined,
                                      color: Theme.of(context).primaryColor)),
                            )),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Contact contact = isSearching == true
                                ? contactsFiltered[index]
                                : contacts[index];
                            String? phone = contact.phones?.isNotEmpty == true
                                ? contact.phones!.first.value
                                : 'No phone number';

                            return ListTile(
                              title: Text(contact.displayName ?? 'No name'),
                              subtitle: Text(phone ?? 'No phone number'),
                              leading: (contact.avatar != null &&
                                      contact.avatar!.length > 0)
                                  ? CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(contact.avatar!),
                                    )
                                  : CircleAvatar(
                                      child: Text(contact.initials()),
                                    ),
                            );
                          },
                          childCount: isSearching == true
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

  onTapArrowleft4() {
    Get.back();
  }
}

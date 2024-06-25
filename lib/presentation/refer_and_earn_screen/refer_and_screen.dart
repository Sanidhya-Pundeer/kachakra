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

  @override
  initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 227, 219, 219),
        body: Stack(
          children: [
            Container(
              height: Get.height * 0.5,
              child: Image.asset(
                "assets/images/refer.jpg",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            buildBackButton(),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 1.0,
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
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Invite",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 9),
                          Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 30,
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
                                  size: 30,
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
                                  size: 30,
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
                                  size: 30,
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
                      SizedBox(
                        height: 40,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = contacts[index];
                          String? phone = contact.phones?.isNotEmpty == true
                              ? contact.phones!.first.value
                              : 'No phone number';

                          return ListTile(
                            title: Text(contact.displayName ?? 'No name'),
                            subtitle: Text(phone ?? 'No phone number'),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            // MyDraggableSheet(
            //     child: Padding(
            //       padding: EdgeInsets.all(10.0),
            //       child: Column(
            //         children: [
            //           Align(
            //             alignment: Alignment.topLeft,
            //             child: Text(
            //               "Invite",
            //               style: TextStyle(fontSize: 25),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 15,
            //           ),
            //           Row(
            //             children: [
            //               SizedBox(width: 9),
            //               Container(
            //                 child: Column(
            //                   children: [
            //                     Icon(
            //                       Icons.copy_rounded,
            //                       size: 30,
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text('Copy')
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 40,
            //               ),
            //               Container(
            //                 child: Column(
            //                   children: [
            //                     Icon(
            //                       Icons.share,
            //                       size: 30,
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text('Share')
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 40,
            //               ),
            //               Container(
            //                 child: Column(
            //                   children: [
            //                     Icon(
            //                       Icons.mail_outline_rounded,
            //                       size: 30,
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text('Mail')
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 40,
            //               ),
            //               Container(
            //                 child: Column(
            //                   children: [
            //                     Icon(
            //                       Icons.more_horiz_rounded,
            //                       size: 30,
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Text('More')
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 40,
            //           ),
            //           ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: contacts.length,
            //               itemBuilder: (context, index) {
            //                 Contact contact = contacts[index];
            //                 String? phone = contact.phones?.isNotEmpty == true
            //                     ? contact.phones!.first.value
            //                     : 'No phone number';
            //
            //                 print("Contacts: ${contacts.length}");
            //                 return ListTile(
            //                   title: Text(contact.displayName ?? 'No name'),
            //                   subtitle: Text(phone ?? 'No phone number'),
            //                 );
            //               }),
            //           // ShowContacts(),
            //         ],
            //       ),
            //     )),
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


// class MyDraggableSheet extends StatefulWidget {
//   final Widget child;
//   MyDraggableSheet({super.key, required this.child});
//
//   @override
//   State<MyDraggableSheet> createState() => _MyDraggableSheetState();
// }
//
// class _MyDraggableSheetState extends State<MyDraggableSheet> {
//   final sheet = GlobalKey();
//   final controller = DraggableScrollableController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(onChanged);
//     // getAllContacts();
//   }
//
//   void onChanged() {
//     final currentSize = controller.size;
//     if (currentSize <= 0.05) collapse();
//   }
//
//   void collapse() => animateSheet(getSheet.snapSizes!.first);
//
//   void anchor() => animateSheet(getSheet.snapSizes!.last);
//
//   void expand() => animateSheet(getSheet.maxChildSize);
//
//   // void hide() => animateSheet(getSheet.minChildSize);
//
//   void animateSheet(double size) {
//     controller.animateTo(
//       size,
//       duration: const Duration(milliseconds: 50),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   DraggableScrollableSheet get getSheet =>
//       (sheet.currentWidget as DraggableScrollableSheet);
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return DraggableScrollableSheet(
//         key: sheet,
//         initialChildSize: 0.6,
//         maxChildSize: 0.95,
//         minChildSize: 0,
//         expand: true,
//         snap: true,
//         snapSizes: [
//           // 60 / constraints.maxHeight,
//           0.5,
//         ],
//         controller: controller,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return DecoratedBox(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 10,
//                   spreadRadius: 1,
//                   offset: Offset(0, 1),
//                 ),nnected. Trying to conn
//               ],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(22),
//                 topRight: Radius.circular(22),
//               ),
//             ),
//             child: CustomScrollView(
//               controller: scrollController,
//               slivers: [
//                 topButtonIndicator(),
//                 SliverToBoxAdapter(
//                   child: widget.child,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
//
//   SliverToBoxAdapter topButtonIndicator() {
//     return SliverToBoxAdapter(
//       child: Container(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                     child: Center(
//                         child: Wrap(children: <Widget>[
//                           Container(
//                               width: 100,
//                               margin: const EdgeInsets.only(top: 10, bottom: 10),
//                               height: 5,
//                               decoration: const BoxDecoration(
//                                 color: Colors.black45,
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                               )),
//                         ]))),
//               ])),
//     );
//   }
// }

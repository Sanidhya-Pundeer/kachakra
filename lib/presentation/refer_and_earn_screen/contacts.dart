// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:contacts_service/contacts_service.dart';

// class ShowContacts extends StatefulWidget {
//   @override
//   State<ShowContacts> createState() => _ShowContactsState();
// }

// class _ShowContactsState extends State<ShowContacts> {
//   List<Contact> contacts = [];

//   @override
//   void initState() {
//     getAllContacts();
//     super.initState();
//   }

//   getAllContacts() async {
//     List<Contact> _contacts =
//         await ContactsService.getContacts(withThumbnails: false);
//     setState(() {
//       contacts = _contacts;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: contacts.length,
//                 itemBuilder: (context, index) {
//                   Contact contact = contacts[index];
//                   return ListTile(
//                     title: Text(contact.displayName!),
//                     subtitle: Text(contact.phones!.elementAt(0).value!),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

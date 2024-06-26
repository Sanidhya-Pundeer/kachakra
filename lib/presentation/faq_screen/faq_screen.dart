import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/faq_screen/models/faq_data.dart';
import 'package:courier_delivery/presentation/faq_screen/models/faq_model.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final List<FaqModel> faqList = FaqData.getFaqData();
  List<FaqModel> filteredFaqList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFaqList = faqList;
    searchController.addListener(() {
      filterFaqList();
    });
  }

  void filterFaqList() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFaqList = faqList.where((faq) {
        return faq.question!.toLowerCase().contains(query) ||
            faq.answer!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: Column(
        children: [
          Text('Enter your question'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: Get.width * 0.75,
                height: 45,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30.0)), // Rounded border
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30.0)), // Rounded border
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30.0)), // Rounded border
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFaqList.length,
              itemBuilder: (context, index) {
                final faq = filteredFaqList[index];
                return ExpansionTile(
                  title: Text(faq.question!),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faq.answer!),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

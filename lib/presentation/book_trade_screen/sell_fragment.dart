import 'dart:convert';
import 'package:courier_delivery/data/books_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/color_constant.dart';

class Book {
  final String title;
  final String author;
  final String publication;
  final int year;
  final List<String> tags;
  final String image;
  final double price;

  Book({
    required this.title,
    required this.author,
    required this.publication,
    required this.year,
    required this.tags,
    required this.image,
    required this.price,
  });

  factory Book.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Book(
      title: json['title'],
      author: json['author'],
      publication: json['publication'],
      year: json['year'],
      tags: List<String>.from(json['tags']),
      image: json['image'],
      price: json['price'],
    );
  }

  String toJson() {
    return jsonEncode({
      'title': title,
      'author': author,
      'publication': publication,
      'year': year,
      'tags': tags,
      'image': image,
      'price': price,
    });
  }
}

class SellFragment extends StatefulWidget {
  @override
  _SellFragmentState createState() => _SellFragmentState();
}

class _SellFragmentState extends State<SellFragment> {
  List<Book> books = [];

  // Method to get book title suggestions based on the input pattern
  List<String> _getBookTitleSuggestions(String pattern) {
    // Filter the book titles based on the pattern
    return BookData.academicBookTitles.where((title) => title.toLowerCase().contains(pattern.toLowerCase())).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  _loadBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? booksJson = prefs.getStringList('books');
    if (booksJson != null) {
      setState(() {
        books = booksJson.map((bookJson) => Book.fromJson(bookJson)).toList();
      });
    }
  }

  _saveBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> booksJson = books.map((book) => book.toJson()).toList();
    prefs.setStringList('books', booksJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          automaticallyImplyLeading: false,
          title: Text("Want to clear your bookshelf ? Sell Now!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),),
          backgroundColor: ColorConstant.highlighter,
        ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: book.image.isNotEmpty ? Image.network(book.image, fit: BoxFit.contain) : Placeholder(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text('Author: ${book.author}'),
                          Text('Publication: ${book.publication}'),
                          Text('Year: ${book.year.toString()}'),
                          Text('Tags: ${book.tags.join(", ")}'),
                          Text('Price: ${book.price.toString()}'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showEditBookDialog(context, index);
                        },
                        child: Text('Edit',
                        style: TextStyle(
                          color: ColorConstant.highlighter,
                        ),),
                      ),
                      TextButton(
                        onPressed: () {
                          _removeBook(index);
                        },
                        child: Text('Remove',
                          style: TextStyle(
                            color: ColorConstant.highlighter,
                          ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showAddBookDialog(context);
        },
        child: Icon(Icons.add,
              color: ColorConstant.highlighter,),
      ),
    );
  }

  Future<void> _showAddBookDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController authorController = TextEditingController();
    TextEditingController publicationController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController tagsController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          title: Text('Add Book'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  suggestionsCallback: (pattern) {
                    // Implement logic to filter book titles based on the pattern
                    return _getBookTitleSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    titleController.text = suggestion;
                  },
                ),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: publicationController,
                  decoration: InputDecoration(labelText: 'Publication'),
                ),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: tagsController,
                  decoration: InputDecoration(labelText: 'Tags'),
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books.add(
                    Book(
                      title: titleController.text,
                      author: authorController.text,
                      publication: publicationController.text,
                      year: int.parse(yearController.text),
                      tags: tagsController.text.split(',').map((e) => e.trim()).toList(),
                      image: imageController.text,
                      price: double.parse(priceController.text),
                    ),
                  );
                });
                _saveBooks();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _showEditBookDialog(BuildContext context, int index) async {
    Book book = books[index];
    TextEditingController titleController = TextEditingController(text: book.title);
    TextEditingController authorController = TextEditingController(text: book.author);
    TextEditingController publicationController = TextEditingController(text: book.publication);
    TextEditingController yearController = TextEditingController(text: book.year.toString());
    TextEditingController tagsController = TextEditingController(text: book.tags.join(", "));
    TextEditingController imageController = TextEditingController(text: book.image);
    TextEditingController priceController = TextEditingController(text: book.price.toString());

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Edit Book'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: publicationController,
                  decoration: InputDecoration(labelText: 'Publication'),
                ),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: tagsController,
                  decoration: InputDecoration(labelText: 'Tags'),
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  books[index] = Book(
                    title: titleController.text,
                    author: authorController.text,
                    publication: publicationController.text,
                    year: int.parse(yearController.text),
                    tags: tagsController.text.split(',').map((e) => e.trim()).toList(),
                    image: imageController.text,
                    price: double.parse(priceController.text),
                  );
                });
                _saveBooks();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  _removeBook(int index) {
    setState(() {
      books.removeAt(index);
    });
    _saveBooks();
  }
}

void main() {
  runApp(MaterialApp(
    home: SellFragment(),
  ));
}

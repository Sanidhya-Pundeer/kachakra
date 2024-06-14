import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_export.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publication': publication,
      'year': year,
      'tags': tags,
      'image': image,
      'price': price,
    };
  }
}

class BuyFragment extends StatefulWidget {
  @override
  _BuyFragmentState createState() => _BuyFragmentState();
}

class _BuyFragmentState extends State<BuyFragment> {
  List<Book> books = [];
  List<Book> filteredBooks = [];
  List<int> selectedYears = [];
  List<String> selectedPublishers = [];
  List<String> selectedTags = [];
  bool sortByPriceAscending = true;

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
        filteredBooks = List.from(books);
      });
    }
  }

  _saveBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> booksJson = books.map((book) => jsonEncode(book.toJson())).toList();
    prefs.setStringList('books', booksJson);
  }

  void _filterBooks(String searchText) {
    setState(() {
      filteredBooks = books.where((book) =>
          book.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    });
  }

  void _sortBooksByPrice() {
    setState(() {
      sortByPriceAscending ? filteredBooks.sort((a, b) => a.price.compareTo(b.price)) :
      filteredBooks.sort((a, b) => b.price.compareTo(a.price));
      sortByPriceAscending = !sortByPriceAscending;
    });
  }

  void _applyFilters() {
    setState(() {
      filteredBooks = books.where((book) =>
      (selectedYears.isEmpty || selectedYears.contains(book.year)) &&
          (selectedPublishers.isEmpty || selectedPublishers.contains(book.publication)) &&
          (selectedTags.isEmpty || book.tags.any((tag) => selectedTags.contains(tag)))
      ).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      selectedYears.clear();
      selectedPublishers.clear();
      selectedTags.clear();
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.search, color: Colors.white,),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                onChanged: _filterBooks,
                decoration: InputDecoration(
                  hintText: 'Search for books...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: ColorConstant.highlighter,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Card(
                  surfaceTintColor: Colors.white,
                  elevation: 6,
                  margin: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: book.image.isNotEmpty
                              ? Image.network(book.image, fit: BoxFit.cover)
                              : Placeholder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Author: ${book.author}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(13.0)),
                          color: ColorConstant.primaryAqua,
                        ),// Set the background color
                        child: TextButton(
                          onPressed: () {
                            // Add your navigation logic here
                            Get.toNamed(
                              AppRoutes.paymentMethodScreen,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0), // Add some vertical padding
                            child: Text(
                              'Buy for ₹ ${book.price.toString()}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _sortBooksByPrice,
                  child: Text(
                    'Sort by Price',
                    style: TextStyle(color: ColorConstant.highlighter),
                  ),
                ),
                Container(
                  height: 35,
                  child: VerticalDivider(
                    color: ColorConstant.highlighter,
                    thickness: 1.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                  child: Text(
                    '       Filter      ',
                    style: TextStyle(color: ColorConstant.highlighter),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Filters',
          style: TextStyle(color: ColorConstant.highlighter),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Years:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _buildYearFilterChips(),
            ),
            SizedBox(height: 16),
            Text(
              'Publishers:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _buildPublisherFilterChips(),
            ),
            SizedBox(height: 16),
            Text(
              'Tags:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _buildTagFilterChips(),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _applyFilters();
              Navigator.pop(context);
            },
            child: Text('Apply', style: TextStyle(color: ColorConstant.primaryAqua),),
          ),
          ElevatedButton(
            onPressed: () {
              _clearFilters();
              Navigator.pop(context);
            },
            child: Text(
              'Clear',
              style: TextStyle(color: ColorConstant.highlighter),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildYearFilterChips() {
    Set<int> years = Set<int>.from(books.map((book) => book.year));
    return years.map((year) {
      return FilterChipWithState(
        label: year.toString(),
        selected: selectedYears.contains(year),
        onChanged: (selected) {
          setState(() {
            if (selected) {
              selectedYears.add(year);
            } else {
              selectedYears.remove(year);
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildPublisherFilterChips() {
    Set<String> publishers = Set<String>.from(books.map((book) => book.publication));
    return publishers.map((publisher) {
      return FilterChipWithState(
        label: publisher,
        selected: selectedPublishers.contains(publisher),
        onChanged: (selected) {
          setState(() {
            if (selected) {
              selectedPublishers.add(publisher);
            } else {
              selectedPublishers.remove(publisher);
            }
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildTagFilterChips() {
    Set<String> allTags = books.expand((book) => book.tags).toSet();
    return allTags.map((tag) {
      return FilterChipWithState(
        label: tag,
        selected: selectedTags.contains(tag),
        onChanged: (selected) {
          setState(() {
            if (selected) {
              selectedTags.add(tag);
            } else {
              selectedTags.remove(tag);
            }
          });
        },
      );
    }).toList();
  }
}

class FilterChipWithState extends StatefulWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onChanged;

  const FilterChipWithState({
    required this.label,
    required this.selected,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _FilterChipWithStateState createState() => _FilterChipWithStateState();
}

class _FilterChipWithStateState extends State<FilterChipWithState> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: _selected,
      onSelected: (selected) {
        setState(() {
          _selected = selected;
          widget.onChanged(selected);
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: _selected ? ColorConstant.highlighter : Colors.grey,
          width: 1.0,
        ),
      ),
      selectedColor: ColorConstant.highlighter,
      labelStyle: TextStyle(color: _selected ? Colors.white : null),
      backgroundColor: _selected ? ColorConstant.highlighter.withOpacity(0.5) : null,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BuyFragment(),
  ));
}

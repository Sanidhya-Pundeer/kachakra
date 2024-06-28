import 'package:courier_delivery/presentation/marketplace_screen/model/bidData.dart';
import 'package:courier_delivery/presentation/marketplace_screen/model/bid_model.dart';
import 'package:flutter/material.dart';

class BidScreen extends StatefulWidget {
  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  late List<BidModel> bidData;
  late List<BidModel> filteredBidData;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bidData = BidData.getBidData();
    filteredBidData = bidData;
  }

  void filterBids(String query) {
    List<BidModel> filteredList = bidData.where((bid) {
      return bid.material!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredBidData = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bid List'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by material',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                filterBids(value);
              },
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: filteredBidData.length,
        itemBuilder: (context, index) {
          final bid = filteredBidData[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => BidDetailDialog(bid: bid),
              );
            },
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: \$${bid.current_price}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text('Duration: ${bid.duration}'),
                    SizedBox(height: 8.0),
                    Text('Material: ${bid.material}'),
                    SizedBox(height: 8.0),
                    Text('Quantity: ${bid.quantity}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BidDetailDialog extends StatelessWidget {
  final BidModel bid;

  BidDetailDialog({required this.bid});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sale ID: ${bid.sale_id}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Vendor ID: ${bid.vendor_id}'),
            SizedBox(height: 8.0),
            Text('Price: \$${bid.current_price}'),
            SizedBox(height: 8.0),
            Text('Minimum Price: \$${bid.min_price}'),
            SizedBox(height: 8.0),
            Text('Duration: ${bid.duration}'),
            SizedBox(height: 8.0),
            Text('Remaining Time: ${bid.remaining_time}'),
            SizedBox(height: 8.0),
            Text('Location: ${bid.owner_location}'),
            SizedBox(height: 8.0),
            Text('Description: ${bid.desc}'),
            SizedBox(height: 8.0),
            Text('Date: ${bid.date}'),
            SizedBox(height: 8.0),
            Text('Other Details: ${bid.other_detials}'),
            SizedBox(height: 8.0),
            Text('Condition: ${bid.condition}'),
            SizedBox(height: 8.0),
            Text('Status: ${bid.status}'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add raise bid functionality here
                  },
                  child: Text('Raise Bid'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Add buy/reserve bid functionality here
                  },
                  child: Text('Buy/Reserve'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

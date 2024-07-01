import 'package:flutter/material.dart';
import 'package:courier_delivery/presentation/marketplace_screen/model/bid_model.dart';

class MarketPlaceItemScreen extends StatefulWidget {
  final BidModel bid;

  MarketPlaceItemScreen({required this.bid});

  @override
  State<MarketPlaceItemScreen> createState() => _MarketPlaceItemScreenState();
}

class _MarketPlaceItemScreenState extends State<MarketPlaceItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sale ID: ${widget.bid.sale_id}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('Vendor ID: ${widget.bid.vendor_id}'),
            SizedBox(height: 8.0),
            Text('Price: \$${widget.bid.current_price}'),
            SizedBox(height: 8.0),
            Text('Duration: ${widget.bid.duration}'),
            SizedBox(height: 8.0),
            Text('Remaining Time: ${widget.bid.remaining_time}'),
            SizedBox(height: 8.0),
            Text('Shipping Time: ${widget.bid.shipping_time}'),
            SizedBox(height: 8.0),
            Text('Location: ${widget.bid.owner_location}'),
            SizedBox(height: 8.0),
            Text('Description: ${widget.bid.desc}'),
            SizedBox(height: 8.0),
            Text('Date: ${widget.bid.date}'),
            SizedBox(height: 8.0),
            Text('Other Details: ${widget.bid.other_detials}'),
            SizedBox(height: 8.0),
            Text('Condition: ${widget.bid.condition}'),
            SizedBox(height: 8.0),
            Text('Status: ${widget.bid.status}'),
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

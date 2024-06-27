import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_data.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_model.dart';
import 'package:flutter/material.dart';

class BinWidget extends StatefulWidget {
  final String capacity;

  const BinWidget({super.key, required this.capacity});

  @override
  _BinWidgetState createState() => _BinWidgetState();
}

class _BinWidgetState extends State<BinWidget> {
  late List<BinModel> binList;

  @override
  void initState() {
    super.initState();
    binList = BinData.getBinData()
        .where((bin) => bin.capacity == widget.capacity)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bins Available (${widget.capacity})",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: binList.length,
            itemBuilder: (context, index) {
              final bin = binList[index];
              return Card(
                child: ExpansionTile(
                  title: Text(bin.capacity!),
                  leading: Image.asset(
                    bin.image!,
                    width: 50,
                    height: 50,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Color: ${bin.color}"),
                          Text("Material: ${bin.material}"),
                          Text("Dimensions: ${bin.dimensions}"),
                          Text("Brand: ${bin.make!}"),
                          Text("Household Size: ${bin.size}"),
                          Text("Use Location: ${bin.location}"),
                          Text("Price: \$${bin.price}"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

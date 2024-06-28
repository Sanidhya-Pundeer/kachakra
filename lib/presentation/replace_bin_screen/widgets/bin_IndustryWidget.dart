import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_IndustryData.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_IndustryModel.dart';
import 'package:flutter/material.dart';

class BinIndustryWidget extends StatefulWidget {
  final String capacity;
  final Function(String) onPriceSelected;

  const BinIndustryWidget({
    super.key,
    required this.capacity,
    required this.onPriceSelected,
  });

  @override
  _BinIndustryWidgetState createState() => _BinIndustryWidgetState();
}

class _BinIndustryWidgetState extends State<BinIndustryWidget> {
  late List<Bin_IndustryModel> binList;

  @override
  void initState() {
    super.initState();
    _updateBinList();
  }

  @override
  void didUpdateWidget(BinIndustryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.capacity != widget.capacity) {
      _updateBinList();
    }
  }

  void _updateBinList() {
    setState(() {
      binList = IndustryData.getBinData()
          .where((bin) => bin.capacity == widget.capacity)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                          Text("Location: ${bin.location}"),
                          Text("Price: Rs. ${bin.price}"),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => widget.onPriceSelected(bin.price!),
                        child: Text("Add")),
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

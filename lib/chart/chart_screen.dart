import 'package:candlesticks/candlesticks.dart';
import 'package:finance/chart/chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    final provider = Provider.of<ChartProvider>(context,listen: false);
    provider.getCandles().then((value) => provider.candles=value!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ChartProvider>(
        builder: (ctx,provider,w) {
            return SafeArea(
              child: Candlesticks(
                candles: provider.candles,
              ),
            );
        }
    );
  }
}

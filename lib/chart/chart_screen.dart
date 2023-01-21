import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:finance/chart/chart_provider.dart';
import 'package:finance/widgets/interval_filter_item.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  void initState() {
    final provider = Provider.of<ChartProvider>(context, listen: false);
    provider.getCandles(interval: provider.getIntervalValue()!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartProvider>(builder: (ctx, provider, w) {
      return Scaffold(
        body: SafeArea(
          child: provider.isDataLoaded?Candlesticks(
            candles: provider.candles,
            showToolbar: true,
            actions: [
              ToolBarAction(
                  width: 50,
                  child:  IntervalFilterItem(
                    title: '1D',
                    isSelected: provider.selectedIntervalFilter==IntervalFilter.day,
                  ),
                  onPressed: () {
                    provider.isDataLoaded = false;
                    provider.selectedIntervalFilter=IntervalFilter.day;
                    provider.getCandles(interval:provider.getIntervalValue()!);
                  }),
              ToolBarAction(
                  width: 50,
                  child:  IntervalFilterItem(
                    title: '1W',
                    isSelected: provider.selectedIntervalFilter==IntervalFilter.week,
                  ),
                  onPressed: () {
                    provider.isDataLoaded = false;
                    provider.selectedIntervalFilter=IntervalFilter.week;
                    provider.getCandles(interval:provider.getIntervalValue()!);
                  }),
              ToolBarAction(
                  width: 50,
                  child:  IntervalFilterItem(
                    title: '1M',
                    isSelected: provider.selectedIntervalFilter==IntervalFilter.month,
                  ),
                  onPressed: () {
                    provider.isDataLoaded = false;
                    provider.selectedIntervalFilter=IntervalFilter.month;
                    provider.getCandles(interval:provider.getIntervalValue()!);
                  }),
            ],
          ): Center(child: Lottie.asset('assets/lottie/chart.json',width: 100)),
        ),
      );
    });
  }
}

enum IntervalFilter { day, week, month }

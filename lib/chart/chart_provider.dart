
import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:finance/chart/chart_screen.dart';
import 'package:flutter/foundation.dart';

class ChartProvider extends ChangeNotifier{

  bool _isDataLoaded = false;


  bool get isDataLoaded => _isDataLoaded;

  set isDataLoaded(bool value) {
    _isDataLoaded = value;
    notifyListeners();
  }

  List<Candle> _candles = [];


  List<Candle> get candles => _candles;

  set candles(List<Candle> value) {
    _candles = value;
    notifyListeners();
  }

  IntervalFilter _selectedIntervalFilter = IntervalFilter.day;


  IntervalFilter get selectedIntervalFilter => _selectedIntervalFilter;

  set selectedIntervalFilter(IntervalFilter value) {
    _selectedIntervalFilter = value;
    notifyListeners();
  }

  String? getIntervalValue(){
    if(selectedIntervalFilter==IntervalFilter.day) return'1d';
    if(selectedIntervalFilter==IntervalFilter.week) return'1wk';
    if(selectedIntervalFilter==IntervalFilter.month) return'1mo';
  }

  Future<dynamic> getFinanceData({required String interval}) async {
   try{
      var response = await Dio().get('https://query1.finance.yahoo.com/v7/finance/download/SPUS?period1=1633381200&period2=1664917199&interval=$interval&events=history&crumb=5YTX%2FgVGBmg');
      isDataLoaded = true;
      return response.data;

   }catch(e){
     if (kDebugMode) {
       print(e.toString());
     }

   }
   return null;

  }

 Future<List<List>> mapStringDataToList({required String interval})async{
   var financeData = await getFinanceData(interval: interval);
    List<List<dynamic>> dataList =
    const CsvToListConverter().convert(financeData,eol: "\n");
    return dataList;
  }


getCandles({required String interval}) async {
    List<List<dynamic>> dataList = await mapStringDataToList(interval: interval);
    try {
      // the package model parse the number values directly so we have to remove the header row of returned data
      dataList.removeAt(0);
      candles = dataList.map((e) => Candle.fromJson(e))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }


}
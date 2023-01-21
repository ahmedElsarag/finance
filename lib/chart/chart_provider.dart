import 'package:candlesticks/candlesticks.dart';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ChartProvider extends ChangeNotifier{

  List<Candle> _candles = [];


  List<Candle> get candles => _candles;

  set candles(List<Candle> value) {
    _candles = value;
    notifyListeners();
  }

  Future<dynamic> getFinanceData() async {
   try{
      var response = await Dio().get('https://query1.finance.yahoo.com/v7/finance/download/SPUS?period1=1633381200&period2=1664917199&interval=1d&events=history&crumb=5YTX%2FgVGBmg');
      return response.data;
   }catch(e){
     if (kDebugMode) {
       print(e.toString());
     }
   }
   return null;

  }

 Future<List<List>> mapStringDataToList()async{
   var financeData = await getFinanceData();
    List<List<dynamic>> dataList =
    const CsvToListConverter().convert(financeData,eol: "\n");
    return dataList;
  }


  Future<List<Candle>?> getCandles() async {
    List<List<dynamic>> dataList = await mapStringDataToList();
    try {
      // the package model parse the number values directly so we have to remove the header row of returned data
      dataList.removeAt(0);
      return dataList.map((e) => Candle.fromJson(e))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }


}
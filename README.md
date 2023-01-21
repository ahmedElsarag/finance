# yahoo finance 


flutter app show yahoo finance chart on candle stick chart, and authenticated using biometrics

![time_picker_gif](light_time_picker.gif)
![time_picker_gif](dark_time_picker.gif)

## important packages used 

### local_auth:

used to authenticate using biometrics (finger print)

### csv:

used to read data from csv response and map it to List

### candlesticks_plus:

used to draw the data in the form fo candle stick chart

**in this package you must replace the Candle Model fromJson with this code**
because the package depends on data of type String and our data is int, and depends on TimeStampDate

```dart

Candle.fromJson(List<dynamic> json)
: date = DateTime.parse(json[0].toString()),
high = double.parse(json[2].toString()),
low = double.parse(json[3].toString()),
open = double.parse(json[1].toString()),
close = double.parse(json[4].toString()),
volume = double.parse(json[5].toString());

```

## Maintainer

* Ahmed Elsarag
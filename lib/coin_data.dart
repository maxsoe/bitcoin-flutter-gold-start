import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1C613784-530D-4F42-B413-05DE3C07C569';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
//4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    Map<String, double> pairs ={};

    for (String coin in cryptoList) {
      // print(coin);
      // print(selectedCurrency);
      String requestURL = '$coinAPIURL/$coin/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        // print(lastPrice);
        pairs[coin] = lastPrice;

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    //5: Return a Map of the results instead of a single value.
    print('$selectedCurrency $pairs');
    return pairs;
  }
}

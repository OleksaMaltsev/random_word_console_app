// @dart=2.9
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ansicolor/ansicolor.dart';

// enter in console "dart run" to get started

void main(List<String> arguments) async {
  var consoleOn = true;

  // variables store colors for coloring results
  AnsiPen penGreen = new AnsiPen()..green(bold: false);
  AnsiPen penYellow = new AnsiPen()..yellow(bold: false);

  // the application works as long as consoleOn is true
  while (consoleOn) {
    print('To get random words enter "word" or "end" to finish: ');
    var inoutText = stdin.readLineSync();
    if (inoutText == 'word') {
      var url = Uri.https('rand-word-ten.vercel.app', '/word', {'q': '{http}'});

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        var item = jsonResponse[0];
        print('\nResult:');
        print(penGreen('Word:  ${item['word']}'));
        print(penYellow('Definition:  ${item['definition']} \n'));
        // additional parameter from api
        // print('pronunciation: ' + item['pronunciation']);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      continue;
    } else if (inoutText == 'end') {
      // the app finish
      consoleOn = false;
    } else {
      print('Wrong command!');
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:witcher_notes/extenstion.dart';
import 'package:witcher_notes/pages/dialogs/add_notes.dart';
import 'package:witcher_notes/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:witcher_notes/pages/menu.dart';
import 'package:witcher_notes/pages/note_detail_page.dart';
import 'package:witcher_notes/pages/notes_page.dart';
import 'package:witcher_notes/theme.dart';
import 'db/notes_database.dart';
import 'db/subnotes_database.dart';
import 'generated/l10n.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
// if (!Provider.of<stateApp>(context, listen: false).isAlert)

import 'model/note.dart';
import 'model/subnote.dart';
import 'noti.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final stateAppInstance = stateApp();

  // WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  //
  // var devices = ["D9AAAB1DD42A224EF5B6EB9E597E53BD"];
  // WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();

  // RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: devices);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(
     AdaptiveTheme (
       light: kDarkTheme,
        dark: kDarkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (light,dark) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => stateApp()),
            ChangeNotifierProvider.value(value: stateAppInstance),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
    localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,

    initialRoute: '/',
    routes: {
          '/': (context) => Menu(),
         // '/history': (context) => const History(),
    },
  ),
        ),
      ));
}

class stateApp extends ChangeNotifier {

  bool isPlusButton = true;
  // bool isAlertPhone = false;
  // int aiCunter = 0;

  late List<Note>    notes   = [];
  late List<SubNote> subnotes = [];
  bool isLoading = false;

  void changePlusB()
  {
    isPlusButton = !isPlusButton;
    saveToHistory();
    notifyListeners();
  }

  List<Note> getNotesByDir(String dir)
  {
    // notifyListeners();
    return notes.where((element) => element.directory == dir).toList();
  }

  Future<void> refreshNotes() async {
    isLoading = true;
    notifyListeners();

    notes = await NotesDatabase.instance.readAllNotes();
    subnotes = await SubNotesDatabase.instance.readAllNotes();

    isLoading = false;
    notifyListeners();
  }

  void clearAll()
  {

    notifyListeners();
  }

  void saveToHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');

    try {
      if (!await historyDirectory.exists()) {
        await historyDirectory.create(recursive: true);
      }

      // final fileList = historyDirectory.listSync();
      // final fileNumber = fileList.length + 1;
      final file = File('${historyDirectory.path}/settings.txt');

      final data = {
        'isPlusButton': isPlusButton,
      };

      await file.writeAsString(jsonEncode(data));
      print('Data successfully saved to file: ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void loadFromHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');
    final file = File('${historyDirectory.path}/settings.txt');

    try {
      if (await file.exists()) {
        final data = await file.readAsString();
        final parsedData = jsonDecode(data) as Map<String, dynamic>;
        isPlusButton = parsedData['isPlusButton'] as bool;
        print('Data successfully loaded from file: ${file.path}');
      } else {
        print('File not found: ${file.path}');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }
  /*
  void saveToHistory() async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');

    try {
      if (!await historyDirectory.exists()) {
        await historyDirectory.create(recursive: true);
      }

      final fileList = historyDirectory.listSync();
      final fileNumber = fileList.length + 1;
      final file = File('${historyDirectory.path}/bill_data$fileNumber.txt');

      final data = {
        'users_list': users_list,
        'food': food,
        'cost': cost,
        'state': state,
        'isFirst': isFirst,
        'choosenUser': choosenUser,
        'billText': billText,
        'currency': currency,
        'usetip': usetip,
      };

      await file.writeAsString(jsonEncode(data));
      print('Data successfully saved to file: ${file.path}');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void loadFromHistory(int fileNumber) async {
    final directory = await getApplicationDocumentsDirectory();
    final historyDirectory = Directory('${directory.path}/history');
    final file = File('${historyDirectory.path}/bill_data$fileNumber.txt');

    try {
      if (await file.exists()) {
        final data = await file.readAsString();
        final parsedData = jsonDecode(data) as Map<String, dynamic>;

        users_list = List<String>.from(parsedData['users_list']);
        food = List<String>.from(parsedData['food']);
        cost = List<int>.from(parsedData['cost']);
        state = List<List<bool>>.from(parsedData['state']);
        isFirst = parsedData['isFirst'] as bool;
        choosenUser = parsedData['choosenUser'] as int;
        billText = parsedData['billText'] as String;
        currency = parsedData['currency'] as String;
        usetip = parsedData['usetip'] as String;

        print('Data successfully loaded from file: ${file.path}');
      } else {
        print('File not found: ${file.path}');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  void loadFromHistoryData(String data) {
    isLoadingData = true;
    final parsedData = jsonDecode(data) as Map<String, dynamic>;
    print(parsedData['state'].toString());
    users_list = List<String>.from(parsedData['users_list']);
    food = List<String>.from(parsedData['food']);
    cost = List<int>.from(parsedData['cost']);
    state = List<List<dynamic>>.from(parsedData['state']);
    isFirst = parsedData['isFirst'] as bool;
    choosenUser = 0;
    billText = parsedData['billText'] as String;
    currency = parsedData['currency'] as String;
    usetip = parsedData['usetip'] as String;

    notifyListeners();
  }

  String getTotalCost(String filePath) {
    final file = File(filePath);
    final data = file.readAsStringSync();
    final parsedData = jsonDecode(data) as Map<String, dynamic>;

    final List<int> costList = List<int>.from(parsedData['cost']);
    final int totalCost = costList.fold(0, (sum, cost) => sum + cost);

    return '$totalCost $currency';
  }
*/

}

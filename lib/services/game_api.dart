import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_url.dart';

http.Client client;

//Create Game Record, save game Id
Future submitSupportTicket(message)async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"message": message});
  final response = await http.post(
    "$apiUrl/api/v1/support_messages",
    headers: tokenHeaders,
    body: msg,
  );
  print(response.body);
}
Future createGame(game)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"game_type": game});
  var url = "$apiUrl/api/v1/game_scores";

  final response = await http.post(
    url,
    headers: tokenHeaders,
    body: msg
  );
  if (response != null) {
    print (response.body);
      var parsedJson = json.decode(response.body);
        var res = parsedJson['json'];
        var gameId = res['game_id'];
        prefs.setString("gameId", gameId.toString());
        saveHighScores(res, prefs);
        return "success";

  }else{
    print("game not created");
    return null;
  }
}

saveHighScores(res, prefs){
  var today= res['today'];
  var high = res['high'];
  String highToday = today['score'].toString();
  String allTimeHigh = high['score'].toString();
  print(allTimeHigh);
  print(highToday);
  prefs.setString("allTimeHigh", allTimeHigh);
  prefs.setString("highToday", highToday);
  print("high scores saved");
  // if (high['score'] == null){
  //   prefs.setString("allTimeHigh", "0");
  // }else{
  //   prefs.setString("allTimeHigh", allTimeHigh);
  // }
  // if (today['score']==null){
  //   prefs.setString("highToday", "0");
  // }else{
  //   prefs.setString("highToday", highToday);
  // }
}
// Update Game Score

Future updateScore(game, score)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var gameId = prefs.getString("gameId");
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final msg = jsonEncode({"game_id": gameId, "score": score, "game_type":"conGrid"});
  var url = "$apiUrl/api/v1/game_scores";
  print("updating scores");
  print(msg);
  final response = await http.put(
      url,
      headers: tokenHeaders,
      body: msg
  );
  if (response != null) {
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var res = parsedJson['json'];
      print(response.body);
      saveHighScores(res, prefs);
      return "success";
    } else {
      print("score not updated");
      print(response.statusCode);
      return null;
    }
  }else{
    print("score not working");
    return null;
  }
}

// Read top Scores
Future getTopScores(game)async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "token");
  final tokenHeaders = {'token': token, 'content-type': 'application/json'};
  final response = await http.get(
    "$apiUrl/api/v1/games_scores",
    headers: tokenHeaders,
  );
  if (response != null) {
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var res = parsedJson['json'];
      var today = res['today'];
      var high = res['high'];
      var best = res['best'];
      var scores = [today,high, best];
      return scores;
    } else {
      print("scores not working");
      print(response.body);
      return null;
    }
  }else{
    return null;
  }
  print(response.body);
}








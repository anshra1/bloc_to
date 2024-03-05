import 'dart:convert';
import 'dart:io';
import 'package:bloc_learning/example2/bloc/person.dart';


Future<Iterable<Person>> getPersons(String url) =>
    HttpClient().getUrl(Uri.parse(url)).then((req) => req.close()).then((resp) {
      var s = resp.transform(utf8.decoder).join();
     
      return s;
    }).then((str) {
      var s = json.decode(str) as List<dynamic>;
     
      return s;
    }).then((list) {
      var s = list.map((e) => Person.fromJson(e));
  
      return s;
    });


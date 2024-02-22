import 'dart:convert';
import 'dart:io';
import 'package:bloc_to/example2/person.dart';

Future<Iterable<Person>> getPersons(String url) =>
    HttpClient().getUrl(Uri.parse(url)).then((req) => req.close()).then((resp) {
      var s = resp.transform(utf8.decoder).join();
      print('req $s;');
      return s;
    }).then((str) {
      var s = json.decode(str) as List<dynamic>;
      print('str $s');
      return s;
    }).then((list) {
      var s = list.map((e) => Person.fromJson(e));
      print('list $s');
      return s;
    });


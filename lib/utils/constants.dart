final baseUrl = "https://jsapi.maxbitz.com/api";

String mapToString(Map<String, dynamic> x) {
  String e = '';
  var y = x.entries.map((e) => e.value);
  for (String str in y) {
    e = e + ' $str';
  }
  return e;
}

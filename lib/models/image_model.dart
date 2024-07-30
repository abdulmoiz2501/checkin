//
//
//
// Map<String, String> map = {
//   'brand': brand.text.trim(),
//   'model_name': model.text.trim(),
//   'year': year.value,
//   'color': color.value,
//   'weight': weight.value,
//   'type': type.value,
//   'vehicle_number': vehicleNumber.text.trim(),
// };
// try {
// var uri = Uri.parse('$baseUrl/vehicle/$vehicleId?_method=put');
// print(uri.toString());
// var request = http.MultipartRequest('POST', uri);
// request.headers['Authorization'] =
// 'Bearer ${userController.token.value}';
// request.headers['Accept'] = 'application/json';
// map.forEach((key, value) {
// request.fields[key] = value;
// });
// if (images.value.isNotEmpty) {
// for (var imageFile in images.value) {
// request.files.add(
// await http.MultipartFile.fromPath('images[]', imageFile.path));
// }
// }
// if (documents.value.isNotEmpty) {
// for (var doc in documents.value) {
// request.files.add(
// await http.MultipartFile.fromPath(
// 'docs[]',
// doc.path!,
// ),
// );
// }
// }
// var streamedResponse = await request.send();
// var response = await http.Response.fromStream(streamedResponse);
// print(response.body);
// final Map<String, dynamic> res = json.decode(response.body);
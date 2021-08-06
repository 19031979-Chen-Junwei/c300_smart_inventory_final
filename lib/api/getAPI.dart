import 'package:http/http.dart' as http;//
import 'package:http/http.dart';

class Resource<T> {
  final String url;
  final String tk;
  T Function(Response response) parse;

  Resource({this.url,this.parse, this.tk});
}

class Webservice {

  Future<T> load<T>(Resource<T> resource) async {

      final response = await http.get(Uri.parse(resource.url), headers: {"Authorization": "Bearer " + resource.tk});
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }

}
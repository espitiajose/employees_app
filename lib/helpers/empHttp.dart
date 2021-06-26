import 'dart:convert';
import 'dart:io';
 import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class EmpHttp {

  get headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    developer.log('HEADERS $headers', name: 'SPMHTTP');
    return headers;
  }

  Future<http.Response> get(String url) async {
    developer.log('GET $url');
    return http.get(Uri.parse(url), headers: await this.headers);
  }

  Future<http.Response> getParams(String url, Map<String, dynamic> params) async {
    for (var i = 0; i < params.length; i++) {
      i == 0 ? url+='?':url+='&';
      url+= params.keys.elementAt(i) + '=' + params.values.elementAt(i);
    }
    developer.log('GET $url', name: 'SPMHTTP');
    return http.get(Uri.parse(url), headers: await this.headers);
  }

  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    developer.log('POST $url', name: 'SPMHTTP');
    developer.log('data $data', name: 'SPMHTTP');
    return http.post(Uri.parse(url), body: jsonEncode(data), headers: await this.headers);
  }

  Future<http.Response> put(String url, Map<String, dynamic> data) async {
    developer.log('PUT $url', name: 'SPMHTTP');
    developer.log('data $data', name: 'SPMHTTP');
    return http.put(Uri.parse(url), body: jsonEncode(data), headers: await this.headers);
  }

  Future<http.Response> patch(String url, Map<String, dynamic> data) async {
    developer.log('PATCH $url', name: 'SPMHTTP');
    developer.log('data $data', name: 'SPMHTTP');
    return http.patch(Uri.parse(url), body: jsonEncode(data), headers: await this.headers);
  }

  Future<http.Response> delete(String url) async {
    developer.log('DELETE $url', name: 'SPMHTTP');
    return http.delete(Uri.parse(url), headers: await this.headers);
  }

  Future<String?> submitFile(String fileName, File file) async {
    developer.log('SUBMITFILE messenger-image-$fileName', name: 'SPMHTTP');
    final request = http.MultipartRequest('POST', Uri.parse(''));
    request.files.add(http.MultipartFile('image',file.readAsBytes().asStream(),file.lengthSync(),filename: 'messenger-image-$fileName', contentType: MediaType('image', 'png')));
    final send = await request.send();
    final resp = await http.Response.fromStream(send);
    if(send.statusCode != 200) return null;
    return jsonDecode(resp.body)['link'];
  }
}
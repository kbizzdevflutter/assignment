import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testproject/utils/utilities.dart';
import 'constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Webservice {
  static postRequest({
    uri,
    baseUrl,
    context,
    body,
    header,
    jsonEncoded = true,
    Function(dynamic responseBody)? onSuccess,
    Function(dynamic error)? onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    header ??= {
      'Content-Type': 'application/json',
    };

    if (jsonEncoded) {
      body = jsonEncode(body);
    }

    baseUrl = Global.baseURL;
    var url = Uri.parse(baseUrl + uri);

    http.post(url, body: body, headers: header).then((response) {
      var bodyData = jsonDecode(response.body);
      if (response.statusCode == 401) {
        // Handle unauthorized access here
      } else {
        if (bodyData['status code'] == -1) {
          // Handle negative status code here
        }
        if (onSuccess != null) {
          if (response.statusCode == 200) {
            onSuccess(response.body);
          } else {
            if (onFailure != null) {
              onFailure(bodyData['errors'][0]);
            } else {
              // Handle failure here
            }
          }
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error : catchError $error');
        print(url);
      }
      // Handle error here
      if (onFailure != null) onFailure(error);
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      if (kDebugMode) {
        print('$url');
        print('Error : TimeOut');
      }
      // Handle timeout here
      if (onTimeout != null) onTimeout();
    });
  }

  static getRequest({
    @required uri,
    baseUrl,
    context,
    body,
    header,
    jsonEncoded = true,
    Function(dynamic responseBody)? onSuccess,
    Function(dynamic error)? onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      // Handle no internet connection here
      return;
    }

    header ??= {
      'Content-Type': 'application/json',
    };

    if (jsonEncoded) {
      body = jsonEncode(body);
    }

    baseUrl = Global.baseURL;
    var url = Uri.parse(baseUrl + uri);

    http.get(url, headers: header).then((response) {
      if (response.statusCode == 401) {
        // Handle unauthorized access here
      } else {
        if (response.statusCode == 200) {
          if (onSuccess != null) {
            onSuccess(response.body);
          }
        } else {
          if (onFailure != null) {
            onFailure(response.body);
          } else {
            // Handle failure here
          }
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error : catchError $error');
        print(url);
      }
      // Handle error here
      if (onFailure != null) onFailure(error);
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      if (kDebugMode) {
        print('$url');
        print('Error : TimeOut');
      }
      // Handle timeout here
      if (onTimeout != null) onTimeout();
    });
  }

  static bool trustSelfSigned = true;

  static uploadImage({
    context,
    uri,
    var files,
    var body,
    String? fileType,
    header,
    reqType = "POST",
    Function? onSuccess,
    Function? onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      // Handle no internet connection here
      return;
    }

    var url = Global.baseURL + uri;
    var request = http.MultipartRequest(reqType, Uri.parse(url))
      ..files.add(await http.MultipartFile.fromString(
        'body',
        json.encode(body),
        contentType: MediaType('application', 'json'),
      ));

    if (files.isNotEmpty) {
      files.forEach((val) async {
        var stream = http.ByteStream(Stream.castFrom(val['file'].openRead()));
        var length = await val['file'].length();
        var multipartFile = http.MultipartFile('image', stream, length);
        request.files.add(multipartFile);
      });
    }

    await request.send().then((resStream) async {
      resStream.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((response) {
        var res = jsonDecode(response);
        if (res['status'] == "200 OK" || response != null) {
          onSuccess!(response);
        } else {
          onFailure!(response);
        }
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Error : catchError $error');
        print(url);
      }
      // Handle error here
      onFailure!(error);
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      if (kDebugMode) {
        print(url);
        print('Error : TimeOut');
      }
      // Handle timeout here
      if (onTimeout != null) onTimeout();
    });
  }

  static deleteRequest({
    @required uri,
    context,
    baseUrl,
    body,
    header,
    jsonEncoded = true,
    Function(dynamic responseBody)? onSuccess,
    Function(dynamic error)? onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      // Handle no internet connection here
      return;
    }

    header ??= {
      'Content-Type': 'application/json',
    };

    if (jsonEncoded) {
      body = jsonEncode(body);
    }

    baseUrl = Global.baseURL;
    var url = Uri.parse(baseUrl + uri);

    http.delete(url, headers: header, body: body).then((response) {
      var bodyData = jsonDecode(response.body);
      if (onSuccess != null) {
        if (bodyData['status'] == 200 || bodyData['status'] == 1) {
          onSuccess(response.body);
        } else {
          onFailure!(bodyData);
          Utilities.showError(context, error: bodyData['message'].toString());
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error : catchError $error');
        print(url);
      }
      Utilities.showError(context, error: error.toString());
      onFailure!(error);
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      if (kDebugMode) {
        print('$url');
        print('Error : TimeOut');
      }
      if (onTimeout != null) onTimeout();
    });
  }

  static putRequest({
    @required uri,
    baseUrl,
    context,
    body,
    header,
    jsonEncoded = true,
    Function(dynamic responseBody)? onSuccess,
    Function(dynamic error)? onFailure,
    Function? onTimeout,
    Function? onConnectionFailed,
  }) async {
    bool isConnected = await Utilities.isConnectedNetwork();
    if (!isConnected) {
      return;
    }

    header ??= {
      'Content-Type': 'application/json',
    };

    if (jsonEncoded) {
      body = jsonEncode(body);
    }

    baseUrl = Global.baseURL;
    var url = Uri.parse(baseUrl + uri);

    http.put(url, body: body, headers: header).then((response) {
      var bodyData = jsonDecode(response.body);
      if (bodyData['status'] == -1) {
        // Handle negative status code here
      }
      if (onSuccess != null) {
        if (response.statusCode == 200) {
          onSuccess(response.body);
        } else {
          if (onFailure != null) {
            onFailure(bodyData['errors'][0]);
          } else {
            Utilities.showError(context, error: bodyData['errors'][0]);
          }
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error : catchError $error');
        print(url);
      }
      Utilities.showError(context, error: error.toString());
      onFailure!(error);
    }).timeout(const Duration(seconds: 20), onTimeout: () {
      if (kDebugMode) {
        print('$url');
        print('Error : TimeOut');
      }
      if (onTimeout != null) onTimeout();
    });
  }
}

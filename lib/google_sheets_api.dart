import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "eng-scene-336712",
    "private_key_id": "76e36f918891c7edca06282ed778f880079471a5",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDTN4Uj1mJqFSwh\nds8GY7DlnTHghcS7O8hGeB6uoUFfDwDwUFR7+xEMF+Z1ZLF0lV+v3TWMnEzSFSL3\nMwCd0AcpoZNJhIx+6WpgZMj2n8ZCbmsuwVALJ4vZjesPUUVgGzuA2v75Sq4g3dn4\nTUoWSeoQKxhcjFWY8VP/4jP8dc7Jy801anrp9NgDqfXmHTR06+kvNnIJ5AoNi2vv\nBm5OszgYxwQuIlQC0UEQPxX0znkVJz4YDBPFgnE3QEd1Ki/NqRUmmheaEndhNF8Q\nZZuje2M8I7K8130Hcx36URiUTq26cTmI8GHKZQYnaizO0x8TF7KXNe+jBTrYIaZx\nqLH1igM7AgMBAAECggEAWD31zccfTpqR2Vk9nLnBiexmjhrU2jRbs7UzfFm6afBm\nv/+PjEyUDq1dhuYOjVpqo5qTaK9UGODjvsr8EvJ6S5ZJZomN+Oejnan9m6uctNxU\nwy/YNRDMiJOWBMw7Y6986JSVuajNnsWQ7v+7WByBQUf/4YpvqHoKUfk7JtpBDmTo\nU/NAS7ZJYYv7Illk9LT7cjQKWBW0gITPi//U+YQ0HxI6coTIstSj2sy9JyRtbZTu\nZ+l4jFwwM6Sj1hxGwM4cvoCqZS8vVRKws9mKA2tPYY76/+di5UNM165mS1LXUMyP\n+v1P4MkwL5QIUUxOTbcRnsq9nbNfvYyoYZ0CFrnkgQKBgQDzQ11D/cTAh2Zn89bN\n6/txZTdckKr9DbIl7CrwYkPkInNwrZICL4LV8vwuXzxBJAHQaV1bTJi20O3m33+1\nZXEGAKYLC6sd1EURrtpoR8a9Kl5kT2QPTfG/J77f3nuxt0toACy3AtmaSs7Jlq3G\nYx8Zbxet5j2Og6/RjpgoKrRaCwKBgQDeRp2vzsSFN5956nQb+lqk02N1jUTAWM9c\nqu/UATfPzId4+psPhQQ638Va0Dx+TyWKb0qZAI3oLadRCcDMMJkFkXbAiwXhuEyi\njbERpvqFte7G+g0KMsWHtbSveaM852X9JXTW5C7GBmFYLIvTMIAj92uriWI7aXWg\n18taEq3pkQKBgQDocmNJV9DM49TP2ilUhXyzwzLeaYJp4c9r+zqgjlUvRlgmwEQ3\ngGy1wcSFDw2FdUGigzvoxM1cS1I4fTIMBE22naIMBe9RxoblOb6LTKK0GSsvEMmc\n8i7hKLp0MqThkTMlwpz3l2qUy4zDBg8w9YA/Dm+DBPGnH2A+jtIH9550NwKBgFp/\nj9Yzrkm7AuBFd+6oON2g/36t/M7/mbXWFv1PXaTqVkIIbreb5cP+tcCqxeZ7XQKH\nG20+D4j3hYb2HJxGMRdWSW5NbCChw/nvDKfuP1PPZh93UXXUhB4j+iPzt2WlpR2z\ncWXI085mbJ3UzT04IwQBycG2ltsvrefF1JKgxlQxAoGABRTPcnsDcoOat6hZ80Le\nTKacImGUc8ErYodvQOFre3CT3P+78LtyE3P9VJFh0Gz0lq90uAyGeeUrMmTqg/C8\nL/AtrJ/rS/Gvdf5NShrPve1zz2aSTsVw569FX5rZ4s2DuXyZ+781fvZOdPf/Uiju\ncTLP05S3miIjIV5S3HtixHo=\n-----END PRIVATE KEY-----\n",
    "client_email": "flutter-google-sheets@eng-scene-336712.iam.gserviceaccount.com",
    "client_id": "106623201201098510642",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-google-sheets%40eng-scene-336712.iam.gserviceaccount.com"
  }
  ''';

  // set up and connect to spreadsheet
  static const _spreadsheetId = '1FMMz1TGgjeCwXOE1IsNfIpCpepEDvM_eueXLOrLeS1M';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? worksheet;

  // variables to keep track of notes
  static int numberOfTodos = 0;
  static List<List<dynamic>> currentTodos = [];

  static bool loading = true;

  //  initialize the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    worksheet = ss.worksheetByTitle('todosheet');
  }
}

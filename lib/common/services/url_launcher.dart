import 'package:url_launcher/url_launcher_string.dart';

class URLLauncher {
  static Future<void> sendEmail(
      {required String email, String subject = "", String body = ""}) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await canLaunchUrlString(mail)) {
      await launchUrlString(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  // call to phone number
  static Future<void> callNumber({
    required String number,
  }) async {
    String url = "tel:$number";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw Exception("Unable to open the phone");
    }
  }

  // launch url
  static Future<void> launchURL({
    required String url,
  }) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw Exception("Unable to open the url");
    }
  }
}

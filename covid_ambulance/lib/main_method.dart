import 'dart:io' show Platform;
import 'my_twilio.dart';

// send_sms.dart

Future<void> mainMethod(String number, String msg) async {
  // See http://twil.io/secure for important security information
  var _accountSid = Platform.environment['API_KEY1'];
  var _authToken = Platform.environment['API_KEY2'];

  // Your Account SID and Auth Token from www.twilio.com/console
  // You can skip this block if you store your credentials in environment variables
  _accountSid ??= 'Account_Sid';
  _authToken ??= 'Auth_Token';

  // Create an authenticated client instance for Twilio API
  var client = new MyTwilio(_accountSid, _authToken);

  // Send a text message
  // Returns a Map object (key/value pairs)
  Map message = await client.messages.create({
    'body': msg,
    'from': '+12132677194', // a valid Twilio number
    'to': number //+number // your phone number
  });

  // access individual properties using the square bracket notation
  // for example print(message['sid']);
  print(message);
}

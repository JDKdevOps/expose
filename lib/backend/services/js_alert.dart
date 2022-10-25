// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js' as js;

void jsAlert(String text) {
  js.context.callMethod("alert", [text]);
}

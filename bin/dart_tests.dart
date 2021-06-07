import 'dart:io';
import 'package:self_compile/dart_tests.dart';

void main(List<String> arguments) async {
  if (Platform.script.path == myexecFile.path &&
      arguments.contains('self-compile')) {
    await compileItself();
    return await exec(myexecFile.path);
  }
  print('Hello Dart!');
}

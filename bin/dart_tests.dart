import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:self_compile/dart_tests.dart';

void main(List<String> arguments) async {
  if (p.basename(Platform.script.path) == p.basename(myexecFile.path) &&
      arguments.contains('self-compile')) {
    await compileItself();
    return await exec(myexecFile.path);
  }
  print('Hello Dart!');
}

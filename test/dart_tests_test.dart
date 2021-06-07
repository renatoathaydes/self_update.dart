import 'dart:io';

import 'package:self_compile/dart_tests.dart';
import 'package:test/test.dart';

void main() {
  group('Self-compiling Dart binary', () {
    File? executable;
    tearDownAll(() => executable?.deleteSync());
    test('prints hello Dart', () async {
      executable = await compileItself();
      final proc = await Process.run(executable!.path, []);
      expect(proc.exitCode, equals(0),
          reason: 'stdout: ${proc.stdout}\nstderr: ${proc.stderr}');
      expect(proc.stdout, equals('Hello Dart!\n'),
          reason: 'stderr: ${proc.stderr}');
    });
    test('can self-compile then print hello Dart', () async {
      executable = await compileItself();
      final proc = await Process.run(executable!.path, ['self-compile']);
      expect(proc.exitCode, equals(0),
          reason: 'stdout: ${proc.stdout}\nstderr: ${proc.stderr}');
      expect(
          proc.stdout,
          equals('self-updating...\n'
              'Info: Compiling with sound null safety\n'
              'Generated: ${executable!.path}\n'
              'Hello Dart!\n'),
          reason: 'stderr: ${proc.stderr}');
    });
  });
}

import 'dart:io';

final myexecFile = File('myexec').absolute;

Future<File> compileItself() async {
  print('self-updating...');
  if (Platform.isLinux) {
    // required on linux
    await myexecFile.delete();
  }
  await exec(
      'dart', ['compile', 'exe', 'bin/dart_tests.dart', '-o', myexecFile.path]);
  return myexecFile;
}

Future<void> exec(String command, [List<String> args = const []]) async {
  final proc = await Process.run(command, args, runInShell: true);
  final stdout = proc.stdout.toString().trim();
  final stderr = proc.stderr.toString().trim();
  if (proc.exitCode != 0) {
    if (stdout.isNotEmpty) print('$command stdout: $stdout');
    if (stderr.isNotEmpty) print('$command stderr: $stderr');
    throw Exception('$command - exit code ${proc.exitCode}');
  }
  print(stdout);
}

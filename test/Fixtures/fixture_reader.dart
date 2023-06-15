import 'dart:io';

String fixture(String name) => File('test/Fixtures/$name').readAsStringSync();

// TODO convert it to use depedency injection

// Application singletons should be stored here

import 'package:logger/logger.dart';

class LogHandlerSingleton extends Logger {
  static final LogHandlerSingleton _singleton = LogHandlerSingleton._internal();

  factory LogHandlerSingleton() {
    return _singleton;
  }

  LogHandlerSingleton._internal();
}
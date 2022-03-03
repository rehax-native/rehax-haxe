package test;

import tink.unit.*;
import tink.unit.Assert.*;
import tink.testrunner.*;

class Main {
  static function main() {
    Runner.run(TestBatch.make([new Tokenize(), new Parse(), new Generate(),])).handle(Runner.exit);
  }
}

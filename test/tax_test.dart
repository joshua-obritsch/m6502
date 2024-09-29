import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('TAX Implied', () {
    cpu.restart();
    cpu.a = 203;

    memory[0x8000] = OpCode.taxImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.taxImplied,
      tcu: 2,
      a: 203,
      x: 203,
      p: 0x20,
      pc: 0x8001,
    );
  });
}

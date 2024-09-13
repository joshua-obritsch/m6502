import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('PHA Implied', () {
    cpu.restart();
    cpu.a = 194;
    cpu.s = 0xFF;

    memory[0x8000] = OpCode.phaImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.phaImplied,
      tcu: 3,
      a: 194,
      pc: 0x8001,
      s: 0xFE,
      memory: [(0x01FF, 194)],
    );
  });
}

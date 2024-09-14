import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('PHP Implied', () {
    cpu.restart();
    cpu.p = 0xAF;
    cpu.s = 0xFF;

    memory[0x8000] = OpCode.phpImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.phpImplied,
      tcu: 3,
      p: 0xAF,
      pc: 0x8001,
      s: 0xFE,
      memory: [(0x01FF, 0xAF)],
    );
  });
}

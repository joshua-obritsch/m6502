import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('PLP Implied', () {
    cpu.restart();
    cpu.s = 0xFE;

    memory[0x01FF] = 0x4B;
    memory[0x8000] = OpCode.plpImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.plpImplied,
      tcu: 4,
      p: 0x4B,
      pc: 0x8001,
      s: 0xFF,
      memory: [(0x01FF, 0x4B)],
    );
  });
}

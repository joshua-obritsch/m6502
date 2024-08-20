import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BRK Implied', () {
    cpu.restart();
    cpu.s = 0xFF;

    memory[0x8000] = OpCode.brkImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.brkImplied,
      tcu: 7,
      p: 0x30,
      pc: 0x8000,
      s: 0xFC,
      memory: [
        (0x01FF, 0x80),
        (0x01FE, 0x02),
        (0x01FD, 0x30),
      ],
    );
  });
}

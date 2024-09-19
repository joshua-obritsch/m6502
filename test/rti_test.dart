import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('RTI Implied', () {
    cpu.restart();
    cpu.s = 0xFC;

    memory[0x01FD] = 0x9D;
    memory[0x01FE] = 0xE7;
    memory[0x01FF] = 0x1C;
    memory[0x8000] = OpCode.rtiImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rtiImplied,
      tcu: 6,
      p: 0x9D,
      pc: 0x1CE7,
      s: 0xFF,
      memory: [
        (0x01FD, 0x9D),
        (0x01FE, 0xE7),
        (0x01FF, 0x1C),
      ],
    );
  });
}

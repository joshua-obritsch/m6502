import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('JSR Absolute', () {
    cpu.restart();
    cpu.s = 0xFF;

    memory[0x8000] = OpCode.jsrAbsolute;
    memory[0x8001] = 0xC9;
    memory[0x8002] = 0x70;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.jsrAbsolute,
      tcu: 6,
      pc: 0x70C9,
      s: 0xFD,
      memory: [
        (0x01FF, 0x80),
        (0x01FE, 0x02),
      ],
    );
  });
}

import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('RTS Implied', () {
    cpu.restart();
    cpu.s = 0xFD;

    memory[0x01FE] = 0xBC;
    memory[0x01FF] = 0x68;
    memory[0x8000] = OpCode.rtsImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rtsImplied,
      tcu: 6,
      pc: 0x68BD,
      s: 0xFF,
      memory: [
        (0x01FE, 0xBC),
        (0x01FF, 0x68),
      ],
    );
  });
}

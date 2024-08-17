import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BIT Zero Page', () {
    cpu.restart();
    cpu.a = 0xCC;

    memory[0x00F4] = 0xC4;
    memory[0x8000] = OpCode.bitZeroPage;
    memory[0x8001] = 0xF4;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bitZeroPage,
      tcu: 3,
      a: 0xCC,
      p: 0xE0,
      pc: 0x8002,
    );
  });

  test('BIT Absolute', () {
    cpu.restart();
    cpu.a = 0x47;

    memory[0x3746] = 0xB8;
    memory[0x8000] = OpCode.bitAbsolute;
    memory[0x8001] = 0x46;
    memory[0x8002] = 0x37;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bitAbsolute,
      tcu: 4,
      a: 0x47,
      p: 0xA2,
      pc: 0x8003,
    );
  });
}

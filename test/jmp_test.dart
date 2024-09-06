import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('JMP Absolute', () {
    cpu.restart();

    memory[0x28D4] = 0x4E;
    memory[0x28D5] = 0xE0;
    memory[0x8000] = OpCode.jmpAbsolute;
    memory[0x8001] = 0xD4;
    memory[0x8002] = 0x28;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.jmpAbsolute,
      tcu: 3,
      pc: 0xE04E,
    );
  });

  test('JMP Indirect', () {
    cpu.restart();

    memory[0x5C75] = 0xAD;
    memory[0x5C76] = 0x56;
    memory[0x6248] = 0x75;
    memory[0x6249] = 0x5C;
    memory[0x8000] = OpCode.jmpIndirect;
    memory[0x8001] = 0x48;
    memory[0x8002] = 0x62;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.jmpIndirect,
      tcu: 5,
      pc: 0x56AD,
    );
  });
}

import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('CPY Immediate', () {
    cpu.restart();
    cpu.y = 188;

    memory[0x8000] = OpCode.cpyImmediate;
    memory[0x8001] = 188;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpyImmediate,
      y: 188,
      tcu: 2,
      p: 0x23,
      pc: 0x8002,
    );
  });

  test('CPY Zero Page', () {
    cpu.restart();
    cpu.y = 222;

    memory[0x0023] = 108;
    memory[0x8000] = OpCode.cpyZeroPage;
    memory[0x8001] = 0x23;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpyZeroPage,
      y: 222,
      tcu: 3,
      p: 0x21,
      pc: 0x8002,
    );
  });

  test('CPY Absolute', () {
    cpu.restart();
    cpu.y = 97;

    memory[0x7BA5] = 218;
    memory[0x8000] = OpCode.cpyAbsolute;
    memory[0x8001] = 0xA5;
    memory[0x8002] = 0x7B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpyAbsolute,
      tcu: 4,
      y: 97,
      p: 0xA0,
      pc: 0x8003,
    );
  });
}

import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('STY Zero Page', () {
    cpu.restart();
    cpu.y = 19;

    memory[0x8000] = OpCode.styZeroPage;
    memory[0x8001] = 0x33;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.styZeroPage,
      tcu: 3,
      y: 19,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0033, 19)],
    );
  });

  test('STY Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x68;
    cpu.y = 177;

    memory[0x8000] = OpCode.styZeroPageX;
    memory[0x8001] = 0x4E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.styZeroPageX,
      tcu: 4,
      x: 0x68,
      y: 177,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00B6, 177)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xF7;
    cpu.y = 89;

    memory[0x8000] = OpCode.styZeroPageX;
    memory[0x8001] = 0xAE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.styZeroPageX,
      tcu: 4,
      x: 0xF7,
      y: 89,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00A5, 89)],
    );
  });

  test('STY Absolute', () {
    cpu.restart();
    cpu.y = 202;

    memory[0x8000] = OpCode.styAbsolute;
    memory[0x8001] = 0x11;
    memory[0x8002] = 0x7F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.styAbsolute,
      tcu: 4,
      y: 202,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x7F11, 202)],
    );
  });
}

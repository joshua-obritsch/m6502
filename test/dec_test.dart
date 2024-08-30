import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('DEC Zero Page', () {
    cpu.restart();

    memory[0x0050] = 1;
    memory[0x8000] = OpCode.decZeroPage;
    memory[0x8001] = 0x50;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decZeroPage,
      tcu: 5,
      p: 0x22,
      pc: 0x8002,
      memory: [(0x0050, 0)],
    );
  });

  test('DEC Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x44;

    memory[0x00AE] = 0;
    memory[0x8000] = OpCode.decZeroPageX;
    memory[0x8001] = 0x6A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decZeroPageX,
      x: 0x44,
      tcu: 6,
      p: 0xA0,
      pc: 0x8002,
      memory: [(0x00AE, 255)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xF6;

    memory[0x00A7] = 109;
    memory[0x8000] = OpCode.decZeroPageX;
    memory[0x8001] = 0xB1;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decZeroPageX,
      x: 0xF6,
      tcu: 6,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00A7, 108)],
    );
  });

  test('DEC Absolute', () {
    cpu.restart();

    memory[0x6EA9] = 11;
    memory[0x8000] = OpCode.decAbsolute;
    memory[0x8001] = 0xA9;
    memory[0x8002] = 0x6E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decAbsolute,
      tcu: 6,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x6EA9, 10)],
    );
  });

  test('DEC Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x59;

    memory[0x3389] = 177;
    memory[0x8000] = OpCode.decAbsoluteX;
    memory[0x8001] = 0x30;
    memory[0x8002] = 0x33;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decAbsoluteX,
      tcu: 7,
      x: 0x59,
      p: 0xA0,
      pc: 0x8003,
      memory: [(0x3389, 176)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xCB;

    memory[0x25C0] = 128;
    memory[0x8000] = OpCode.decAbsoluteX;
    memory[0x8001] = 0xF5;
    memory[0x8002] = 0x24;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.decAbsoluteX,
      tcu: 7,
      x: 0xCB,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x25C0, 127)],
    );
  });
}

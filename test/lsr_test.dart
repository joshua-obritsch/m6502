import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('LSR Accumulator', () {
    cpu.restart();
    cpu.a = 0x2F;

    memory[0x8000] = OpCode.lsrAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrAccumulator,
      tcu: 2,
      a: 0x17,
      p: 0x21,
      pc: 0x8001,
    );
  });

  test('LSR Zero Page', () {
    cpu.restart();

    memory[0x005E] = 0xBD;
    memory[0x8000] = OpCode.lsrZeroPage;
    memory[0x8001] = 0x5E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrZeroPage,
      tcu: 5,
      p: 0x21,
      pc: 0x8002,
      memory: [(0x005E, 0x5E)],
    );
  });

  test('LSR Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x68;

    memory[0x00AA] = 0x2E;
    memory[0x8000] = OpCode.lsrZeroPageX;
    memory[0x8001] = 0x42;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrZeroPageX,
      tcu: 6,
      x: 0x68,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00AA, 0x17)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0x8E;

    memory[0x0040] = 0xB8;
    memory[0x8000] = OpCode.lsrZeroPageX;
    memory[0x8001] = 0xB2;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrZeroPageX,
      tcu: 6,
      x: 0x8E,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0040, 0x5C)],
    );
  });

  test('LSR Absolute', () {
    cpu.restart();

    memory[0x102F] = 0xFE;
    memory[0x8000] = OpCode.lsrAbsolute;
    memory[0x8001] = 0x2F;
    memory[0x8002] = 0x10;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrAbsolute,
      tcu: 6,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x102F, 0x7F)],
    );
  });

  test('LSR Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x79;

    memory[0x1084] = 0xFF;
    memory[0x8000] = OpCode.lsrAbsoluteX;
    memory[0x8001] = 0x0B;
    memory[0x8002] = 0x10;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrAbsoluteX,
      tcu: 7,
      x: 0x79,
      p: 0x21,
      pc: 0x8003,
      memory: [(0x1084, 0x7F)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xBF;

    memory[0x666B] = 0x1C;
    memory[0x8000] = OpCode.lsrAbsoluteX;
    memory[0x8001] = 0xAC;
    memory[0x8002] = 0x65;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.lsrAbsoluteX,
      tcu: 7,
      x: 0xBF,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x666B, 0x0E)],
    );
  });
}

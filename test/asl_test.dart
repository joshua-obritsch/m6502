import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ASL Accumulator', () {
    cpu.restart();
    cpu.a = 0x9D;

    memory[0x8000] = OpCode.aslAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslAccumulator,
      tcu: 2,
      a: 0x3A,
      p: 0x21,
      pc: 0x8001,
    );
  });

  test('ASL Zero Page', () {
    cpu.restart();

    memory[0x00BC] = 0x08;
    memory[0x8000] = OpCode.aslZeroPage;
    memory[0x8001] = 0xBC;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslZeroPage,
      tcu: 5,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00BC, 0x10)],
    );
  });

  test('ASL Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x15;

    memory[0x005B] = 0x6E;
    memory[0x8000] = OpCode.aslZeroPageX;
    memory[0x8001] = 0x46;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslZeroPageX,
      tcu: 6,
      x: 0x15,
      p: 0xA0,
      pc: 0x8002,
      memory: [(0x005B, 0xDC)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xFE;

    memory[0x008F] = 0x98;
    memory[0x8000] = OpCode.aslZeroPageX;
    memory[0x8001] = 0x91;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslZeroPageX,
      tcu: 6,
      x: 0xFE,
      p: 0x21,
      pc: 0x8002,
      memory: [(0x008F, 0x30)],
    );
  });

  test('ASL Absolute', () {
    cpu.restart();

    memory[0x3999] = 0xEE;
    memory[0x8000] = OpCode.aslAbsolute;
    memory[0x8001] = 0x99;
    memory[0x8002] = 0x39;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslAbsolute,
      tcu: 6,
      p: 0xA1,
      pc: 0x8003,
      memory: [(0x3999, 0xDC)],
    );
  });

  test('ASL Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x74;

    memory[0x1FD8] = 0x09;
    memory[0x8000] = OpCode.aslAbsoluteX;
    memory[0x8001] = 0x64;
    memory[0x8002] = 0x1F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslAbsoluteX,
      tcu: 7,
      x: 0x74,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x1FD8, 0x12)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xE6;

    memory[0x2B8D] = 0xDC;
    memory[0x8000] = OpCode.aslAbsoluteX;
    memory[0x8001] = 0xA7;
    memory[0x8002] = 0x2A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.aslAbsoluteX,
      tcu: 7,
      x: 0xE6,
      p: 0xA1,
      pc: 0x8003,
      memory: [(0x2B8D, 0xB8)],
    );
  });
}

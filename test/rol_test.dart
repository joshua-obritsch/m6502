import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ROL Accumulator', () {
    cpu.restart();
    cpu.a = 0x25;

    memory[0x8000] = OpCode.rolAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAccumulator,
      tcu: 2,
      a: 0x4A,
      p: 0x20,
      pc: 0x8001,
    );
  });

  test('ROL Zero Page', () {
    cpu.restart();

    memory[0x0011] = 0x80;
    memory[0x8000] = OpCode.rolZeroPage;
    memory[0x8001] = 0x11;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolZeroPage,
      tcu: 5,
      p: 0x23,
      pc: 0x8002,
      memory: [(0x0011, 0x00)],
    );
  });

  test('ROL Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x22;

    memory[0x008B] = 0xAC;
    memory[0x8000] = OpCode.rolZeroPageX;
    memory[0x8001] = 0x69;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolZeroPageX,
      tcu: 6,
      x: 0x22,
      p: 0x21,
      pc: 0x8002,
      memory: [(0x008B, 0x58)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xE9;

    memory[0x00E0] = 0x61;
    memory[0x8000] = OpCode.rolZeroPageX;
    memory[0x8001] = 0xF7;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolZeroPageX,
      tcu: 6,
      x: 0xE9,
      p: 0xA0,
      pc: 0x8002,
      memory: [(0x00E0, 0xC2)],
    );
  });

  test('ROL Absolute', () {
    cpu.restart();

    memory[0x6122] = 0xDD;
    memory[0x8000] = OpCode.rolAbsolute;
    memory[0x8001] = 0x22;
    memory[0x8002] = 0x61;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAbsolute,
      tcu: 6,
      p: 0xA1,
      pc: 0x8003,
      memory: [(0x6122, 0xBA)],
    );
  });

  test('ROL Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x38;

    memory[0x084D] = 0x4F;
    memory[0x8000] = OpCode.rolAbsoluteX;
    memory[0x8001] = 0x15;
    memory[0x8002] = 0x08;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAbsoluteX,
      tcu: 7,
      x: 0x38,
      p: 0xA0,
      pc: 0x8003,
      memory: [(0x084D, 0x9E)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0x9D;

    memory[0x7098] = 0xA9;
    memory[0x8000] = OpCode.rolAbsoluteX;
    memory[0x8001] = 0xFB;
    memory[0x8002] = 0x6F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAbsoluteX,
      tcu: 7,
      x: 0x9D,
      p: 0x21,
      pc: 0x8003,
      memory: [(0x7098, 0x52)],
    );
  });

  test('ROL Carry', () {
    // Without postset carry
    cpu.restart();
    cpu.a = 0x3D;

    memory[0x8000] = OpCode.rolAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAccumulator,
      tcu: 2,
      a: 0x7A,
      p: 0x20,
      pc: 0x8001,
    );

    // With postset carry
    cpu.restart();
    cpu.a = 0xD6;

    memory[0x8000] = OpCode.rolAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAccumulator,
      tcu: 2,
      a: 0xAC,
      p: 0xA1,
      pc: 0x8001,
    );

    // Without preset carry
    cpu.restart();
    cpu.a = 0x22;

    memory[0x8000] = OpCode.rolAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAccumulator,
      tcu: 2,
      a: 0x44,
      p: 0x20,
      pc: 0x8001,
    );

    // With preset carry
    cpu.restart();
    cpu.a = 0x3B;
    cpu.c = true;

    memory[0x8000] = OpCode.rolAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rolAccumulator,
      tcu: 2,
      a: 0x77,
      p: 0x20,
      pc: 0x8001,
    );
  });
}

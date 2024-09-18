import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ROR Accumulator', () {
    cpu.restart();
    cpu.a = 0x1F;

    memory[0x8000] = OpCode.rorAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAccumulator,
      tcu: 2,
      a: 0x0F,
      p: 0x21,
      pc: 0x8001,
    );
  });

  test('ROR Zero Page', () {
    cpu.restart();

    memory[0x006B] = 0xCC;
    memory[0x8000] = OpCode.rorZeroPage;
    memory[0x8001] = 0x6B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorZeroPage,
      tcu: 5,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x006B, 0x66)],
    );
  });

  test('ROR Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x10;

    memory[0x005E] = 0x88;
    memory[0x8000] = OpCode.rorZeroPageX;
    memory[0x8001] = 0x4E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorZeroPageX,
      tcu: 6,
      x: 0x10,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x005E, 0x44)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0x9B;

    memory[0x006A] = 0x77;
    memory[0x8000] = OpCode.rorZeroPageX;
    memory[0x8001] = 0xCF;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorZeroPageX,
      tcu: 6,
      x: 0x9B,
      p: 0x21,
      pc: 0x8002,
      memory: [(0x006A, 0x3B)],
    );
  });

  test('ROR Absolute', () {
    cpu.restart();

    memory[0x09CE] = 0x66;
    memory[0x8000] = OpCode.rorAbsolute;
    memory[0x8001] = 0xCE;
    memory[0x8002] = 0x09;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAbsolute,
      tcu: 6,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x09CE, 0x33)],
    );
  });

  test('ROR Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x0F;

    memory[0x1C62] = 0x97;
    memory[0x8000] = OpCode.rorAbsoluteX;
    memory[0x8001] = 0x53;
    memory[0x8002] = 0x1C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAbsoluteX,
      tcu: 7,
      x: 0x0F,
      p: 0x21,
      pc: 0x8003,
      memory: [(0x1C62, 0x4B)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0x84;

    memory[0x3717] = 0xDE;
    memory[0x8000] = OpCode.rorAbsoluteX;
    memory[0x8001] = 0x93;
    memory[0x8002] = 0x36;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAbsoluteX,
      tcu: 7,
      x: 0x84,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x3717, 0x6F)],
    );
  });

  test('ROR Carry', () {
    // Without postset carry
    cpu.restart();
    cpu.a = 0x86;

    memory[0x8000] = OpCode.rorAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAccumulator,
      tcu: 2,
      a: 0x43,
      p: 0x20,
      pc: 0x8001,
    );

    // With postset carry
    cpu.restart();
    cpu.a = 0x73;

    memory[0x8000] = OpCode.rorAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAccumulator,
      tcu: 2,
      a: 0x39,
      p: 0x21,
      pc: 0x8001,
    );

    // Without preset carry
    cpu.restart();
    cpu.a = 0x24;

    memory[0x8000] = OpCode.rorAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAccumulator,
      tcu: 2,
      a: 0x12,
      p: 0x20,
      pc: 0x8001,
    );

    // With preset carry
    cpu.restart();
    cpu.a = 0x81;
    cpu.c = true;

    memory[0x8000] = OpCode.rorAccumulator;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.rorAccumulator,
      tcu: 2,
      a: 0xC0,
      p: 0xA1,
      pc: 0x8001,
    );
  });
}

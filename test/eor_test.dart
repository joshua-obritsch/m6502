import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('EOR Immediate', () {
    cpu.restart();
    cpu.a = 0x49;

    memory[0x8000] = OpCode.eorImmediate;
    memory[0x8001] = 0x6F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorImmediate,
      tcu: 2,
      a: 0x26,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('EOR Zero Page', () {
    cpu.restart();
    cpu.a = 0x39;

    memory[0x003E] = 0xDA;
    memory[0x8000] = OpCode.eorZeroPage;
    memory[0x8001] = 0x3E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorZeroPage,
      tcu: 3,
      a: 0xE3,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('EOR Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0x10;
    cpu.x = 0x80;

    memory[0x0094] = 0xA5;
    memory[0x8000] = OpCode.eorZeroPageX;
    memory[0x8001] = 0x14;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorZeroPageX,
      tcu: 4,
      a: 0xB5,
      x: 0x80,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0xE9;
    cpu.x = 0xD1;

    memory[0x005D] = 0x9F;
    memory[0x8000] = OpCode.eorZeroPageX;
    memory[0x8001] = 0x8C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorZeroPageX,
      tcu: 4,
      a: 0x76,
      x: 0xD1,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('EOR Absolute', () {
    cpu.restart();
    cpu.a = 0x69;

    memory[0x7ADD] = 0x7B;
    memory[0x8000] = OpCode.eorAbsolute;
    memory[0x8001] = 0xDD;
    memory[0x8002] = 0x7A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorAbsolute,
      tcu: 4,
      a: 0x12,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('EOR Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x84;
    cpu.x = 0x05;

    memory[0x206C] = 0x07;
    memory[0x8000] = OpCode.eorAbsoluteX;
    memory[0x8001] = 0x67;
    memory[0x8002] = 0x20;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorAbsoluteX,
      tcu: 4,
      a: 0x83,
      x: 0x05,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0x3A;
    cpu.x = 0x9C;

    memory[0x4079] = 0x0E;
    memory[0x8000] = OpCode.eorAbsoluteX;
    memory[0x8001] = 0xDD;
    memory[0x8002] = 0x3F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorAbsoluteX,
      tcu: 5,
      a: 0x34,
      x: 0x9C,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('EOR Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x3F;
    cpu.y = 0x41;

    memory[0x5C57] = 0x78;
    memory[0x8000] = OpCode.eorAbsoluteY;
    memory[0x8001] = 0x16;
    memory[0x8002] = 0x5C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorAbsoluteY,
      tcu: 4,
      a: 0x47,
      y: 0x41,
      p: 0x20,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0xB0;
    cpu.y = 0x88;

    memory[0x7F1C] = 0xDD;
    memory[0x8000] = OpCode.eorAbsoluteY;
    memory[0x8001] = 0x94;
    memory[0x8002] = 0x7E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorAbsoluteY,
      tcu: 5,
      a: 0x6D,
      y: 0x88,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('EOR Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0x0F;
    cpu.x = 0x6D;

    memory[0x00EC] = 0x9D;
    memory[0x00ED] = 0x5D;
    memory[0x5D9D] = 0xB5;
    memory[0x8000] = OpCode.eorIndirectX;
    memory[0x8001] = 0x7F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorIndirectX,
      tcu: 6,
      a: 0xBA,
      x: 0x6D,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0x94;
    cpu.x = 0xAC;

    memory[0x0093] = 0x11;
    memory[0x0094] = 0x39;
    memory[0x3911] = 0x5D;
    memory[0x8000] = OpCode.eorIndirectX;
    memory[0x8001] = 0xE7;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorIndirectX,
      tcu: 6,
      a: 0xC9,
      x: 0xAC,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('EOR Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x96;
    cpu.y = 0x17;

    memory[0x0020] = 0x3B;
    memory[0x0021] = 0x45;
    memory[0x4552] = 0x49;
    memory[0x8000] = OpCode.eorIndirectY;
    memory[0x8001] = 0x20;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorIndirectY,
      tcu: 5,
      a: 0xDF,
      y: 0x17,
      p: 0xA0,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0x6B;
    cpu.y = 0xFB;

    memory[0x006A] = 0xCD;
    memory[0x006B] = 0x5C;
    memory[0x5DC8] = 0xB0;
    memory[0x8000] = OpCode.eorIndirectY;
    memory[0x8001] = 0x6A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.eorIndirectY,
      tcu: 6,
      a: 0xDB,
      y: 0xFB,
      p: 0xA0,
      pc: 0x8002,
    );
  });
}

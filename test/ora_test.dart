import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ORA Immediate', () {
    cpu.restart();
    cpu.a = 0xF9;

    memory[0x8000] = OpCode.oraImmediate;
    memory[0x8001] = 0x76;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraImmediate,
      tcu: 2,
      a: 0xFF,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('ORA Zero Page', () {
    cpu.restart();
    cpu.a = 0x89;

    memory[0x0037] = 0x5A;
    memory[0x8000] = OpCode.oraZeroPage;
    memory[0x8001] = 0x37;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraZeroPage,
      tcu: 3,
      a: 0xDB,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('ORA Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0x44;
    cpu.x = 0x09;

    memory[0x0085] = 0x54;
    memory[0x8000] = OpCode.oraZeroPageX;
    memory[0x8001] = 0x7C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraZeroPageX,
      tcu: 4,
      a: 0x54,
      x: 0x09,
      p: 0x20,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0xAB;
    cpu.x = 0xFC;

    memory[0x00E4] = 0x2F;
    memory[0x8000] = OpCode.oraZeroPageX;
    memory[0x8001] = 0xE8;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraZeroPageX,
      tcu: 4,
      a: 0xAF,
      x: 0xFC,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('ORA Absolute', () {
    cpu.restart();
    cpu.a = 0xB6;

    memory[0x4FCA] = 0xB4;
    memory[0x8000] = OpCode.oraAbsolute;
    memory[0x8001] = 0xCA;
    memory[0x8002] = 0x4F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraAbsolute,
      tcu: 4,
      a: 0xB6,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('ORA Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x2B;
    cpu.x = 0x36;

    memory[0x6F5B] = 0x3C;
    memory[0x8000] = OpCode.oraAbsoluteX;
    memory[0x8001] = 0x25;
    memory[0x8002] = 0x6F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraAbsoluteX,
      tcu: 4,
      a: 0x3F,
      x: 0x36,
      p: 0x20,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0x83;
    cpu.x = 0x9D;

    memory[0x2269] = 0x1E;
    memory[0x8000] = OpCode.oraAbsoluteX;
    memory[0x8001] = 0xCC;
    memory[0x8002] = 0x21;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraAbsoluteX,
      tcu: 5,
      a: 0x9F,
      x: 0x9D,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('ORA Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x89;
    cpu.y = 0x22;

    memory[0x6897] = 0x75;
    memory[0x8000] = OpCode.oraAbsoluteY;
    memory[0x8001] = 0x75;
    memory[0x8002] = 0x68;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraAbsoluteY,
      tcu: 4,
      a: 0xFD,
      y: 0x22,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0x52;
    cpu.y = 0xC2;

    memory[0x3A5E] = 0xA1;
    memory[0x8000] = OpCode.oraAbsoluteY;
    memory[0x8001] = 0x9C;
    memory[0x8002] = 0x39;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraAbsoluteY,
      tcu: 5,
      a: 0xF3,
      y: 0xC2,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('ORA Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0x81;
    cpu.x = 0x20;

    memory[0x0073] = 0x2C;
    memory[0x0074] = 0x0D;
    memory[0x0D2C] = 0x9B;
    memory[0x8000] = OpCode.oraIndirectX;
    memory[0x8001] = 0x53;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraIndirectX,
      tcu: 6,
      a: 0x9B,
      x: 0x20,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0x40;
    cpu.x = 0x89;

    memory[0x004E] = 0xB9;
    memory[0x004F] = 0x2F;
    memory[0x2FB9] = 0x5C;
    memory[0x8000] = OpCode.oraIndirectX;
    memory[0x8001] = 0xC5;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraIndirectX,
      tcu: 6,
      a: 0x5C,
      x: 0x89,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('ORA Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x6D;
    cpu.y = 0x28;

    memory[0x0005] = 0x34;
    memory[0x0006] = 0x42;
    memory[0x425C] = 0x06;
    memory[0x8000] = OpCode.oraIndirectY;
    memory[0x8001] = 0x05;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraIndirectY,
      tcu: 5,
      a: 0x6F,
      y: 0x28,
      p: 0x20,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0xDC;
    cpu.y = 0xB6;

    memory[0x0052] = 0xEF;
    memory[0x0053] = 0x61;
    memory[0x62A5] = 0x1D;
    memory[0x8000] = OpCode.oraIndirectY;
    memory[0x8001] = 0x52;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.oraIndirectY,
      tcu: 6,
      a: 0xDD,
      y: 0xB6,
      p: 0xA0,
      pc: 0x8002,
    );
  });
}

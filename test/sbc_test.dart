import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('SBC Immediate', () {
    cpu.restart();
    cpu.a = 80;
    cpu.c = true;

    memory[0x8000] = OpCode.sbcImmediate;
    memory[0x8001] = 240;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcImmediate,
      tcu: 2,
      a: 96,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('SBC Zero Page', () {
    cpu.restart();
    cpu.a = 80;
    cpu.c = true;

    memory[0x00E0] = 176;
    memory[0x8000] = OpCode.sbcZeroPage;
    memory[0x8001] = 0xE0;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcZeroPage,
      tcu: 3,
      a: 160,
      p: 0xE0,
      pc: 0x8002,
    );
  });

  test('SBC Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 80;
    cpu.x = 0x27;
    cpu.c = true;

    memory[0x008F] = 112;
    memory[0x8000] = OpCode.sbcZeroPageX;
    memory[0x8001] = 0x68;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcZeroPageX,
      tcu: 4,
      a: 224,
      x: 0x27,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 80;
    cpu.x = 0x94;
    cpu.c = true;

    memory[0x007F] = 48;
    memory[0x8000] = OpCode.sbcZeroPageX;
    memory[0x8001] = 0xEB;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcZeroPageX,
      tcu: 4,
      a: 32,
      x: 0x94,
      p: 0x21,
      pc: 0x8002,
    );
  });

  test('SBC Absolute', () {
    cpu.restart();
    cpu.a = 208;
    cpu.c = true;

    memory[0x2BC8] = 240;
    memory[0x8000] = OpCode.sbcAbsolute;
    memory[0x8001] = 0xC8;
    memory[0x8002] = 0x2B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcAbsolute,
      tcu: 4,
      a: 224,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('SBC Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 208;
    cpu.x = 0x44;
    cpu.c = true;

    memory[0x729A] = 176;
    memory[0x8000] = OpCode.sbcAbsoluteX;
    memory[0x8001] = 0x56;
    memory[0x8002] = 0x72;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcAbsoluteX,
      tcu: 4,
      a: 32,
      x: 0x44,
      p: 0x21,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 208;
    cpu.x = 0xFA;
    cpu.c = true;

    memory[0x62E9] = 112;
    memory[0x8000] = OpCode.sbcAbsoluteX;
    memory[0x8001] = 0xEF;
    memory[0x8002] = 0x61;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcAbsoluteX,
      tcu: 5,
      a: 96,
      x: 0xFA,
      p: 0x61,
      pc: 0x8003,
    );
  });

  test('SBC Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 208;
    cpu.y = 0x3A;
    cpu.c = true;

    memory[0x3CAF] = 48;
    memory[0x8000] = OpCode.sbcAbsoluteY;
    memory[0x8001] = 0x75;
    memory[0x8002] = 0x3C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcAbsoluteY,
      tcu: 4,
      a: 160,
      y: 0x3A,
      p: 0xA1,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 54;
    cpu.y = 0xA6;
    cpu.c = true;

    memory[0x0D92] = 234;
    memory[0x8000] = OpCode.sbcAbsoluteY;
    memory[0x8001] = 0xEC;
    memory[0x8002] = 0x0C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcAbsoluteY,
      tcu: 5,
      a: 76,
      y: 0xA6,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('SBC Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 118;
    cpu.x = 0x00;
    cpu.c = true;

    memory[0x003B] = 0x38;
    memory[0x003C] = 0x49;
    memory[0x4938] = 128;
    memory[0x8000] = OpCode.sbcIndirectX;
    memory[0x8001] = 0x3B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcIndirectX,
      tcu: 6,
      a: 246,
      x: 0x00,
      p: 0xE0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 103;
    cpu.x = 0x82;
    cpu.c = true;

    memory[0x0069] = 0x1C;
    memory[0x006A] = 0x1F;
    memory[0x1F1C] = 123;
    memory[0x8000] = OpCode.sbcIndirectX;
    memory[0x8001] = 0xE7;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcIndirectX,
      tcu: 6,
      a: 236,
      x: 0x82,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('SBC Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 100;
    cpu.y = 0x3C;
    cpu.c = true;

    memory[0x0060] = 0x00;
    memory[0x0061] = 0x6D;
    memory[0x6D3C] = 3;
    memory[0x8000] = OpCode.sbcIndirectY;
    memory[0x8001] = 0x60;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcIndirectY,
      tcu: 5,
      a: 97,
      y: 0x3C,
      p: 0x21,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 177;
    cpu.y = 0xC5;
    cpu.c = true;

    memory[0x00D3] = 0xE1;
    memory[0x00D4] = 0x63;
    memory[0x64A6] = 249;
    memory[0x8000] = OpCode.sbcIndirectY;
    memory[0x8001] = 0xD3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.sbcIndirectY,
      tcu: 6,
      a: 184,
      y: 0xC5,
      p: 0xA0,
      pc: 0x8002,
    );
  });
}

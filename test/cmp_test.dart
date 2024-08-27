import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('CMP Immediate', () {
    cpu.restart();
    cpu.a = 137;

    memory[0x8000] = OpCode.cmpImmediate;
    memory[0x8001] = 137;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpImmediate,
      a: 137,
      tcu: 2,
      p: 0x23,
      pc: 0x8002,
    );
  });

  test('CMP Zero Page', () {
    cpu.restart();
    cpu.a = 223;

    memory[0x004A] = 217;
    memory[0x8000] = OpCode.cmpZeroPage;
    memory[0x8001] = 0x4A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpZeroPage,
      a: 223,
      tcu: 3,
      p: 0x21,
      pc: 0x8002,
    );
  });

  test('CMP Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 38;

    memory[0x00BC] = 50;
    memory[0x8000] = OpCode.cmpZeroPageX;
    memory[0x8001] = 0xBC;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpZeroPageX,
      a: 38,
      tcu: 4,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 94;
    cpu.x = 0x7F;

    memory[0x0049] = 147;
    memory[0x8000] = OpCode.cmpZeroPageX;
    memory[0x8001] = 0xCA;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpZeroPageX,
      tcu: 4,
      a: 94,
      x: 0x7F,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('CMP Absolute', () {
    cpu.restart();
    cpu.a = 239;

    memory[0x1755] = 178;
    memory[0x8000] = OpCode.cmpAbsolute;
    memory[0x8001] = 0x55;
    memory[0x8002] = 0x17;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpAbsolute,
      tcu: 4,
      a: 239,
      p: 0x21,
      pc: 0x8003,
    );
  });

  test('CMP Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 173;
    cpu.x = 0x50;

    memory[0x6894] = 38;
    memory[0x8000] = OpCode.cmpAbsoluteX;
    memory[0x8001] = 0x44;
    memory[0x8002] = 0x68;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpAbsoluteX,
      tcu: 4,
      a: 173,
      x: 0x50,
      p: 0xA1,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 52;
    cpu.x = 0xE4;

    memory[0x4186] = 224;
    memory[0x8000] = OpCode.cmpAbsoluteX;
    memory[0x8001] = 0xA2;
    memory[0x8002] = 0x40;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpAbsoluteX,
      tcu: 5,
      a: 52,
      x: 0xE4,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('CMP Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 68;
    cpu.y = 0x72;

    memory[0x5EB9] = 187;
    memory[0x8000] = OpCode.cmpAbsoluteY;
    memory[0x8001] = 0x47;
    memory[0x8002] = 0x5E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpAbsoluteY,
      tcu: 4,
      a: 68,
      y: 0x72,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 119;
    cpu.y = 0xBB;

    memory[0x3169] = 239;
    memory[0x8000] = OpCode.cmpAbsoluteY;
    memory[0x8001] = 0xAE;
    memory[0x8002] = 0x30;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpAbsoluteY,
      tcu: 5,
      a: 119,
      y: 0xBB,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('CMP Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 194;
    cpu.x = 0x49;

    memory[0x004A] = 0x49;
    memory[0x004B] = 0x30;
    memory[0x3049] = 10;
    memory[0x8000] = OpCode.cmpIndirectX;
    memory[0x8001] = 0x01;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpIndirectX,
      tcu: 6,
      a: 194,
      x: 0x49,
      p: 0xA1,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 4;
    cpu.x = 0xC1;

    memory[0x00AD] = 0x2C;
    memory[0x00AE] = 0x4D;
    memory[0x4D2C] = 10;
    memory[0x8000] = OpCode.cmpIndirectX;
    memory[0x8001] = 0xEC;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpIndirectX,
      tcu: 6,
      a: 4,
      x: 0xC1,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('CMP Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 243;
    cpu.y = 0x59;

    memory[0x006B] = 0x17;
    memory[0x006C] = 0x36;
    memory[0x3670] = 53;
    memory[0x8000] = OpCode.cmpIndirectY;
    memory[0x8001] = 0x6B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpIndirectY,
      tcu: 5,
      a: 243,
      y: 0x59,
      p: 0xA1,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 6;
    cpu.y = 0xE5;

    memory[0x00CE] = 0xF8;
    memory[0x00CF] = 0x0A;
    memory[0x0BDD] = 242;
    memory[0x8000] = OpCode.cmpIndirectY;
    memory[0x8001] = 0xCE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cmpIndirectY,
      tcu: 6,
      a: 6,
      y: 0xE5,
      p: 0x20,
      pc: 0x8002,
    );
  });
}

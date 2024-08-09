import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ADD Immediate', () {
    cpu.restart();
    cpu.a = 32;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 105;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      a: 137,
      p: 0xC0,
      pc: 0x8002,
      cycles: 2,
    );
  });

  test('ADD Zero Page', () {
    cpu.restart();
    cpu.a = 205;

    memory[0x0085] = 28;
    memory[0x8000] = OpCode.adcZeroPage;
    memory[0x8001] = 0x85;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPage,
      a: 233,
      p: 0x80,
      pc: 0x8002,
      cycles: 3,
    );
  });

  test('ADD Zero Page X', () {
    cpu.restart();
    cpu.a = 20;
    cpu.x = 0x46;

    memory[0x006E] = 159;
    memory[0x8000] = OpCode.adcZeroPageX;
    memory[0x8001] = 0x28;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPageX,
      a: 179,
      x: 0x46,
      p: 0x80,
      pc: 0x8002,
      cycles: 4,
    );
  });

  test('ADD Zero Page X (Wrapping)', () {
    cpu.restart();
    cpu.a = 10;
    cpu.x = 0x96;

    memory[0x0054] = 104;
    memory[0x8000] = OpCode.adcZeroPageX;
    memory[0x8001] = 0xBE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPageX,
      a: 114,
      x: 0x96,
      pc: 0x8002,
      cycles: 4,
    );
  });

  test('ADD Absolute', () {
    cpu.restart();
    cpu.a = 120;

    memory[0x6A9F] = 13;
    memory[0x8000] = OpCode.adcAbsolute;
    memory[0x8001] = 0x9F;
    memory[0x8002] = 0x6A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsolute,
      a: 133,
      p: 0xC0,
      pc: 0x8003,
      cycles: 4,
    );
  });

  test('ADD Absolute X', () {
    cpu.restart();
    cpu.a = 137;
    cpu.x = 0x74;

    memory[0x53F6] = 109;
    memory[0x8000] = OpCode.adcAbsoluteX;
    memory[0x8001] = 0x82;
    memory[0x8002] = 0x53;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsoluteX,
      a: 246,
      x: 0x74,
      p: 0x80,
      pc: 0x8003,
      cycles: 4,
    );
  });

  test('ADD Absolute X (Page Boundary Crossing)', () {
    cpu.restart();
    cpu.a = 176;
    cpu.x = 0xAB;

    memory[0x054F] = 134;
    memory[0x8000] = OpCode.adcAbsoluteX;
    memory[0x8001] = 0xA4;
    memory[0x8002] = 0x04;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsoluteX,
      a: 54,
      x: 0xAB,
      p: 0x41,
      pc: 0x8003,
      cycles: 5,
    );
  });

  test('ADD Absolute Y', () {
    cpu.restart();
    cpu.a = 129;
    cpu.y = 0x07;

    memory[0x56EB] = 141;
    memory[0x8000] = OpCode.adcAbsoluteY;
    memory[0x8001] = 0xE4;
    memory[0x8002] = 0x56;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsoluteY,
      a: 14,
      y: 0x07,
      p: 0x41,
      pc: 0x8003,
      cycles: 4,
    );
  });

  test('ADD Absolute Y (Page Boundary Crossing)', () {
    cpu.restart();
    cpu.a = 18;
    cpu.y = 0xF0;

    memory[0x45ED] = 168;
    memory[0x8000] = OpCode.adcAbsoluteY;
    memory[0x8001] = 0xFD;
    memory[0x8002] = 0x44;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcAbsoluteY,
      a: 186,
      y: 0xF0,
      p: 0x80,
      pc: 0x8003,
      cycles: 5,
    );
  });

  test('ADD Indirect X', () {
    cpu.restart();
    cpu.a = 85;
    cpu.x = 0x6B;

    memory[0x00C3] = 0xCE;
    memory[0x00C4] = 0x79;
    memory[0x79CE] = 213;
    memory[0x8000] = OpCode.adcIndirectX;
    memory[0x8001] = 0x58;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcIndirectX,
      a: 42,
      x: 0x6B,
      p: 0x01,
      pc: 0x8002,
      cycles: 6,
    );
  });

  test('ADD Indirect X (Wrapping)', () {
    cpu.restart();
    cpu.a = 150;
    cpu.x = 0xCA;

    memory[0x00AD] = 0xB6;
    memory[0x00AE] = 0x39;
    memory[0x39B6] = 46;
    memory[0x8000] = OpCode.adcIndirectX;
    memory[0x8001] = 0xE3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcIndirectX,
      a: 196,
      x: 0xCA,
      p: 0x80,
      pc: 0x8002,
      cycles: 6,
    );
  });

  test('ADD Indirect Y', () {
    cpu.restart();
    cpu.a = 30;
    cpu.y = 0xC7;

    memory[0x00E7] = 0x09;
    memory[0x00E8] = 0x1C;
    memory[0x1CD0] = 125;
    memory[0x8000] = OpCode.adcIndirectY;
    memory[0x8001] = 0xE7;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcIndirectY,
      a: 155,
      y: 0xC7,
      p: 0xC0,
      pc: 0x8002,
      cycles: 5,
    );
  });

  test('ADD Indirect Y (Page Boundary Crossing)', () {
    cpu.restart();
    cpu.a = 111;
    cpu.y = 0x8A;

    memory[0x005E] = 0xEE;
    memory[0x005F] = 0x1A;
    memory[0x1B78] = 113;
    memory[0x8000] = OpCode.adcIndirectY;
    memory[0x8001] = 0x5E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcIndirectY,
      a: 224,
      y: 0x8A,
      p: 0xC0,
      pc: 0x8002,
      cycles: 6,
    );
  });
}

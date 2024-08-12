import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('ADC Immediate', () {
    cpu.restart();
    cpu.a = 32;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 105;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 137,
      p: 0xE0,
      pc: 0x8002,
    );
  });

  test('ADC Zero Page', () {
    cpu.restart();
    cpu.a = 205;

    memory[0x0085] = 28;
    memory[0x8000] = OpCode.adcZeroPage;
    memory[0x8001] = 0x85;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcZeroPage,
      tcu: 3,
      a: 233,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('ADC Zero Page X', () {
    // Without wrapping
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
      tcu: 4,
      a: 179,
      x: 0x46,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
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
      tcu: 4,
      a: 114,
      x: 0x96,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('ADC Absolute', () {
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
      tcu: 4,
      a: 133,
      p: 0xE0,
      pc: 0x8003,
    );
  });

  test('ADC Absolute X', () {
    // Without page boundary crossing
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
      tcu: 4,
      a: 246,
      x: 0x74,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
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
      tcu: 5,
      a: 54,
      x: 0xAB,
      p: 0x61,
      pc: 0x8003,
    );
  });

  test('ADC Absolute Y', () {
    // Without page boundary crossing
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
      tcu: 4,
      a: 14,
      y: 0x07,
      p: 0x61,
      pc: 0x8003,
    );

    // With page boundary crossing
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
      tcu: 5,
      a: 186,
      y: 0xF0,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('ADC Indirect X', () {
    // Without wrapping
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
      tcu: 6,
      a: 42,
      x: 0x6B,
      p: 0x21,
      pc: 0x8002,
    );

    // With wrapping
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
      tcu: 6,
      a: 196,
      x: 0xCA,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('ADC Indirect Y', () {
    // Without page boundary crossing
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
      tcu: 5,
      a: 155,
      y: 0xC7,
      p: 0xE0,
      pc: 0x8002,
    );

    // With page boundary crossing
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
      tcu: 6,
      a: 224,
      y: 0x8A,
      p: 0xE0,
      pc: 0x8002,
    );
  });

  test('ADC Carry', () {
    // Without postset carry
    cpu.restart();
    cpu.a = 28;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 104;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 132,
      p: 0xE0,
      pc: 0x8002,
    );

    // With postset carry
    cpu.restart();
    cpu.a = 207;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 253;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 204,
      p: 0xA1,
      pc: 0x8002,
    );

    // Without preset carry
    cpu.restart();
    cpu.a = 72;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 36;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 108,
      p: 0x20,
      pc: 0x8002,
    );

    // With preset carry
    cpu.restart();
    cpu.a = 28;
    cpu.c = true;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 50;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 79,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('ADC Zero', () {
    // Non-zero
    cpu.restart();
    cpu.a = 235;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 240;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 219,
      p: 0xA1,
      pc: 0x8002,
    );

    // Zero
    cpu.restart();
    cpu.a = 252;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 4;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 0,
      p: 0x23,
      pc: 0x8002,
    );
  });

  test('ADC Overflow', () {
    // Without overflow (A positive, M positive)
    cpu.restart();
    cpu.a = 49;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 52,
      p: 0x20,
      pc: 0x8002,
    );

    // Without overflow (A negative, M negative)
    cpu.restart();
    cpu.a = 232;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 202;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 178,
      p: 0xA1,
      pc: 0x8002,
    );

    // Without overflow (A positive, M negative)
    cpu.restart();
    cpu.a = 54;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 141;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 195,
      p: 0xA0,
      pc: 0x8002,
    );

    // Without overflow (A negative, M positive)
    cpu.restart();
    cpu.a = 212;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 121;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 77,
      p: 0x21,
      pc: 0x8002,
    );

    // With overflow (A positive, M positive)
    cpu.restart();
    cpu.a = 106;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 114;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 220,
      p: 0xE0,
      pc: 0x8002,
    );

    // With overflow (A negative, M negative)
    cpu.restart();
    cpu.a = 151;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 175;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 70,
      p: 0x61,
      pc: 0x8002,
    );
  });

  test('ADC Negative', () {
    // Non-negative
    cpu.restart();
    cpu.a = 43;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 5;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 48,
      p: 0x20,
      pc: 0x8002,
    );

    // Negative
    cpu.restart();
    cpu.a = 112;

    memory[0x8000] = OpCode.adcImmediate;
    memory[0x8001] = 96;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.adcImmediate,
      tcu: 2,
      a: 208,
      p: 0xE0,
      pc: 0x8002,
    );
  });
}

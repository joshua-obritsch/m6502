import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('AND Immediate', () {
    cpu.restart();
    cpu.a = 0xBD;

    memory[0x8000] = OpCode.andImmediate;
    memory[0x8001] = 0xF3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andImmediate,
      tcu: 2,
      a: 0xB1,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('AND Zero Page', () {
    cpu.restart();
    cpu.a = 0x47;

    memory[0x0064] = 0x62;
    memory[0x8000] = OpCode.andZeroPage;
    memory[0x8001] = 0x64;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andZeroPage,
      tcu: 3,
      a: 0x42,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('AND Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0xCA;
    cpu.x = 0x6B;

    memory[0x00E1] = 0xF1;
    memory[0x8000] = OpCode.andZeroPageX;
    memory[0x8001] = 0x76;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andZeroPageX,
      tcu: 4,
      a: 0xC0,
      x: 0x6B,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0xF0;
    cpu.x = 0xF6;

    memory[0x009C] = 0x49;
    memory[0x8000] = OpCode.andZeroPageX;
    memory[0x8001] = 0xA6;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andZeroPageX,
      tcu: 4,
      a: 0x40,
      x: 0xF6,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('AND Absolute', () {
    cpu.restart();
    cpu.a = 0xD9;

    memory[0x13DD] = 0x8A;
    memory[0x8000] = OpCode.andAbsolute;
    memory[0x8001] = 0xDD;
    memory[0x8002] = 0x13;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andAbsolute,
      tcu: 4,
      a: 0x88,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('AND Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x23;
    cpu.x = 0x33;

    memory[0x1E8A] = 0x8A;
    memory[0x8000] = OpCode.andAbsoluteX;
    memory[0x8001] = 0x57;
    memory[0x8002] = 0x1E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andAbsoluteX,
      tcu: 4,
      a: 0x02,
      x: 0x33,
      p: 0x20,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0x4A;
    cpu.x = 0xCB;

    memory[0x567D] = 0x98;
    memory[0x8000] = OpCode.andAbsoluteX;
    memory[0x8001] = 0xB2;
    memory[0x8002] = 0x55;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andAbsoluteX,
      tcu: 5,
      a: 0x08,
      x: 0xCB,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('AND Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x29;
    cpu.y = 0x27;

    memory[0x3159] = 0xDC;
    memory[0x8000] = OpCode.andAbsoluteY;
    memory[0x8001] = 0x32;
    memory[0x8002] = 0x31;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andAbsoluteY,
      tcu: 4,
      a: 0x08,
      y: 0x27,
      p: 0x20,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0xB3;
    cpu.y = 0xF5;

    memory[0x2AA8] = 0x40;
    memory[0x8000] = OpCode.andAbsoluteY;
    memory[0x8001] = 0xB3;
    memory[0x8002] = 0x29;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andAbsoluteY,
      tcu: 5,
      a: 0x00,
      y: 0xF5,
      p: 0x22,
      pc: 0x8003,
    );
  });

  test('AND Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 0x6C;
    cpu.x = 0x07;

    memory[0x0081] = 0x4F;
    memory[0x0082] = 0x0C;
    memory[0x0C4F] = 0x5F;
    memory[0x8000] = OpCode.andIndirectX;
    memory[0x8001] = 0x7A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andIndirectX,
      tcu: 6,
      a: 0x4C,
      x: 0x07,
      p: 0x20,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.a = 0xD6;
    cpu.x = 0xF2;

    memory[0x0085] = 0xB2;
    memory[0x0086] = 0x21;
    memory[0x21B2] = 0x5F;
    memory[0x8000] = OpCode.andIndirectX;
    memory[0x8001] = 0x93;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andIndirectX,
      tcu: 6,
      a: 0x56,
      x: 0xF2,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('AND Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 0x78;
    cpu.y = 0x1C;

    memory[0x0074] = 0x81;
    memory[0x0075] = 0x58;
    memory[0x589D] = 0x7D;
    memory[0x8000] = OpCode.andIndirectY;
    memory[0x8001] = 0x74;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andIndirectY,
      tcu: 5,
      a: 0x78,
      y: 0x1C,
      p: 0x20,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 0xC9;
    cpu.y = 0x98;

    memory[0x00DE] = 0xF1;
    memory[0x00DF] = 0x3A;
    memory[0x3B89] = 0x66;
    memory[0x8000] = OpCode.andIndirectY;
    memory[0x8001] = 0xDE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.andIndirectY,
      tcu: 6,
      a: 0x40,
      y: 0x98,
      p: 0x20,
      pc: 0x8002,
    );
  });
}

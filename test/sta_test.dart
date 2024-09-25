import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('STA Zero Page', () {
    cpu.restart();
    cpu.a = 36;

    memory[0x8000] = OpCode.staZeroPage;
    memory[0x8001] = 0xB3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staZeroPage,
      tcu: 3,
      a: 36,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00B3, 36)],
    );
  });

  test('STA Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 196;
    cpu.x = 0x70;

    memory[0x8000] = OpCode.staZeroPageX;
    memory[0x8001] = 0x71;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staZeroPageX,
      tcu: 4,
      a: 196,
      x: 0x70,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00E1, 196)],
    );

    // With wrapping
    cpu.restart();
    cpu.a = 216;
    cpu.x = 0x93;

    memory[0x8000] = OpCode.staZeroPageX;
    memory[0x8001] = 0x8D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staZeroPageX,
      tcu: 4,
      a: 216,
      x: 0x93,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0020, 216)],
    );
  });

  test('STA Absolute', () {
    cpu.restart();
    cpu.a = 53;

    memory[0x8000] = OpCode.staAbsolute;
    memory[0x8001] = 0x41;
    memory[0x8002] = 0x3D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staAbsolute,
      tcu: 4,
      a: 53,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x3D41, 53)],
    );
  });

  test('STA Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 69;
    cpu.x = 0x2B;

    memory[0x8000] = OpCode.staAbsoluteX;
    memory[0x8001] = 0x4D;
    memory[0x8002] = 0x39;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staAbsoluteX,
      tcu: 5,
      a: 69,
      x: 0x2B,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x3978, 69)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 250;
    cpu.x = 0xD0;

    memory[0x8000] = OpCode.staAbsoluteX;
    memory[0x8001] = 0xC8;
    memory[0x8002] = 0x78;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staAbsoluteX,
      tcu: 5,
      a: 250,
      x: 0xD0,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x7998, 250)],
    );
  });

  test('STA Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 204;
    cpu.y = 0x00;

    memory[0x8000] = OpCode.staAbsoluteY;
    memory[0x8001] = 0x62;
    memory[0x8002] = 0x34;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staAbsoluteY,
      tcu: 5,
      a: 204,
      y: 0x00,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x3462, 204)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 238;
    cpu.y = 0x80;

    memory[0x8000] = OpCode.staAbsoluteY;
    memory[0x8001] = 0x87;
    memory[0x8002] = 0x7D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staAbsoluteY,
      tcu: 5,
      a: 238,
      y: 0x80,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x7E07, 238)],
    );
  });

  test('STA Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.a = 39;
    cpu.x = 0x70;

    memory[0x00D6] = 0x6D;
    memory[0x00D7] = 0x07;
    memory[0x8000] = OpCode.staIndirectX;
    memory[0x8001] = 0x66;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staIndirectX,
      tcu: 6,
      a: 39,
      x: 0x70,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x076D, 39)],
    );

    // With wrapping
    cpu.restart();
    cpu.a = 249;
    cpu.x = 0x9F;

    memory[0x004D] = 0x58;
    memory[0x004E] = 0x30;
    memory[0x8000] = OpCode.staIndirectX;
    memory[0x8001] = 0xAE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staIndirectX,
      tcu: 6,
      a: 249,
      x: 0x9F,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x3058, 249)],
    );
  });

  test('STA Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.a = 138;
    cpu.y = 0x1B;

    memory[0x00BD] = 0x18;
    memory[0x00BE] = 0x7A;
    memory[0x8000] = OpCode.staIndirectY;
    memory[0x8001] = 0xBD;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staIndirectY,
      tcu: 6,
      a: 138,
      y: 0x1B,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x7A33, 138)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.a = 88;
    cpu.y = 0xA4;

    memory[0x00A3] = 0x90;
    memory[0x00A4] = 0x27;
    memory[0x8000] = OpCode.staIndirectY;
    memory[0x8001] = 0xA3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.staIndirectY,
      tcu: 6,
      a: 88,
      y: 0xA4,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x2834, 88)],
    );
  });
}

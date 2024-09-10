import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('LDY Immediate', () {
    cpu.restart();

    memory[0x8000] = OpCode.ldyImmediate;
    memory[0x8001] = 33;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyImmediate,
      tcu: 2,
      y: 33,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('LDY Zero Page', () {
    cpu.restart();

    memory[0x0044] = 248;
    memory[0x8000] = OpCode.ldyZeroPage;
    memory[0x8001] = 0x44;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyZeroPage,
      tcu: 3,
      y: 248,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('LDY Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x39;

    memory[0x006E] = 233;
    memory[0x8000] = OpCode.ldyZeroPageX;
    memory[0x8001] = 0x35;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyZeroPageX,
      tcu: 4,
      x: 0x39,
      y: 233,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xC6;

    memory[0x0082] = 193;
    memory[0x8000] = OpCode.ldyZeroPageX;
    memory[0x8001] = 0xBC;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyZeroPageX,
      tcu: 4,
      x: 0xC6,
      y: 193,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('LDY Absolute', () {
    cpu.restart();

    memory[0x33F8] = 246;
    memory[0x8000] = OpCode.ldyAbsolute;
    memory[0x8001] = 0xF8;
    memory[0x8002] = 0x33;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyAbsolute,
      tcu: 4,
      y: 246,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('LDY Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x01;

    memory[0x6E5A] = 249;
    memory[0x8000] = OpCode.ldyAbsoluteX;
    memory[0x8001] = 0x59;
    memory[0x8002] = 0x6E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyAbsoluteX,
      tcu: 4,
      x: 0x01,
      y: 249,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xA8;

    memory[0x799D] = 95;
    memory[0x8000] = OpCode.ldyAbsoluteX;
    memory[0x8001] = 0xF5;
    memory[0x8002] = 0x78;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldyAbsoluteX,
      tcu: 5,
      x: 0xA8,
      y: 95,
      p: 0x20,
      pc: 0x8003,
    );
  });
}

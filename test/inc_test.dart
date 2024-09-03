import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('INC Zero Page', () {
    cpu.restart();

    memory[0x0028] = 234;
    memory[0x8000] = OpCode.incZeroPage;
    memory[0x8001] = 0x28;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incZeroPage,
      tcu: 5,
      p: 0xA0,
      pc: 0x8002,
      memory: [(0x0028, 235)],
    );
  });

  test('INC Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x2A;

    memory[0x0032] = 37;
    memory[0x8000] = OpCode.incZeroPageX;
    memory[0x8001] = 0x08;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incZeroPageX,
      x: 0x2A,
      tcu: 6,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0032, 38)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xD2;

    memory[0x00AD] = 15;
    memory[0x8000] = OpCode.incZeroPageX;
    memory[0x8001] = 0xDB;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incZeroPageX,
      x: 0xD2,
      tcu: 6,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00AD, 16)],
    );
  });

  test('INC Absolute', () {
    cpu.restart();

    memory[0x3C5E] = 136;
    memory[0x8000] = OpCode.incAbsolute;
    memory[0x8001] = 0x5E;
    memory[0x8002] = 0x3C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incAbsolute,
      tcu: 6,
      p: 0xA0,
      pc: 0x8003,
      memory: [(0x3C5E, 137)],
    );
  });

  test('INC Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x73;

    memory[0x5AEA] = 23;
    memory[0x8000] = OpCode.incAbsoluteX;
    memory[0x8001] = 0x77;
    memory[0x8002] = 0x5A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incAbsoluteX,
      tcu: 7,
      x: 0x73,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x5AEA, 24)],
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xE2;

    memory[0x6DBB] = 173;
    memory[0x8000] = OpCode.incAbsoluteX;
    memory[0x8001] = 0xD9;
    memory[0x8002] = 0x6C;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.incAbsoluteX,
      tcu: 7,
      x: 0xE2,
      p: 0xA0,
      pc: 0x8003,
      memory: [(0x6DBB, 174)],
    );
  });
}

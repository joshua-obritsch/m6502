import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('LDX Immediate', () {
    cpu.restart();

    memory[0x8000] = OpCode.ldxImmediate;
    memory[0x8001] = 34;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxImmediate,
      tcu: 2,
      x: 34,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('LDX Zero Page', () {
    cpu.restart();

    memory[0x0097] = 235;
    memory[0x8000] = OpCode.ldxZeroPage;
    memory[0x8001] = 0x97;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxZeroPage,
      tcu: 3,
      x: 235,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('LDX Zero Page Y', () {
    // Without wrapping
    cpu.restart();
    cpu.y = 0x7C;

    memory[0x00F3] = 37;
    memory[0x8000] = OpCode.ldxZeroPageY;
    memory[0x8001] = 0x77;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxZeroPageY,
      tcu: 4,
      x: 37,
      y: 0x7C,
      p: 0x20,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.y = 0xCB;

    memory[0x0066] = 241;
    memory[0x8000] = OpCode.ldxZeroPageY;
    memory[0x8001] = 0x9B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxZeroPageY,
      tcu: 4,
      x: 241,
      y: 0xCB,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('LDX Absolute', () {
    cpu.restart();

    memory[0x5AC5] = 46;
    memory[0x8000] = OpCode.ldxAbsolute;
    memory[0x8001] = 0xC5;
    memory[0x8002] = 0x5A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxAbsolute,
      tcu: 4,
      x: 46,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('LDX Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.y = 0x38;

    memory[0x65AC] = 132;
    memory[0x8000] = OpCode.ldxAbsoluteY;
    memory[0x8001] = 0x74;
    memory[0x8002] = 0x65;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxAbsoluteY,
      tcu: 4,
      x: 132,
      y: 0x38,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.y = 0xD9;

    memory[0x6CCC] = 126;
    memory[0x8000] = OpCode.ldxAbsoluteY;
    memory[0x8001] = 0xF3;
    memory[0x8002] = 0x6B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldxAbsoluteY,
      tcu: 5,
      x: 126,
      y: 0xD9,
      p: 0x20,
      pc: 0x8003,
    );
  });
}

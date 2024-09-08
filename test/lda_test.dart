import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('LDA Immediate', () {
    cpu.restart();

    memory[0x8000] = OpCode.ldaImmediate;
    memory[0x8001] = 94;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaImmediate,
      tcu: 2,
      a: 94,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('LDA Zero Page', () {
    cpu.restart();

    memory[0x00F0] = 198;
    memory[0x8000] = OpCode.ldaZeroPage;
    memory[0x8001] = 0xF0;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaZeroPage,
      tcu: 3,
      a: 198,
      p: 0xA0,
      pc: 0x8002,
    );
  });

  test('LDA Zero Page X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x17;

    memory[0x008D] = 135;
    memory[0x8000] = OpCode.ldaZeroPageX;
    memory[0x8001] = 0x76;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaZeroPageX,
      tcu: 4,
      a: 135,
      x: 0x17,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xBA;

    memory[0x00B7] = 70;
    memory[0x8000] = OpCode.ldaZeroPageX;
    memory[0x8001] = 0xFD;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaZeroPageX,
      tcu: 4,
      a: 70,
      x: 0xBA,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('LDA Absolute', () {
    cpu.restart();

    memory[0x7485] = 17;
    memory[0x8000] = OpCode.ldaAbsolute;
    memory[0x8001] = 0x85;
    memory[0x8002] = 0x74;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaAbsolute,
      tcu: 4,
      a: 17,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('LDA Absolute X', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.x = 0x29;

    memory[0x6F34] = 11;
    memory[0x8000] = OpCode.ldaAbsoluteX;
    memory[0x8001] = 0x0B;
    memory[0x8002] = 0x6F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaAbsoluteX,
      tcu: 4,
      a: 11,
      x: 0x29,
      p: 0x20,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.x = 0xD4;

    memory[0x66B1] = 187;
    memory[0x8000] = OpCode.ldaAbsoluteX;
    memory[0x8001] = 0xDD;
    memory[0x8002] = 0x65;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaAbsoluteX,
      tcu: 5,
      a: 187,
      x: 0xD4,
      p: 0xA0,
      pc: 0x8003,
    );
  });

  test('LDA Absolute Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.y = 0x52;

    memory[0x115F] = 179;
    memory[0x8000] = OpCode.ldaAbsoluteY;
    memory[0x8001] = 0x0D;
    memory[0x8002] = 0x11;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaAbsoluteY,
      tcu: 4,
      a: 179,
      y: 0x52,
      p: 0xA0,
      pc: 0x8003,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.y = 0x86;

    memory[0x6941] = 60;
    memory[0x8000] = OpCode.ldaAbsoluteY;
    memory[0x8001] = 0xBB;
    memory[0x8002] = 0x68;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaAbsoluteY,
      tcu: 5,
      a: 60,
      y: 0x86,
      p: 0x20,
      pc: 0x8003,
    );
  });

  test('LDA Indirect X', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 0x25;

    memory[0x004F] = 0x4E;
    memory[0x0050] = 0x4F;
    memory[0x4F4E] = 143;
    memory[0x8000] = OpCode.ldaIndirectX;
    memory[0x8001] = 0x2A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaIndirectX,
      tcu: 6,
      a: 143,
      x: 0x25,
      p: 0xA0,
      pc: 0x8002,
    );

    // With wrapping
    cpu.restart();
    cpu.x = 0xF1;

    memory[0x00C8] = 0x12;
    memory[0x00C9] = 0x1F;
    memory[0x1F12] = 114;
    memory[0x8000] = OpCode.ldaIndirectX;
    memory[0x8001] = 0xD7;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaIndirectX,
      tcu: 6,
      a: 114,
      x: 0xF1,
      p: 0x20,
      pc: 0x8002,
    );
  });

  test('LDA Indirect Y', () {
    // Without page boundary crossing
    cpu.restart();
    cpu.y = 0x6E;

    memory[0x007F] = 0x24;
    memory[0x0080] = 0x4C;
    memory[0x4C92] = 209;
    memory[0x8000] = OpCode.ldaIndirectY;
    memory[0x8001] = 0x7F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaIndirectY,
      tcu: 5,
      a: 209,
      y: 0x6E,
      p: 0xA0,
      pc: 0x8002,
    );

    // With page boundary crossing
    cpu.restart();
    cpu.y = 0xD0;

    memory[0x00BF] = 0xAA;
    memory[0x00C0] = 0x59;
    memory[0x5A7A] = 223;
    memory[0x8000] = OpCode.ldaIndirectY;
    memory[0x8001] = 0xBF;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.ldaIndirectY,
      tcu: 6,
      a: 223,
      y: 0xD0,
      p: 0xA0,
      pc: 0x8002,
    );
  });
}

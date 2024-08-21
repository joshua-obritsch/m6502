import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BVC Relative', () {
    // With fall-through
    cpu.restart();
    cpu.v = true;

    memory[0x8000] = OpCode.bvcRelative;
    memory[0x8001] = 0xD4;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvcRelative,
      tcu: 2,
      p: 0x60,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.v = false;

    memory[0x8000] = OpCode.bvcRelative;
    memory[0x8001] = 0x6B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvcRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x806D,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.v = false;

    memory[0x80F0] = OpCode.bvcRelative;
    memory[0x80F1] = 0x8E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvcRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x8080,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.v = false;

    memory[0x80F0] = OpCode.bvcRelative;
    memory[0x80F1] = 0x14;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvcRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x8106,
    );

    // With backward wrapping
    cpu.restart();
    cpu.v = false;

    memory[0x8000] = OpCode.bvcRelative;
    memory[0x8001] = 0xDD;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvcRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x7FDF,
    );
  });
}

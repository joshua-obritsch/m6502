import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BCS Relative', () {
    // With fall-through
    cpu.restart();
    cpu.c = false;

    memory[0x8000] = OpCode.bcsRelative;
    memory[0x8001] = 0x07;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bcsRelative,
      tcu: 2,
      p: 0x20,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.c = true;

    memory[0x8000] = OpCode.bcsRelative;
    memory[0x8001] = 0x11;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bcsRelative,
      tcu: 3,
      p: 0x21,
      pc: 0x8013,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.c = true;

    memory[0x80F0] = OpCode.bcsRelative;
    memory[0x80F1] = 0xDE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bcsRelative,
      tcu: 3,
      p: 0x21,
      pc: 0x80D0,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.c = true;

    memory[0x80F0] = OpCode.bcsRelative;
    memory[0x80F1] = 0x44;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bcsRelative,
      tcu: 4,
      p: 0x21,
      pc: 0x8136,
    );

    // With backward wrapping
    cpu.restart();
    cpu.c = true;

    memory[0x8000] = OpCode.bcsRelative;
    memory[0x8001] = 0xA5;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bcsRelative,
      tcu: 4,
      p: 0x21,
      pc: 0x7FA7,
    );
  });
}

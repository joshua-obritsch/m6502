import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BEQ Relative', () {
    // With fall-through
    cpu.restart();
    cpu.z = false;

    memory[0x8000] = OpCode.beqRelative;
    memory[0x8001] = 0x3A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.beqRelative,
      tcu: 2,
      p: 0x20,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.z = true;

    memory[0x8000] = OpCode.beqRelative;
    memory[0x8001] = 0x3B;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.beqRelative,
      tcu: 3,
      p: 0x22,
      pc: 0x803D,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.z = true;

    memory[0x80F0] = OpCode.beqRelative;
    memory[0x80F1] = 0xBE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.beqRelative,
      tcu: 3,
      p: 0x22,
      pc: 0x80B0,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.z = true;

    memory[0x80F0] = OpCode.beqRelative;
    memory[0x80F1] = 0x7E;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.beqRelative,
      tcu: 4,
      p: 0x22,
      pc: 0x8170,
    );

    // With backward wrapping
    cpu.restart();
    cpu.z = true;

    memory[0x8000] = OpCode.beqRelative;
    memory[0x8001] = 0x92;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.beqRelative,
      tcu: 4,
      p: 0x22,
      pc: 0x7F94,
    );
  });
}

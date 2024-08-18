import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BNE Relative', () {
    // With fall-through
    cpu.restart();
    cpu.z = true;

    memory[0x8000] = OpCode.bneRelative;
    memory[0x8001] = 0xFE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bneRelative,
      tcu: 2,
      p: 0x22,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.z = false;

    memory[0x8000] = OpCode.bneRelative;
    memory[0x8001] = 0x0D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bneRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x800F,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.z = false;

    memory[0x80F0] = OpCode.bneRelative;
    memory[0x80F1] = 0xAB;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bneRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x809D,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.z = false;

    memory[0x80F0] = OpCode.bneRelative;
    memory[0x80F1] = 0x1A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bneRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x810C,
    );

    // With backward wrapping
    cpu.restart();
    cpu.z = false;

    memory[0x8000] = OpCode.bneRelative;
    memory[0x8001] = 0x83;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bneRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x7F85,
    );
  });
}

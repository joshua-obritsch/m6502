import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BVS Relative', () {
    // With fall-through
    cpu.restart();
    cpu.v = false;

    memory[0x8000] = OpCode.bvsRelative;
    memory[0x8001] = 0xE6;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvsRelative,
      tcu: 2,
      p: 0x20,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.v = true;

    memory[0x8000] = OpCode.bvsRelative;
    memory[0x8001] = 0x59;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvsRelative,
      tcu: 3,
      p: 0x60,
      pc: 0x805B,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.v = true;

    memory[0x80F0] = OpCode.bvsRelative;
    memory[0x80F1] = 0xC0;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvsRelative,
      tcu: 3,
      p: 0x60,
      pc: 0x80B2,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.v = true;

    memory[0x80F0] = OpCode.bvsRelative;
    memory[0x80F1] = 0x54;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvsRelative,
      tcu: 4,
      p: 0x60,
      pc: 0x8146,
    );

    // With backward wrapping
    cpu.restart();
    cpu.v = true;

    memory[0x8000] = OpCode.bvsRelative;
    memory[0x8001] = 0x88;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bvsRelative,
      tcu: 4,
      p: 0x60,
      pc: 0x7F8A,
    );
  });
}

import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BPL Relative', () {
    // With fall-through
    cpu.restart();
    cpu.n = true;

    memory[0x8000] = OpCode.bplRelative;
    memory[0x8001] = 0xDE;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bplRelative,
      tcu: 2,
      p: 0xA0,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.n = false;

    memory[0x8000] = OpCode.bplRelative;
    memory[0x8001] = 0x24;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bplRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x8026,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.n = false;

    memory[0x80F0] = OpCode.bplRelative;
    memory[0x80F1] = 0xA0;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bplRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x8092,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.n = false;

    memory[0x80F0] = OpCode.bplRelative;
    memory[0x80F1] = 0x7A;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bplRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x816C,
    );

    // With backward wrapping
    cpu.restart();
    cpu.n = false;

    memory[0x8000] = OpCode.bplRelative;
    memory[0x8001] = 0xE1;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bplRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x7FE3,
    );
  });
}

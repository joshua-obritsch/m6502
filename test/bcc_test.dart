import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BCC Relative', () {
    // With fall-through
    cpu.restart();
    cpu.c = true;

    memory[0x8000] = OpCode.bccRelative;
    memory[0x8001] = 0x52;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bccRelative,
      tcu: 2,
      p: 0x21,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.c = false;

    memory[0x8000] = OpCode.bccRelative;
    memory[0x8001] = 0x3F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bccRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x8041,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.c = false;

    memory[0x80F0] = OpCode.bccRelative;
    memory[0x80F1] = 0x98;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bccRelative,
      tcu: 3,
      p: 0x20,
      pc: 0x808A,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.c = false;

    memory[0x80F0] = OpCode.bccRelative;
    memory[0x80F1] = 0x61;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bccRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x8153,
    );

    // With backward wrapping
    cpu.restart();
    cpu.c = false;

    memory[0x8000] = OpCode.bccRelative;
    memory[0x8001] = 0xC3;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bccRelative,
      tcu: 4,
      p: 0x20,
      pc: 0x7FC5,
    );
  });
}

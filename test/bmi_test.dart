import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('BMI Relative', () {
    // With fall-through
    cpu.restart();
    cpu.n = false;

    memory[0x8000] = OpCode.bmiRelative;
    memory[0x8001] = 0xFC;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bmiRelative,
      tcu: 2,
      p: 0x20,
      pc: 0x8002,
    );

    // With forward branching
    cpu.restart();
    cpu.n = true;

    memory[0x8000] = OpCode.bmiRelative;
    memory[0x8001] = 0x2D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bmiRelative,
      tcu: 3,
      p: 0xA0,
      pc: 0x802F,
    );

    // With backward branching
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.n = true;

    memory[0x80F0] = OpCode.bmiRelative;
    memory[0x80F1] = 0xEA;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bmiRelative,
      tcu: 3,
      p: 0xA0,
      pc: 0x80DC,
    );

    // With forward wrapping
    cpu.restart();
    cpu.pc = 0x80F0;
    cpu.n = true;

    memory[0x80F0] = OpCode.bmiRelative;
    memory[0x80F1] = 0x5F;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bmiRelative,
      tcu: 4,
      p: 0xA0,
      pc: 0x8151,
    );

    // With backward wrapping
    cpu.restart();
    cpu.n = true;

    memory[0x8000] = OpCode.bmiRelative;
    memory[0x8001] = 0xFA;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.bmiRelative,
      tcu: 4,
      p: 0xA0,
      pc: 0x7FFC,
    );
  });
}

import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('TXA Implied', () {
    cpu.restart();
    cpu.x = 120;

    memory[0x8000] = OpCode.txaImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.txaImplied,
      tcu: 2,
      a: 120,
      x: 120,
      p: 0x20,
      pc: 0x8001,
    );
  });
}

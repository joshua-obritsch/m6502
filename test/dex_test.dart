import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('DEX Implied', () {
    cpu.restart();
    cpu.x = 0;

    memory[0x8000] = OpCode.dexImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.dexImplied,
      tcu: 2,
      x: 255,
      p: 0xA0,
      pc: 0x8001,
    );
  });
}

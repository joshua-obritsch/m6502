import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('CLD Implied', () {
    cpu.restart();
    cpu.d = true;

    memory[0x8000] = OpCode.cldImplied;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cldImplied,
      tcu: 2,
      p: 0x20,
      pc: 0x8001,
    );
  });
}

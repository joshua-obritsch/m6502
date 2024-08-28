import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('CPX Immediate', () {
    cpu.restart();
    cpu.x = 112;

    memory[0x8000] = OpCode.cpxImmediate;
    memory[0x8001] = 112;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpxImmediate,
      x: 112,
      tcu: 2,
      p: 0x23,
      pc: 0x8002,
    );
  });

  test('CPX Zero Page', () {
    cpu.restart();
    cpu.x = 246;

    memory[0x0072] = 200;
    memory[0x8000] = OpCode.cpxZeroPage;
    memory[0x8001] = 0x72;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpxZeroPage,
      x: 246,
      tcu: 3,
      p: 0x21,
      pc: 0x8002,
    );
  });

  test('CPX Absolute', () {
    cpu.restart();
    cpu.x = 80;

    memory[0x5DEA] = 227;
    memory[0x8000] = OpCode.cpxAbsolute;
    memory[0x8001] = 0xEA;
    memory[0x8002] = 0x5D;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.cpxAbsolute,
      tcu: 4,
      x: 80,
      p: 0x20,
      pc: 0x8003,
    );
  });
}

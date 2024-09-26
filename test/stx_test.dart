import 'package:m6502/cpu.dart';
import 'package:m6502/op_codes.dart';
import 'package:test/test.dart';

import 'extensions.dart';

void main() {
  final cpu = Cpu();
  final memory = cpu.memory;

  memory[0xFFFC] = 0x00;
  memory[0xFFFD] = 0x80;

  test('STX Zero Page', () {
    cpu.restart();
    cpu.x = 102;

    memory[0x8000] = OpCode.stxZeroPage;
    memory[0x8001] = 0x12;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.stxZeroPage,
      tcu: 3,
      x: 102,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0012, 102)],
    );
  });

  test('STX Zero Page Y', () {
    // Without wrapping
    cpu.restart();
    cpu.x = 212;
    cpu.y = 0x6B;

    memory[0x8000] = OpCode.stxZeroPageY;
    memory[0x8001] = 0x53;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.stxZeroPageY,
      tcu: 4,
      x: 212,
      y: 0x6B,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x00BE, 212)],
    );

    // With wrapping
    cpu.restart();
    cpu.x = 89;
    cpu.y = 0x86;

    memory[0x8000] = OpCode.stxZeroPageY;
    memory[0x8001] = 0xBF;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.stxZeroPageY,
      tcu: 4,
      x: 89,
      y: 0x86,
      p: 0x20,
      pc: 0x8002,
      memory: [(0x0045, 89)],
    );
  });

  test('STX Absolute', () {
    cpu.restart();
    cpu.x = 169;

    memory[0x8000] = OpCode.stxAbsolute;
    memory[0x8001] = 0x64;
    memory[0x8002] = 0x68;

    cpu.fetch();
    cpu.execute();
    cpu.expect(
      ir: OpCode.stxAbsolute,
      tcu: 4,
      x: 169,
      p: 0x20,
      pc: 0x8003,
      memory: [(0x6864, 169)],
    );
  });
}

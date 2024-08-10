import 'package:m6502/cpu.dart';
import 'package:test/test.dart' as test;

extension CpuExt on Cpu {
  void expect({
    int? ir,
    int? tcu,
    int? a,
    int? x,
    int? y,
    int? p,
    int? pc,
    int? s,
    List<(int, int)> memory = const [],
  }) {
    test.expect(
      this.ir,
      ir ?? 0,
      reason: _mismatch('Instruction register (IR)', ir ?? 0, this.ir),
    );
    test.expect(
      this.tcu,
      tcu ?? 0,
      reason: _mismatch('Timing control unit (TCU)', tcu ?? 0, this.tcu),
    );
    test.expect(
      this.a,
      a ?? 0,
      reason: _mismatch('Accumulator register (A)', a ?? 0, this.a),
    );
    test.expect(
      this.x,
      x ?? 0,
      reason: _mismatch('Index register (X)', x ?? 0, this.x),
    );
    test.expect(
      this.y,
      y ?? 0,
      reason: _mismatch('Index register (Y)', y ?? 0, this.y),
    );
    test.expect(
      this.p,
      p ?? 0,
      reason: _mismatch('Processor status register (P)', p ?? 0, this.p),
    );
    test.expect(
      this.pc,
      pc ?? 0,
      reason: _mismatch('Program counter register (PC)', pc ?? 0, this.pc, 4),
    );
    test.expect(
      this.s,
      s ?? 0,
      reason: _mismatch('Stack pointer register (S)', s ?? 0, this.s),
    );

    for (final pair in memory) {
      final (address, value) = pair;

      test.expect(
        this.memory[address],
        value,
        reason: //
            'Memory (0x${address.toHex(4)}) mismatch: '
            '0x${value.toHex()} != 0x${this.memory[address].toHex()}.'
            '\n\n${_state()}',
      );
    }
  }

  void restart() {
    reset();
    clear(0x0000, 0xFFFA);
  }

  String _state() => //
      'Instruction Register     (IR):   ${ir.toHex()}\n'
      'Timing Control Unit     (TCU):   ${tcu.toHex()}\n'
      'Accumulator Register      (A):   ${a.toHex()}\n'
      'Index Register X          (X):   ${x.toHex()}\n'
      'Index Register Y          (Y):   ${y.toHex()}\n'
      'Processor Status Register (P):   ${p.toHex()}\n'
      'Program Counter Register (PC): ${pc.toHex(4)}\n'
      'Stack Pointer Register    (S):   ${s.toHex()}';

  String _mismatch(String title, int expected, int actual, [int width = 2]) =>
      '\n$title mismatch: 0x${expected.toHex(width)} != 0x${actual.toHex(width)}.'
      '\n\n${_state()}';
}

extension on int {
  String toHex([int width = 2]) =>
      toRadixString(16).padLeft(width, '0').toUpperCase();
}

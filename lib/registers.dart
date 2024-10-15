mixin Registers {
  /// Represents the 8-bit instruction register (IR).
  int _ir = 0;

  /// Represents the 8-bit accumulator register (A).
  int _a = 0;

  /// Represents the 8-bit index register (X).
  int _x = 0;

  /// Represents the 8-bit index register (Y).
  int _y = 0;

  /// Represents the 8-bit processor status register (P).
  int _p = 0x20;

  /// Represents the 16-bit program counter register (PC).
  int _pc = 0;

  /// Represents the 8-bit stack pointer register (S).
  int _s = 0;

  /// Gets the instruction register (IR).
  int get ir => _ir;

  /// Gets the accumulator register (A).
  int get a => _a;

  /// Gets the index register (X).
  int get x => _x;

  /// Gets the index register (Y).
  int get y => _y;

  /// Gets the processor status register (P).
  int get p => _p;

  /// Gets the program counter register (PC).
  int get pc => _pc;

  /// Gets the high byte of the program counter register (PCH).
  int get pch => _pc >> 8;

  /// Gets the low byte of the program counter register (PCL).
  int get pcl => _pc & 0xFF;

  /// Gets the stack pointer register (S).
  int get s => _s;

  /// Sets the instruction register (IR).
  set ir(int value) => _ir = value & 0xFF;

  /// Sets the accumulator register (A).
  set a(int value) => _a = value & 0xFF;

  /// Sets the index register (X).
  set x(int value) => _x = value & 0xFF;

  /// Sets the index register (Y).
  set y(int value) => _y = value & 0xFF;

  /// Sets the processor status register (P).
  set p(int value) => _p = value & 0xFF;

  /// Sets the program counter register (PC).
  set pc(int value) => _pc = value & 0xFFFF;

  /// Sets the high byte of the program counter register (PCH).
  set pch(int value) => _pc = (value & 0xFF) << 8 | _pc & 0xFF;

  /// Sets the low byte of the program counter register (PCL).
  set pcl(int value) => _pc = value & 0xFF | _pc & 0xFF00;

  /// Sets the stack pointer register (S).
  set s(int value) => _s = value & 0xFF;
}

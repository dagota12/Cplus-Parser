# C-like Language Parser

A simple C-like language parser built using **Flex** (lexical analyzer) and **Bison** (parser generator). This project demonstrates syntax analysis for a subset of C language constructs including variable declarations, assignments, conditional statements, and loops.

## Features

- **Lexical Analysis**: Tokenizes source code into meaningful symbols
- **Syntax Parsing**: Validates the grammatical structure of C-like programs
- **Operator Support**: Arithmetic (`+`, `-`, `*`, `/`) and comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`)
- **Control Structures**: 
  - `if` and `if-else` statements
  - `while` loops
- **Variable Declarations**: Supports `int`, `float`, and `return` keywords
- **Expression Evaluation**: Handles complex arithmetic and boolean expressions
- **File or Interactive Input**: Parse from a file or enter code interactively

## Prerequisites

Before building this project, ensure you have the following installed:

- **GCC** (GNU Compiler Collection)
- **Flex** (Fast Lexical Analyzer Generator)
- **Bison** (GNU Parser Generator)

### Installation on Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install build-essential flex bison
```

### Installation on macOS

```bash
brew install flex bison gcc
```

### Installation on Fedora/RHEL

```bash
sudo dnf install gcc flex bison
```

## Building the Parser

1. Clone the repository:
```bash
git clone https://github.com/dagota12/Cplus-Parser.git
cd Cplus-Parser
```

2. Build the compiler:
```bash
make
```

This will:
- Generate the lexer (`lex.yy.c`) from `lexer.l`
- Generate the parser (`y.tab.c` and `y.tab.h`) from `parser.y`
- Compile everything into an executable called `compiler`

3. Clean build artifacts (optional):
```bash
make clean
```

## Usage

### Parse a File

```bash
./compiler <filename>
```

Example:
```bash
./compiler test.c
```

### Interactive Mode

Run the compiler without arguments to enter code interactively:
```bash
./compiler
```

Then type your C-like code and press `Ctrl+D` (Unix/Linux/macOS) or `Ctrl+Z` (Windows) to finish input.

## Example Programs

### Valid Program (`test.c`)

```c
int x;
int y;
float z;

x = 10 + 5 * 2.5;
y = x - 3;

if (x > y) {
    z = x + y;
} else {
    z = 0;
}

while (y >= 0) {
    y = y - 1;
}
```

**Output:**
```
Declaration: x
Declaration: y
Declaration: z
Assignment to x
Assignment to y
Assignment to z
...
Parsing successful: Valid syntax!
```

### Invalid Program (`bad.c`)

```c
int x;
x = 5 + ; 
if (x > 0 {
    x = 1;
}
```

**Output:**
```
Syntax error: syntax error
Parsing failed: Invalid syntax.
```

## Project Structure

```
.
├── lexer.l          # Flex lexical analyzer specification
├── parser.y         # Bison parser grammar rules
├── Makefile         # Build configuration
├── test.c           # Valid test program
├── bad.c            # Invalid test program (for error testing)
├── .gitignore       # Git ignore rules
└── README.md        # This file
```

### File Descriptions

- **`lexer.l`**: Defines tokens and regular expressions for lexical analysis (keywords, identifiers, numbers, operators, etc.)
- **`parser.y`**: Defines the grammar rules for parsing C-like syntax and includes the main function
- **`Makefile`**: Automates the build process using Flex and Bison
- **`test.c`**: Sample valid program to test the parser
- **`bad.c`**: Sample invalid program to test error detection

## Supported Language Constructs

### Keywords
- Variable types: `int`, `float`
- Statement keywords: `return`
- Control flow: `if`, `else`, `while`

### Operators
- Arithmetic: `+`, `-`, `*`, `/`
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Assignment: `=`

### Syntax Elements
- Variable declarations
- Assignments
- Expressions (with proper precedence)
- If-else statements
- While loops
- Code blocks with `{` and `}`

## How It Works

1. **Lexical Analysis (Flex)**: The `lexer.l` file defines patterns to recognize tokens like keywords, identifiers, numbers, and operators
2. **Parsing (Bison)**: The `parser.y` file defines grammar rules that describe valid program structures
3. **Syntax Validation**: The parser checks if the input follows the defined grammar rules
4. **Output**: The parser prints recognized constructs and reports whether the syntax is valid or invalid

## Limitations

- This is a **syntax checker only** - it does not execute code or perform semantic analysis
- No type checking or enforcement (e.g., assigning float values to int variables is accepted)
- Limited to a subset of C language features
- No scope resolution
- No optimization or code generation

## Troubleshooting

### Build Errors

If you encounter build errors:
- Ensure Flex and Bison are properly installed
- Check that you're using compatible versions of GCC

### Shift/Reduce Conflicts

The parser may show warnings about shift/reduce conflicts during compilation. These are expected and don't affect basic functionality.



![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Prime Quine

This is an entry into the [TTSKY26A Demoscene
Competition](https://tinytapeout.com/competitions/demoscene-ttsky26a-announce/)
in the 2 tile category.

A quine is a program which takes no input and outputs a copy of its own source
code. As far as I know, this has never been done before in silicon. Every
software quine generally benefits from a mountain of software layers which
amount to additional implicit inputs. They do not need to consider the concept
of a font and interface signals are abstracted. This 1x2 tile circuit encodes a
full ASCII font and the logic required to output its HDL source over VGA
signaling:

![VGA output vs Verilog source. Find the Easter Egg](docs/vga_vs_verilog.png)

[Read the documentation](docs/info.md) to learn how this works and how to use
the circuit.

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper
than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

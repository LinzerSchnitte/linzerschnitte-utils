linzerschnitte-utils
====================

A collection of examples and test apps for the LinzerSchnitte project.

## pd

### miditest.pd

A puredata patch that makes it easy to generate midi notes, including functions for:

- sending notes in periodic intervals
- cycling through all possible midi notes to facilitate finding out a LinzerSchnitte's frequency
- a simple interface for an Akai LPD20 using default note mappings: pads 1-8 activate midi notes 0-8, the first dial controls pulse length

## linzertone

An alternative to using linzerschnitte-server. The project is written in [clojure](http://clojure.org) and uses [overtone](http://overtone.gihub.io), which itself uses the [supercollider](http://supercollider.sourceforge.net) sound synthesis server. The idea is to use this to generate the necessary frequencies directly, and to develop more complex tools and compositions.

For those unfamiliar with overtone/clojure, the "getting started" guide on the overtone site is a good intro.

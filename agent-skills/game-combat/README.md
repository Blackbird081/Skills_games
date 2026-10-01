# Game Combat Skills

How to make character combat animation look right: attacks, skills and whole move sets that read like Diablo IV, Baldur's Gate 3 or Elden Ring, with arms, wrists and hands that never stretch, lock, wring or break. These skills come from real rounds of building, measuring and blind-judging a knight's sword strikes and an archer's bow shots in a Three.js action RPG.

Each rule is a number, every number has a test, and every critic's claim is checked against full-resolution frames before anything changes.

## Choose the right skill

| Need | Start with |
| --- | --- |
| Build, fix or review attacks and move sets to a written standard; fix "the arms look stretched or weird"; score animations or get them to 8 out of 10 | [`game-dev-combat-animation`](game-dev-combat-animation/SKILL.md) |

## What's inside `game-dev-combat-animation`

- **The loop.** Write the standard, capture a baseline, design keys from anatomy, measure, test, capture both cameras, run blind critics and a blind A/B against the last release, verify every claim, ship, then show videos.
- **Arm and hand rules, with numbers.**

  | Rule | Limit |
  | --- | --- |
  | Elbow flexion | 10–152° |
  | Striking or drawing arm, middle 80% of the move | at least 20° of bend |
  | Wrist | bend ≤ 50°, roll ≤ 45° |
  | Forearm and upper-arm twist | ≤ 52° each |
  | Arm raise | ≤ 105° |
  | Skin, worst 1% of each arm region on the real mesh | stretch ≤ 2×, crush ≤ 3× |
  | Hands | always in a pose: fist, hook or relaxed |

- **Techniques:**
  - hands that ride their shoulders and arc between keys;
  - aim the forearm, not the wrist;
  - tip-up chambers;
  - follow-throughs that keep moving;
  - a bow anchor under the jaw with the hips side-on.
- **Traps that each cost a round.**
  - Bone-axis conventions, such as a head bone that is +Y forward and +Z down.
  - Tests that read the same wrong convention as the code.
  - Failures masked by the first assertion in a loop.
  - Poses that read differently on two cameras.
  - Critics misreading thumbnails.
  - Capture runs killed by a reload.
- **Review protocol:** two blind critics (the lower score counts), a blind A/B with identical titles, critic and judge prompt templates, and side-by-side review videos.

## Scripts at a glance

- `scripts/install.sh` copies the tools into a checkout's `.dream-loop/moves/`.
- `keydesign.mjs` turns upper-arm, forearm and blade intents into a hand target and checks raise, flex, blade angle and reach.
- `armcheck.mjs` checks joint ranges and skin stretch and crush per arm region on every frame.
- `at.mjs`, `knight-measure.mjs`, `anchor.mjs`, `drawfit.mjs` and `face.mjs` probe the fist and blade, clearances, the bow anchor and the face landmarks.
- `setup.js`, `play.js`, `shot.js` and `host.html` capture the Characters page, stepped in-game frames, and 2880 × 1800 stills.
- `msheet.py`, `psheet.py`, `ab-pack.py`, `vidcompose.py` and `encode.swift` build judge sheets, blind A/B sets and side-by-side videos.

The tools import the game's own modules (a HumGen rig and baker). Project specifics are in `references/thornvigil.md`. On another rig, re-derive the arm lengths, the shoulders and every bone-local axis from mesh landmarks before reusing a number.

Pairs well with [`design-action-combat`](../game-development/design-action-combat/SKILL.md) for timing and contact, and with [`workflow-score-to-target`](../workflow/workflow-score-to-target/SKILL.md) and [`workflow-ship-change`](../workflow/workflow-ship-change/SKILL.md).

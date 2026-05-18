# Revision history for Win32::Pipe

## 0.027 [2026-05-18]

- Move repository to the perl-libwin32 GitHub organization (#3)
- Fix off-by-one write past the end of the error-message buffer
- Add a test suite covering module load, server-pipe construction,
  and a client/server round-trip

## 0.026 [unreleased]

- Correct szError type from `LPSTR[]` to `CHAR[]` by Shaun Lowry (#2)
- Add const to string-literal parameters in `Pipe.xs` to silence
  `-Wwrite-strings` warnings

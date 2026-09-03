#!/usr/bin/env python3
"""Run every assertion in tests/*.sql against build/warehouse.db.

An assertion is a SELECT that returns the OFFENDING rows. Zero rows returned = pass.
Seed files under data/ are checksum-verified first: if they changed, nothing runs.
"""
import hashlib, os, sqlite3, sys

ROOT  = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA  = os.path.join(ROOT, "data")
TESTS = os.path.join(ROOT, "tests")
DB    = os.path.join(ROOT, "build", "warehouse.db")

def verify_seed():
    bad = []
    for line in open(os.path.join(DATA, "CHECKSUMS.sha256")):
        want, fn = line.strip().split(None, 1)
        path = os.path.join(DATA, fn.lstrip("*").strip())
        if not os.path.exists(path):
            bad.append(f"{fn}: missing")
            continue
        if hashlib.sha256(open(path, "rb").read()).hexdigest() != want:
            bad.append(f"{fn}: modified")
    if bad:
        print("SEED FILES CHANGED - data/ is read-only and must not be edited:")
        for b in bad:
            print("  " + b)
        sys.exit(2)

def main():
    verify_seed()
    if not os.path.exists(DB):
        sys.exit("no build/warehouse.db - run python3 bin/build.py first")
    con = sqlite3.connect(DB)
    files = sorted(f for f in os.listdir(TESTS) if f.endswith(".sql"))
    failed = 0
    for fn in files:
        sql = open(os.path.join(TESTS, fn)).read()
        title = sql.splitlines()[0].lstrip("- ").strip() or fn
        try:
            rows = con.execute(sql).fetchall()
        except sqlite3.Error as e:
            print(f"ERROR {title:<58} {e}")
            failed += 1
            continue
        if rows:
            failed += 1
            print(f"FAIL  {title:<58} {len(rows):>8,} offending rows")
            for r in rows[:3]:
                print(f"        e.g. {r}")
        else:
            print(f"PASS  {title}")
    print(f"\n{len(files) - failed}/{len(files)} checks passing")
    sys.exit(1 if failed else 0)

if __name__ == "__main__":
    main()

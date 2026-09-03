# Handover notes

*From the contractor who built the current pipeline. Left the project in July 2026.*

---

Everything runs off the nine landing files in `data/`. They are dumps from the storefront
integrations and from the finance system; I never changed them, and neither should you — the
loader re-lands them on a schedule and any edit gets overwritten.

`models/` runs in filename order. `bin/build.py` loads the landing files and runs the models.
`bin/test.py` runs the checks in `tests/`.

Things I know are unfinished:

- The checks in `tests/` are the ones I wrote in an afternoon to stop obvious breakage. They are
  about **shape** — grain, orphans, nulls. I never got to checking the money.
- `dim_platform` is a stub.
- There is no incremental load. Everything is a full rebuild. At this volume it's fine.

Ops things worth knowing:

- The March loader outage was fixed by re-running the extract for the rest of the month. Nobody
  liked that fix but the pipeline was down for a day and we were behind.
- Finance stopped using the dashboard around April. They keep their own spreadsheet now. I asked
  why and got "the numbers don't feel right", which I couldn't do much with.

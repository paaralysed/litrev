from pathlib import Path
import os

p = Path("index.html")
t = p.read_text(encoding="utf-8")
t = t.replace("__LITREV_SUPABASE_URL__", os.environ["LITREV_SUPABASE_URL"])
t = t.replace("__LITREV_SUPABASE_ANON_KEY__", os.environ["LITREV_SUPABASE_ANON_KEY"])
p.write_text(t, encoding="utf-8")

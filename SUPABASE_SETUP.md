# LitRev Supabase + Vercel Setup

## 1) Create Supabase project
- Create a new project in Supabase.
- In **Authentication > Providers**, enable Email auth (and Google if wanted later).

## 2) Run database schema
- Open **SQL Editor** in Supabase.
- Paste `supabase_schema.sql` and run it.

## 3) Add frontend keys
In `index.html`, provide these globals before LitRev script runs (for example in Vercel-injected script block):

```html
<script>
  window.LITREV_SUPABASE_URL = "https://YOUR_PROJECT.supabase.co";
  window.LITREV_SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_PUBLIC_KEY";
</script>
```

Notes:
- The anon/public key is safe in client code.
- Never expose the service-role key in frontend HTML.

## 4) Vercel deployment notes
- Set environment variables in Vercel project settings:
  - `LITREV_SUPABASE_URL`
  - `LITREV_SUPABASE_ANON_KEY`
- If you use static HTML only, inject them into the page at build/deploy time.

## 5) Test checklist
- Sign up, sign in, sign out
- Reset password email
- Complete sessions in Flashcards/Context/Fill-in-Blank
- Refresh and verify stats/progress are retained
- Verify signed-out fallback still stores local progress

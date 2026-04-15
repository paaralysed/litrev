-- LitRev accounts schema (Supabase/Postgres)
create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.user_stats (
  user_id uuid primary key references auth.users(id) on delete cascade,
  xp_total integer not null default 0,
  streak_days integer not null default 0,
  sessions_completed integer not null default 0,
  last_session_date date,
  updated_at timestamptz not null default now()
);

create table if not exists public.user_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  mode text not null,
  category text not null,
  text_id text not null,
  item_id text not null,
  remembered_count integer not null default 0,
  forgot_count integer not null default 0,
  last_seen_at timestamptz not null default now(),
  primary key (user_id, mode, category, text_id, item_id)
);

create index if not exists idx_user_progress_user_mode on public.user_progress(user_id, mode);

alter table public.profiles enable row level security;
alter table public.user_stats enable row level security;
alter table public.user_progress enable row level security;

create policy "profiles_select_own" on public.profiles
for select to authenticated using (auth.uid() = user_id);

create policy "profiles_insert_own" on public.profiles
for insert to authenticated with check (auth.uid() = user_id);

create policy "profiles_update_own" on public.profiles
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "stats_select_own" on public.user_stats
for select to authenticated using (auth.uid() = user_id);

create policy "stats_insert_own" on public.user_stats
for insert to authenticated with check (auth.uid() = user_id);

create policy "stats_update_own" on public.user_stats
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "progress_select_own" on public.user_progress
for select to authenticated using (auth.uid() = user_id);

create policy "progress_insert_own" on public.user_progress
for insert to authenticated with check (auth.uid() = user_id);

create policy "progress_update_own" on public.user_progress
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

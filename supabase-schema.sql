-- Midnight Diary backend schema for Supabase/PostgreSQL
-- IMPORTANT: This starter schema is not yet a complete production security review.
-- Do not expose the service_role key in the browser. Configure RLS and test all policies
-- before storing sensitive diary content.

create extension if not exists pgcrypto;

create table if not exists public.diary_rooms (
  id uuid primary key default gen_random_uuid(),
  room_code_hash text not null,
  created_at timestamptz not null default now(),
  timezone text not null default 'Asia/Ho_Chi_Minh'
);

create table if not exists public.diary_members (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references public.diary_rooms(id) on delete cascade,
  display_name text not null,
  member_pin_hash text not null,
  created_at timestamptz not null default now(),
  unique(room_id, display_name)
);

create table if not exists public.diary_entries (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references public.diary_rooms(id) on delete cascade,
  member_id uuid not null references public.diary_members(id) on delete cascade,
  week_start date not null,
  title text not null default '',
  body text not null default '',
  updated_at timestamptz not null default now(),
  unique(member_id, week_start)
);

alter table public.diary_rooms enable row level security;
alter table public.diary_members enable row level security;
alter table public.diary_entries enable row level security;

-- Intentionally no direct anon/authenticated table policies are added here.
-- The application should use narrowly scoped Postgres RPC functions that:
-- 1) verify the shared room code and individual member PIN server-side,
-- 2) return only the caller's current-week draft before release,
-- 3) expose previous-week entries only after Monday 00:00 Asia/Ho_Chi_Minh,
-- 4) never accept a client-provided "unlocked" flag as authority,
-- 5) rate-limit PIN attempts and avoid returning hashes.
--
-- Do not treat a shared code alone as strong identity: each person should have
-- their own PIN/name, even if both use the same invitation link.

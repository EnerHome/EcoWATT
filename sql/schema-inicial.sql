-- Esquema orientativo para una futura integración con Supabase/PostgreSQL.
-- No se ejecuta desde la demo estática. Revisa y prueba las políticas antes de producción.

create table if not exists public.homes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  city text,
  latitude double precision,
  longitude double precision,
  tariff_pen_per_kwh numeric(10,5) not null default 0.65 check (tariff_pen_per_kwh >= 0),
  created_at timestamptz not null default now()
);

create table if not exists public.bills (
  id uuid primary key default gen_random_uuid(),
  home_id uuid not null references public.homes(id) on delete cascade,
  period_start date not null,
  period_end date,
  consumption_kwh numeric(12,3) not null check (consumption_kwh >= 0),
  total_amount_pen numeric(12,2) check (total_amount_pen is null or total_amount_pen >= 0),
  energy_charge_pen numeric(12,2) check (energy_charge_pen is null or energy_charge_pen >= 0),
  source text not null default 'manual',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.saving_goals (
  id uuid primary key default gen_random_uuid(),
  home_id uuid not null references public.homes(id) on delete cascade,
  target_kwh numeric(12,3) not null check (target_kwh > 0),
  period_start date not null,
  period_end date not null,
  created_at timestamptz not null default now()
);

create table if not exists public.appliances (
  id uuid primary key default gen_random_uuid(),
  home_id uuid not null references public.homes(id) on delete cascade,
  name text not null,
  rated_power_w numeric(10,2) not null check (rated_power_w > 0),
  hours_per_day numeric(5,2) not null default 1 check (hours_per_day between 0 and 24),
  days_per_month numeric(5,2) not null default 30 check (days_per_month between 0 and 31),
  created_at timestamptz not null default now()
);

alter table public.homes enable row level security;
alter table public.bills enable row level security;
alter table public.saving_goals enable row level security;
alter table public.appliances enable row level security;

-- La propiedad se valida por medio del hogar padre.
create policy "users manage own homes" on public.homes
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "users manage bills in own homes" on public.bills
  for all using (exists (
    select 1 from public.homes h where h.id = bills.home_id and h.user_id = auth.uid()
  )) with check (exists (
    select 1 from public.homes h where h.id = bills.home_id and h.user_id = auth.uid()
  ));

create policy "users manage goals in own homes" on public.saving_goals
  for all using (exists (
    select 1 from public.homes h where h.id = saving_goals.home_id and h.user_id = auth.uid()
  )) with check (exists (
    select 1 from public.homes h where h.id = saving_goals.home_id and h.user_id = auth.uid()
  ));

create policy "users manage appliances in own homes" on public.appliances
  for all using (exists (
    select 1 from public.homes h where h.id = appliances.home_id and h.user_id = auth.uid()
  )) with check (exists (
    select 1 from public.homes h where h.id = appliances.home_id and h.user_id = auth.uid()
  ));

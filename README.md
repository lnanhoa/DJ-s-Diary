# DJ's Diary — starter kit

## What's included
- `index.html`: responsive midnight-blue/purple diary dashboard preview.
- `supabase-schema.sql`: initial database tables for a Supabase backend.

## Important status
This is a **front-end preview + database starting point**, not a deployed website. The preview saves drafts only in the browser that opened it; it does not sync between devices and does not provide real access control. Do not enter real private diary content yet.

## Recommended online setup
1. Create a Supabase project: https://supabase.com/
2. Create a GitHub repository and upload the project files.
3. Deploy the front end with Vercel or Netlify: https://vercel.com/ or https://www.netlify.com/
4. Configure server-side database RPC functions and security policies before connecting the front end.
5. Use a shared invitation URL plus a separate PIN for each person. Never put a Supabase `service_role` key in browser code.
6. Set the release gate on the server to Monday 00:00 in `Asia/Ho_Chi_Minh`. The server must enforce it; a client-side timer or hidden panel is not security.

## Weekly rule
- Writing window: Monday through Sunday.
- Entries for the current week remain private to their author.
- Entries from the previous week become readable by both members at Monday 00:00 Vietnam time.
- If either person misses a week, the other person's entry should still unlock on schedule unless you explicitly choose a "both submitted" rule.

## What remains before launch
The secure RPC functions, PIN verification/rate limiting, deployment, environment variables, and end-to-end tests still need to be completed. This package does not create a public URL automatically because deployment requires accounts and project configuration.

## Requested behavior
- Display names: Danny and June.
- Product name: DJ's Diary.
- Missed days can be filled in later; entries remain editable by their author after the week ends.
- The Monday rule controls when the other person's previous-week entry can be read, not whether the author can edit their own entry.
